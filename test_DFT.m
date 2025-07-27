%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% SS2L-1    Date: 30.04.2025 %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Shifat Jahan Shama 2667724 %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Md Sayed Hossen    2705341 %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Test DFT implementation with complex inputs and edge cases

% Test Case 1: Single complex value
disp('=== Test Case 1: Single Complex Value ===');
test_complex = 1+2j;
my_dft_result = myDFT(test_complex);
matlab_fft_result = fft(test_complex);
disp('Input: 1+2j');
disp('My DFT:');
disp(my_dft_result);
disp('MATLAB FFT:');
disp(matlab_fft_result);
disp(['Maximum difference: ', num2str(max(abs(my_dft_result - matlab_fft_result)))]);
disp(' ');

% Test Case 2: Complex vector
disp('=== Test Case 2: Complex Vector ===');
test_complex_vector = [1+2j, 3-4j, 5+0j, 0-1j];
my_dft_result = myDFT(test_complex_vector);
matlab_fft_result = fft(test_complex_vector);
disp('Input: [1+2j, 3-4j, 5+0j, 0-1j]');
disp('My DFT:');
disp(my_dft_result);
disp('MATLAB FFT:');
disp(matlab_fft_result);
disp(['Maximum difference: ', num2str(max(abs(my_dft_result - matlab_fft_result)))]);
disp(' ');

% Test Case 3: Using scalar input to generate sequence with negative number
disp('=== Test Case 3: Negative Scalar Input ===');
try
    disp('Trying myDFT(-4):');
    result = myDFT(-4);
    disp('Result:');
    disp(result);
catch err
    disp(['Error: ', err.message]);
    disp('Consider handling negative inputs in your function');
end
disp(' ');

% Test Case 4: Edge case - single value input
disp('=== Test Case 4: Single Value Input ===');
test_single = 5;
my_dft_result = myDFT(test_single);
matlab_fft_result = fft(1:test_single); % Since myDFT(5) should create [1,2,3,4,5]
disp(['Input: ', num2str(test_single), ' (should create sequence 1:', num2str(test_single), ')']);
disp('My DFT:');
disp(my_dft_result);
disp('MATLAB FFT:');
disp(matlab_fft_result);
disp(['Maximum difference: ', num2str(max(abs(my_dft_result - matlab_fft_result)))]);
disp(' ');

% Test Case 5: Edge case - single complex value with special meaning
disp('=== Test Case 5: Single Complex Value with Special Input ===');
test_special = 1j;
my_dft_result = myDFT(test_special);
matlab_fft_result = fft(test_special);
disp('Input: 1j');
disp('My DFT:');
disp(my_dft_result);
disp('MATLAB FFT:');
disp(matlab_fft_result);
disp(['Maximum difference: ', num2str(max(abs(my_dft_result - matlab_fft_result)))]);
disp(' ');

% Test Case 6: Zero input
disp('=== Test Case 6: Zero Input ===');
try
    disp('Trying myDFT(0):');
    result = myDFT(0);
    disp('Result:');
    disp(result);
catch err
    disp(['Error: ', err.message]);
    disp('Consider handling zero input in your function');
end