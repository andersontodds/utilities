function LST = localsolartime(time, longitude, timezone)
% Calculate local solar time.
% 
% Sources: https://solarsena.com/solar-hour-angle-calculator-formula/
%          https://en.wikipedia.org/wiki/Hour_angle#Solar_hour_angle
%   
%

timevec = datevec(time);

DOY = floor(datenum(time)) - datenum(timevec(:,1),1,0); % day of year

hour = (datenum(time) - floor(datenum(time)))*24; % fractional hour

gamma = (2*pi/365)*(DOY-1 + (hour-12)/24); % fractional year in radians

% equation of time in minutes
EoT = 229.18*(0.000075 + 0.001868*cos(gamma) ...
                       - 0.032077*sin(gamma) ...
                       - 0.014615*cos(2*gamma) ...
                       - 0.040849*sin(2*gamma));

offset = EoT + 4*(longitude - 15*timezone);

LST = hour + offset/60;

end