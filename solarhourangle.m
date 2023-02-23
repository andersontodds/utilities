function SHA = solarhourangle(time, longitude, timezone)
% Calculate solar hour angle, the angle between the sun at local solar noon
% and the sun at the desired time.
%
% SHA = 15 degrees * (LST - 12)
%
% where LST is the local solar time in hours, and SHA is the solar hour
% angle in degrees.  LST is calculated by the function localsolartime.m.

if ~exist('timezone', 'var')
    % no timezone specified; default to 0
    timezone = 0;
end

LST = localsolartime(time, longitude, timezone);

SHA = 15*(LST - 12);
end