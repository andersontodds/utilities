function SEA = solarelevationangle(time, latitude, longitude; timezone=0)
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

end