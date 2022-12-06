function smoothed = smooth2(inputarray, smoothwidth, varargin)
% smooth2.m
% Todd Anderson
% December 5 2022
%
% Smooth a 2D array, such as latitude-longitude binned data.  Wrap edges.

rowwrap = smoothwidth;
colwrap = smoothwidth;
wrap = "lononly";
alg = "mean";

for i = 1:length(varargin)
    if lower(varargin{i}) == "wrapdims"
        rowwrap = varargin{i+1}(1);
        colwrap = varargin{i+1}(2);
    end

    if lower(varargin{i}) == "wrap"
        wrap = lower(varargin{i+1});
    end

    if lower(varargin{i}) == "alg"
        alg = lower(varargin{i+1});
    end
end

switch wrap
    case "lononly"
        rowwrap = 0;
        data_rowcolwrap = cat(2, inputarray(:,(end-colwrap+1):end), inputarray, inputarray(:,1:colwrap)); % no row-wrapping
    case "latlon"
        data_rowwrap = cat(1, flip(inputarray(1:rowwrap,:),1), inputarray, flip(inputarray((end-rowwrap+1):end,:),1));
        data_rowcolwrap = cat(2, data_rowwrap(:,(end-colwrap+1):end), data_rowwrap, data_rowwrap(:,1:colwrap));
    case "lonlat"
        data_rowwrap = cat(1, inputarray((end-rowwrap+1):end,:), inputarray, inputarray(1:rowwrap,:));
        data_rowcolwrap = cat(2, flip(data_rowwrap(:,1:colwrap),2), data_rowwrap, flip(data_rowwrap(:,(end-colwrap+1):end),2));
    case "reflectedges"
        data_rowwrap = cat(1, flip(inputarray(1:rowwrap,:),1), inputarray, flip(inputarray((end-rowwrap+1):end,:),1));
        data_rowcolwrap = cat(2, flip(data_rowwrap(:,1:colwrap),2), data_rowwrap, flip(data_rowwrap(:,(end-colwrap+1):end),2));
    case "asteroids"
        data_rowwrap = cat(1, inputarray((end-rowwrap+1):end,:), inputarray, inputarray(1:rowwrap,:));
        data_rowcolwrap = cat(2, data_rowwrap(:,(end-colwrap+1):end), data_rowwrap, data_rowwrap(:,1:colwrap));
end

switch alg
    case "mean"
        smoothed_1d = movmean(data_rowcolwrap, smoothwidth, 1, 'omitnan');
        smoothed_2d = movmean(smoothed_1d, smoothwidth, 2, 'omitnan');
    case "median"
        smoothed_1d = movmedian(data_rowcolwrap, smoothwidth, 1, 'omitnan');
        smoothed_2d = movmedian(smoothed_1d, smoothwidth, 2, 'omitnan');
end

smoothed = smoothed_2d(1+rowwrap:end-rowwrap, 1+colwrap:end-colwrap);

end