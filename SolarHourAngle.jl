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