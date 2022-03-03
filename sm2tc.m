function twos_complement = sm2tc(signed_magnitude)
% Convert signed magnitude binary integers into two's complement binary
% integers.
% Procedure: for an input signed magnitude number (e.g. 10001111, or -15)
%   1. set sign bit (most significant bit) to 0:
%       10001111 --> 00001111
%   2. invert all bits:
%       00001111 --> 11110000
%   3. add 1:
%       11110000 --> 11110001

switch class(signed_magnitude)
    case 'int8'
        n_bits = 8;
    case 'int16'
        n_bits = 16;
    case 'int32'
        n_bits = 32;
    case 'int64'
        n_bits = 64;
    otherwise
        error('Input is not a signed integer type!')
end

sm_bset = bitset(signed_magnitude, n_bits, 0);
sm_invert = bitcmp(sm_bset);
twos_complement = sm_invert +1;

end