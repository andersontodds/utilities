function dip = horizondip(altitude)
% calculate the dip angle to the horizon viewed from a given altitude
% Sources:
%   https://gis.stackexchange.com/questions/4690/determining-angle-down-to-horizon-from-different-flight-altitudes
%   https://aty.sdsu.edu/explain/atmos_refr/dip.html
% Note use of small-angle approximation (altitude << R), and assumption of
% spherical Earth (no oblate correction)

% constants
R = 6371.8E3;   % Earth radius
k = 0.13;       % atmosphere refraction ratio of curvatures

% without refraction
% dip = sqrt(2*altitude/R);

% with refraction
dip = sqrt(2*altitude/(R/(1-k)));

end