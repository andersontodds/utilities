function geom_lat = geog2geom(geog_lat, geog_long, height, decimalYear)
% Original function from Daniel Okoh on MATLAB File Exchange;
% adapted by Todd Anderson November 2022
% https://www.mathworks.com/matlabcentral/fileexchange/102219-convert-from-geographic-to-geomagnetic-coordinates?s_tid=prof_contriblnk
%   
%INPUTS:
%geog_lat: Geographic latitude, specified as a scalar or vector, in degrees. North latitude is positive and south latitude is negative.
%geog_long: Geographic longitude specified as a scalar or vector, in degrees. East longitude is positive and west longitude is negative.
%height: Distance from the surface of the Earth, specified as a scalar or vector, in meters.
%decimalYear: Year, in decimal format, specified as a scalar or vector. This value can have any fraction of the year that has already passed.
%The geog_lat, geog_long, height, and decimalYear arguments must all be the same size (scalars or vectors).
%OUTPUT
%geom_lat: Geomagnetic latitude, specified as a scalar or vector, in degrees. North latitude is positive and south latitude is negative.
%The size of geom_lat is same as the size of each of the inputs
%number of data points

n1=length(geog_lat);
n2=length(geog_long);
n3=length(height);
n4=length(decimalYear);

n = max([n1 n2 n3 n4]);

if length(geog_lat) < n
    geog_lat = geog_lat.*ones(n, 1);
end

if length(geog_long) < n
    geog_long = geog_long.*ones(size(geog_lat));
end

if length(height) < n
    height = height.*ones(size(geog_lat));
end

if length(decimalYear) < n
    decimalYear = decimalYear.*ones(size(geog_lat));
end

geom_lat=nan(size(geog_lat));
for i=1:n
    %First compute the magnetic dip I(also known as the magnetic inclination or dip angle)
    [~,~,~,I,~,~,~,~,~,~] = igrfmagm(height(i),geog_lat(i),geog_long(i),decimalYear(i));
    %Then compute the magnetic latitude (geom_lat) as: tand(MLAT)=0.5*tand(I)
    geom_lat(i)=atand(0.5*tand(I));
end