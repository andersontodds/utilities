module SolarAngles

using Dates

export localsolartime
export solarhourangle
export solarelevationangle
export horizondip

function localsolartime(time, longitude, timezone=0)
    # Calculate local solar time.
    # 
    # Sources: https://solarsena.com/solar-hour-angle-calculator-formula/
    #          https://en.wikipedia.org/wiki/Hour_angle#Solar_hour_angle
    
    DOY = Dates.day(time); # day of year
    
    hour = Dates.value(time - DateTime(Dates.year(time), Dates.month(time), Dates.day(time)))/(1000*60*60); # fractional hour
    
    gamma = (2*pi/365)*(DOY-1 + (hour-12)/24); # fractional year in radians
    
    # equation of time in minutes
    EoT = 229.18*(0.000075 + 0.001868*cos(gamma)
                           - 0.032077*sin(gamma)
                           - 0.014615*cos(2*gamma)
                           - 0.040849*sin(2*gamma));
    
    offset = EoT + 4*(longitude - 15*timezone);
    
    LST = hour + offset/60;
    return LST
    
end

function solarhourangle(time, longitude, timezone=0)
    # Calculate solar hour angle, the angle between the sun at local solar noon
    # and the sun at the desired time.
    #   SHA = 15 degrees * (LST - 12)
    # where LST is the local solar time in hours, and SHA is the solar hour
    # angle in degrees.  LST is calculated by the function localsolartime.m.
    
    
    LST = localsolartime(time, longitude, timezone);
    
    SHA = 15*(LST - 12);
    return SHA
end

function solarelevationangle(time, latitude, longitude, timezone=0)
    # Calculate the solar elevation angle, the angle between the sun-pointing
    # vector and the horizontal.
    
    # Inputs:
    # time: range of DateTime in either UT or another time zone
    # latitude, longitude: location of observer in degrees
    # timezone: time zone (interger hour GMT offset) for input time; leave blank if time is in UT

    # Outputs:
    # SEA: solare elevation angle in degrees
    
    DOY = Dates.day(time)
    
    SHA = solarhourangle(time, longitude, timezone); # in degrees
    
    declination = asind(sind(-23.44).*cosd((360/365.24).*(DOY + 10) + (360/pi).*(0.0167*sind((360/365.24).*(DOY - 2))))); # in degrees
    
    SEA = asind(sind(latitude).*sind(declination) + cosd(latitude).*cosd(declination).*cosd(SHA));
    return SEA
end

function horizondip(altitude, refraction)
    # calculate the dip angle to the horizon viewed from a given altitude
    # Sources:
    #   https://gis.stackexchange.com/questions/4690/determining-angle-down-to-horizon-from-different-flight-altitudes
    #   https://aty.sdsu.edu/explain/atmos_refr/dip.html
    # Note use of small-angle approximation (altitude << R), and assumption of
    # spherical Earth (no oblate correction)
    #
    # Inputs:
    #   altitude:   altitude of observer in meters
    #   refraction: refraction coefficient (unitless); 0.13 is typical for
    #               surveying purposes
    #
    # Outputs:
    #   hdip:       positive angle between the horizontal and the horizon
    
    # constants
    R = 6371.8E3;   # Earth radius in m
    #k = 0.13;       % atmosphere refraction ratio of curvatures
    
    # without refraction
    # hdip = sqrt(2*altitude/R);
    
    # with refraction
    # hdip = sqrt(2*altitude/(R/(1-refraction)));    % with small-angle approximation
    hdip = acos(R./(R+altitude.*(1-refraction)));
    hdip = rad2deg(hdip);
    return hdip
end

end