%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% SS2 Lab 3 Date: 05.06.2025 %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Shifat Jahan Shama 2667724 %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Md Sayed Hossen    2705341 %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Irteza Islam       2642103 %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Problem 2: Spectrum of a rectangular signal 

% Parameters
fs = 8000; % Sampling frequency (Hz)
duration = 0.004; % Signal duration (4 ms)
N = 2^nextpow2(fs*duration); % Number of samples (power of 2)

% Time vector
t = (0:N-1)/fs; % Time vector (seconds)
n = 0:N-1; % Sample index vector for stem plots

% Create rectangular signal (2 ms duration)
x = zeros(size(t));
x(t >= 0 & t <= 0.002) = 1; % Rectangular pulse from 0 to 2 ms

% Plot the signal in time domain using STEM (discrete signal)
figure(1);
stem(n, x, 'filled'); % Use stem for discrete signal
xlabel('Sample Index n');
ylabel('Amplitude');
title('Rectangular Signal (2 ms duration) - Discrete Samples');
grid on;

% Alternative: plot with time axis in ms
figure(2);
stem(t*1000, x, 'filled'); % Convert time to ms
xlabel('Time (ms)');
ylabel('Amplitude');
title('Rectangular Signal (2 ms duration) - Time Domain');
grid on;

%% PROBLEM 2(b)(ii): Plot amplitude spectrum using DFT
% Compute DFT using our implementation
X = myDFT(x);

% Frequency vector for full spectrum (-fs/2 to fs/2)
f_full = (-N/2:N/2-1)*fs/N; % Frequency range from -fs/2 to fs/2
X_shifted = fftshift(X); % Shift DFT output to center zero frequency

% Debug: Display frequency range
fprintf('Frequency range: %.1f Hz to %.1f Hz\n', min(f_full), max(f_full));

% Plot full amplitude spectrum using STEM (discrete DFT)
figure(3);
stem(f_full, abs(X_shifted), 'filled'); % Use stem for DFT coefficients
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Amplitude Spectrum of Rectangular Signal (DFT) - Full Spectrum');
xlim([-4000, 4000]);  % Show full spectrum from -4000 to +4000 Hz
ylim([0, max(abs(X_shifted))*1.1]); % Set y-axis limits
grid on;

% Check zeros of the spectrum (using full spectrum)
expected_zeros = [-4000:500:-500, 500:500:4000]; % Expected zeros at multiples of ±500 Hz
disp('Expected zeros at:');
disp(expected_zeros);

% Find approximate zeros   ??
threshold = 0.1 * max(abs(X_shifted)); % 10% of max amplitude
zero_indices = find(abs(X_shifted) < threshold);
actual_zeros = f_full(zero_indices);
disp('Actual zeros (approximate) at:');
disp(actual_zeros(1:min(10, length(actual_zeros)))); % Show first few zeros

%% PROBLEM 2(b)(iii): Frequency resolution - Effect of increasing N
% Which parameter increases frequency resolution? Answer: N
% Use zeros to verify DFT approaches expected spectrum when resolution increases
N_values = [2^10, 2^12, 2^14]; % Experimenting with different N values
figure(4);
for i = 1:length(N_values)
    N_new = N_values(i);  % New N value
    t_new = (0:N_new-1)/fs;  % Time vector for new N
    x_new = zeros(size(t_new));  % Initialize new signal
    x_new(t_new >= 0 & t_new <= 0.002) = 1; % Rectangular pulse from 0 to 2 ms
    
    % Compute DFT using MATLAB's fft function
    X_new = fft(x_new);  % Using MATLAB's FFT for speed
    
    % Full spectrum approach
    f_full_new = (-N_new/2:N_new/2-1)*fs/N_new;  % Full frequency range
    X_shifted_new = fftshift(X_new);  % Shift for full spectrum
    
    % Plot the amplitude spectrum for each N value
    subplot(length(N_values), 1, i);
    stem(f_full_new, abs(X_shifted_new), 'filled'); % Plot DFT coefficients
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    title(['Spectrum with N = ', num2str(N_new), ' points - Full Spectrum']);
    xlim([-4000, 4000]);  % Limit frequency range for clarity
    grid on;
    
    % Displaying zeros of the spectrum for the new signal
    threshold = 0.1 * max(abs(X_shifted_new));  % 10% of maximum amplitude
    zero_indices = find(abs(X_shifted_new) < threshold);  % Find zeros
    actual_zeros_new = f_full_new(zero_indices);  % Corresponding zeros
    disp(['For N = ', num2str(N_new), ', Actual zeros (approximate) at:']);
    disp(actual_zeros_new(1:min(10, length(actual_zeros_new))));  % Show first few zeros
    
    % Verify that the zeros approach the expected zeros as N increases
    for k = 1:length(expected_zeros)
        if any(abs(actual_zeros_new - expected_zeros(k)) < 10) % Allow 10 Hz tolerance
            disp(['Expected zero at ', num2str(expected_zeros(k)), ' Hz found in DFT for N = ', num2str(N_new)]);
        else
            disp(['Expected zero at ', num2str(expected_zeros(k)), ' Hz NOT found in DFT for N = ', num2str(N_new)]);
        end
    end
