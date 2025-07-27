%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% SS2L-1    Date: 30.04.2025 %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Shifat Jahan Shama 2667724 %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Md Sayed Hossen    2705341 %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function X = myDFT(x)
% myDFT - Computes DFT of input x (vector or sequence length)
% If x is a positive integer, computes DFT of [1,2,...,x]
if isscalar(x) && isreal(x) && x == round(x) && x > 0
    x = 1:x;  % Convert scalar to sequence
end
x = x(:);     % Ensure column vector
N = length(x);
k = 0:N-1;
n = 0:N-1;
exponent = -1j * 2*pi/N * (k' * n);
X = exp(exponent) * x;
end