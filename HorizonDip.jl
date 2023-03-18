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