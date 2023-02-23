function LST = localsolartime(time, longitude; timezone=0)
    # Calculate local solar time.
    # 
    # Sources: https://solarsena.com/solar-hour-angle-calculator-formula/
    #          https://en.wikipedia.org/wiki/Hour_angle#Solar_hour_angle
    
    DOY = Dates.day(time); # day of year
    
    hour = Dates.value(time - DateTime(Dates.year(time), Dates.month(time), Dates.day(time)))/(1000*60*60); # fractional hour
    
    gamma = (2*pi/365)*(DOY-1 + (hour-12)/24); # fractional year in radians
    
    # equation of time in minutes
    EoT = 229.18*(0.000075 + 0.001868*cos(gamma) ...
                           - 0.032077*sin(gamma) ...
                           - 0.014615*cos(2*gamma) ...
                           - 0.040849*sin(2*gamma));
    
    offset = EoT + 4*(longitude - 15*timezone);
    
    LST = hour + offset/60;
    
end