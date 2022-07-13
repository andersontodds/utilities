function duplicates = isduplicate(input)
% Find duplicate values in array
% Procedure:
%   - Find indices of first unique values in array
%   - Define an array of all possible indices of the input array
%   - Delete indices of first unique values
%   -> all remaining indices are the indices of duplicate values in the
%   input
[~, I] = unique(input, "first");
duplicates = 1:length(input);
duplicates(I) = [];