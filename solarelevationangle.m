function SEA = solarelevationangle(time, latitude, longitude, timezone)
% Calculate the solar elevation angle, the angle between the sun-pointing
% vector and the horizontal.
%
% Inputs:
%   time: range of time in either UT or another time zone
%   latitude, longitude: location of observer
%   timezone: time zone for input time; leave blank if time is in UT

if ~exist('timezone', 'var')
    % no timezone specified; default to 0
    timezone = 0;
end

timevec = datevec(time);

DOY = floor(datenum(time)) - datenum(timevec(:,1),1,0); % day of year

SHA = solarhourangle(time, longitude, timezone); % in degrees

declination = asind(sind(-23.44).*cosd((360/365.24).*(DOY + 10) + (360/pi).*(0.0167*sind((360/365.24).*(DOY - 2))))); % in degrees

SEA = asind(sind(latitude).*sind(declination) + cosd(latitude).*cosd(declination).*cosd(SHA));