%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% SS2 Lab 3 Date: 05.06.2025 %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Shifat Jahan Shama 2667724 %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Md Sayed Hossen    2705341 %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Irteza Islam       2642103 %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 3: Dual Tones Analysis 

%% PROBLEM 3(b): Load and play audio file
[signal, fs] = audioread('touchtone1.wav');
fprintf('Playing touchtone1.wav...\n');
soundsc(signal, fs); % plays the loaded audio file
pause(length(signal)/fs + 1); % Waits for audio to finish plus 1 second

%% PROBLEM 3(c): Plot signal in time domain
figure(1);
t = (0:length(signal)-1)/fs;
plot(t, signal); % Keep as plot for audio (represents continuous-like signal)
xlabel('Time (s)');
ylabel('Amplitude');
title('Dual Tone Signal in Time Domain');
grid on;

%% PROBLEM 3(d): Plot amplitude spectrum
% Part 1: Plot over entire frequency range
N = length(signal);
X = fft(signal);
f = (0:N-1)*fs/N;

% Full spectrum plot (DFT coefficients are discrete)
figure(2);
subplot(2,1,1);
stem(f, abs(X), 'filled'); % Use stem for DFT coefficients
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Full Amplitude Spectrum of Dual Tone Signal (DFT)');
xlim([0 fs/2]);  % Apply xlim here to limit the frequency axis to [0, fs/2]
grid on;

% PROBLEM 3(d): Explain peaks at large frequencies
% Answer: Mirror/symmetry effect of real signals in frequency domain

% PROBLEM 3(d): Restricted frequency range for dual tones
% Part 2: Make plot restricted to DTMF range and verify expected frequencies
subplot(2,1,2);
% Finding indices for frequency range 600-1600 Hz
freq_indices = find(f >= 600 & f <= 1600);
stem(f(freq_indices), abs(X(freq_indices)), 'filled'); % Use stem for DFT
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Dual Tone Spectrum (600-1600 Hz Range)');
xlim([600 1600]);  % Range covering DTMF frequencies
grid on;

%% PROBLEM 3(e): Write DTMF generation function
% Function to generate dual tones is in generate_dualtones.m
% Parameters: fs = 8kHz, digit duration = 75ms, break duration = 30ms

%% PROBLEM 3(f): Create dual tone signal of your phone number
fprintf('\n=== ENTER YOUR PHONE NUMBER HERE ===\n');
phone_number = [0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 4, 6]; % *** Phone number ***
fprintf('Using phone number: ');
fprintf('%d', phone_number);


% Generate the dual tone signal
phone_signal = generate_dualtones(phone_number);

% PROBLEM 3(f): Play the phone number signal
soundsc(phone_signal, fs); % This will play phone number
pause(length(phone_signal)/fs + 1); % Wait for audio to finish

% PROBLEM 3(f): Plot phone number in time domain
figure(3);
t_phone = (0:length(phone_signal)-1)/fs;
subplot(2,1,1);
plot(t_phone, phone_signal); % Keep as plot for audio
xlabel('Time (s)');
ylabel('Amplitude');
title('Phone Number Dual Tone Signal in Time Domain');
grid on;

% PROBLEM 3(f): Plot phone number in frequency domain
N_phone = length(phone_signal);
X_phone = fft(phone_signal);
f_phone = (0:N_phone-1)*fs/N_phone;

subplot(2,1,2);
% Focus on DTMF frequency range
freq_indices_phone = find(f_phone >= 600 & f_phone <= 1600);
stem(f_phone(freq_indices_phone), abs(X_phone(freq_indices_phone)), 'filled');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Spectrum of Phone Number Dual Tone Signal');
xlim([600 1600]); % Range covering DTMF frequencies
grid on;

