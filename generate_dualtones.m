function y = generate_dualtones(digits)
    % generate_dualtones - Generate dual tone signals for a sequence of digits
    % Input: digits - vector of digits (0-9, * as 10, # as 11)
    % Output: y - audio signal containing the dual tones
    
    % Parameters
    fs = 8000;                    % Sampling frequency (Hz)
    digit_duration = 0.075;       % Duration per digit (75 ms)
    break_duration = 0.030;       % Duration of break between digits (30 ms)
    
    % DTMF frequency table
    row_freqs = [697, 770, 852, 941];      % Row frequencies for digits 1 to 4
    col_freqs = [1209, 1336, 1477];        % Column frequencies correspond to digits 1, 2, and 3
    %these specific frequencies because they are the standard DTMF (Dual-Tone Multi-Frequency) 
    % telephone keypad tones defined by the ITU-T Recommendation Q.23. Each digit 
    % is encoded using one low-frequency (row) and one high-frequency (column) 
    % tone to reduce misdetection and allow reliable signal separation.
    
    % Mapping of digits to row and column indices
    % For digits 1-9:
    %   row = floor((digit-1)/3) + 1
    %   col = mod(digit-1, 3) + 1
    % Special cases for *, 0, #
    
    % preallocates space by estimating the total number of audio samples needed 
    % for all digits and breaks in the DTMF signal.
    total_samples = length(digits) * (fs * digit_duration + fs * break_duration);
    y = zeros(total_samples, 1); 
    index = 1;  % Initialize index to track position in y
    
    % Process each digit
    for d = digits
        % Handle special characters
        if d == '*'
            row = 4; col = 1;
        elseif d == '#'
            row = 4; col = 3;
        elseif d == 0
            row = 4; col = 2;
        else
            row = floor((d-1)/3) + 1;
            col = mod(d-1, 3) + 1;
        end
% Processing Each Digit: The function iterates over each digit in the input vector digits. 
% If the digit is *, 0, or #, it assigns the appropriate row and column frequency. 
% For other digits (1-9), it calculates the row and column based on the formula provided

        % Get frequencies for this digit
        f1 = row_freqs(row);
        f2 = col_freqs(col);
        
        % Generate time vector for this digit
        t = (0:1/fs:digit_duration-1/fs)';  % Time vector for the tone
        
        % Generate dual tone signal (sum of two sine waves)
        digit_signal = sin(2*pi*f1*t) + sin(2*pi*f2*t);

% This line generates the dual-tone signal for the current digit. 
% It combines two sine waves, one with frequency f1 (the row frequency) 
% and one with frequency f2 (the column frequency), creating a combined tone.
        
        % Normalize amplitude
        digit_signal = 0.5 * digit_signal;
% The amplitude of the generated tone is scaled by 0.5 to ensure 
% it doesn't exceed the maximum value and is appropriately scaled for audio playback.
        
        % Generate silence for break
        break_signal = zeros(round(break_duration*fs), 1);
        
%This line creates a break (silence) between the tones. 
% The break duration is break_duration (30 ms), and the silence 
% is represented by a vector of zeros.

% generated tone for the current digit (digit_signal) and the break 
% (break_signal) are appended to the output signal y. This ensures that 
% the final output contains both the tones 
% for each digit and the necessary silences between them.   

        % Append to preallocated output signal
        y(index:index + length(digit_signal) - 1) = digit_signal;  % Place digit signal
        index = index + length(digit_signal);  % Update index
        
        y(index:index + length(break_signal) - 1) = break_signal;  % Place break signal
        index = index + length(break_signal);  % Update index
    end
end