end

%% PROBLEM 2(b)(iv): Effect of increasing sampling frequency fs
% How does the spectrum change when fs is increased?
fs_values = [8000, 16000, 32000];  % Different fs values for comparison
figure(5);
for i = 1:length(fs_values)
    fs_new = fs_values(i);  % New sampling frequency
    N_new = 2^12;  % Fixed number of points
    t_new = (0:N_new-1)/fs_new;  % Time vector for new fs
    x_new = zeros(size(t_new));  % Initialize new signal with new fs
    x_new(t_new >= 0 & t_new <= 0.002) = 1;  % Rectangular pulse from 0 to 2 ms
    
    % Compute DFT using MATLAB's fft function
    X_new = fft(x_new);  % Using MATLAB's FFT for speed
    
    % Full spectrum approach
    f_full_new = (-N_new/2:N_new/2-1)*fs_new/N_new;  % Full frequency range
    X_shifted_new = fftshift(X_new);  % Shift for full spectrum
    
    % Plotting the amplitude spectrum for each fs value
    subplot(length(fs_values), 1, i);
    stem(f_full_new, abs(X_shifted_new), 'filled');  % Plot DFT coefficients
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    title(['Spectrum with fs = ', num2str(fs_new), ' Hz - Full Spectrum']);
    xlim([-4000, 4000]);  % Focus on the first few zeros
    grid on;
end
sgtitle('Effect of Sampling Frequency on Spectrum - Full Spectrum');

% Zero analysis for the spectrum (Original signal)
threshold_ratio = 0.01;  % Use 1% of maximum amplitude as threshold
threshold = threshold_ratio * max(abs(X_shifted)); % More realistic threshold

% Find zero indices in the spectrum for the original signal (values close to zero)
zeros_original = find(abs(X_shifted) < threshold); 

% Better approach: Find local minima instead of exact zeros
[~, local_min_original] = findpeaks(-abs(X_shifted), 'MinPeakHeight', -max(abs(X_shifted))*0.9);

% Plot the original signal's amplitude spectrum and zero locations
figure(6);

% Subplot 1: Amplitude spectrum of the original signal (2 ms duration)
subplot(2,2,1);
stem(f_full, abs(X_shifted), 'filled');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Amplitude Spectrum - Original Signal (2 ms) - Full Spectrum');
xlim([-4000, 4000]);
ylim([0, max(abs(X_shifted))*1.1]);
grid on;

% Subplot 3: Zero locations for the original signal
subplot(2,2,3);
if ~isempty(zeros_original)  % Check if there are any valid zeros
    % Plot the zero locations for the original signal, showing them in red
    stem(f_full(zeros_original), zeros(length(zeros_original), 1), 'r', 'filled'); 
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    title('Zero Locations - Original Signal');
    xlim([-4000, 4000]);
    ylim([-1, 1]);
    grid on;
    
    % Also show local minima in green
    if ~isempty(local_min_original)
        hold on;
        stem(f_full(local_min_original), zeros(length(local_min_original), 1), 'g', 'filled');
        legend('Threshold Zeros', 'Local Minima', 'Location', 'best');
        hold off;
    end
else
    % If no threshold zeros found, just show local minima
    if ~isempty(local_min_original)
        stem(f_full(local_min_original), zeros(length(local_min_original), 1), 'g', 'filled');
        xlabel('Frequency (Hz)');
        ylabel('Amplitude');
        title('Local Minima (Approximate Zeros) - Original Signal');
        xlim([-4000, 4000]);
        ylim([-1, 1]);
        grid on;
    else
        title('Zero Locations - Original Signal (No zeros found)');
        xlabel('Frequency (Hz)');
        ylabel('Amplitude');
        xlim([-4000, 4000]);
        ylim([-1, 1]);
        grid on;
    end
end

% Create the extended rectangular signal for better frequency resolution
extended_duration = 0.02; % 20 ms duration for higher resolution
N_extended = 2^nextpow2(fs*extended_duration);  % Extended number of samples

% Time vector for extended signal
t_extended = (0:N_extended-1)/fs; % Extended time vector

% Create the extended rectangular signal (still 2 ms pulse)
x_extended = zeros(size(t_extended));
x_extended(t_extended >= 0 & t_extended <= 0.002) = 1; 

% Compute DFT for the extended signal
X_extended = myDFT(x_extended);

% Full spectrum for extended signal
f_full_extended = (-N_extended/2:N_extended/2-1)*fs/N_extended;
X_shifted_extended = fftshift(X_extended);

% Zero analysis for the extended spectrum (Extended signal)
threshold_extended = threshold_ratio * max(abs(X_shifted_extended));
zeros_extended = find(abs(X_shifted_extended) < threshold_extended); 

% Find local minima for extended signal
[~, local_min_extended] = findpeaks(-abs(X_shifted_extended), 'MinPeakHeight', -max(abs(X_shifted_extended))*0.9);

% Subplot 2: Amplitude spectrum of the extended signal (20 ms duration)
subplot(2,2,2);
stem(f_full_extended, abs(X_shifted_extended), 'filled');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Amplitude Spectrum - Extended Signal (20 ms) - Full Spectrum');
xlim([-4000, 4000]);
ylim([0, max(abs(X_shifted_extended))*1.1]);
grid on;

% Subplot 4: Zero locations for the extended signal
subplot(2,2,4);
if ~isempty(zeros_extended)  % Check if there are any valid zeros
    stem(f_full_extended(zeros_extended), zeros(length(zeros_extended), 1), 'r', 'filled');
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    title('Zero Locations - Extended Signal');
    xlim([-4000, 4000]);
    ylim([-1, 1]);
    grid on;
    
    % Also show local minima
    if ~isempty(local_min_extended)
        hold on;
        stem(f_full_extended(local_min_extended), zeros(length(local_min_extended), 1), 'g', 'filled');
        legend('Threshold Zeros', 'Local Minima', 'Location', 'best');
        hold off;
    end
else
    % If no threshold zeros found, just show local minima
    if ~isempty(local_min_extended)
        stem(f_full_extended(local_min_extended), zeros(length(local_min_extended), 1), 'g', 'filled');
        xlabel('Frequency (Hz)');
        ylabel('Amplitude');
        title('Local Minima (Approximate Zeros) - Extended Signal');
        xlim([-4000, 4000]);
        ylim([-1, 1]);
        grid on;
    else
        title('Zero Locations - Extended Signal (No zeros found)');
        xlabel('Frequency (Hz)');
        ylabel('Amplitude');
        xlim([-4000, 4000]);
        ylim([-1, 1]);
        grid on;
    end
end

% Display found zeros
disp('Original signal zeros/minima at frequencies:');
if ~isempty(zeros_original)
    disp(['Threshold zeros: ', num2str(f_full(zeros_original))]);
end
if ~isempty(local_min_original)
    disp(['Local minima: ', num2str(f_full(local_min_original))]);
end

% Overall title for the figure
sgtitle('Frequency Resolution and Zero Locations Comparison - Full Spectrum');

%% ========================================================================
%% SUMMARY OF RESULTS FOR PROBLEM 2
%% ========================================================================
% Summary of key findings
signal_duration = 0.002; % 2ms pulse duration
fprintf('\n=== PROBLEM 2 RESULTS SUMMARY ===\n');
fprintf('2(a)(ii) Maximum at f = 0 Hz with value %.4f V·s\n', signal_duration);
fprintf('2(a)(iii) Zeros at f = ±k × %.0f Hz (k = 1,2,3,...)\n', 1/signal_duration);
fprintf('2(b)(iii) To improve frequency resolution: Increase N (Δf = fs/N)\n');
fprintf('2(b)(iv) Increasing fs: Same spectrum shape, wider frequency range\n');
fprintf('Full spectrum now displayed from -%.0f Hz to +%.0f Hz\n', fs/2, fs/2);