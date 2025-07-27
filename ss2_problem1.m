%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% SS2L-1    Date: 30.04.2025 %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Shifat Jahan Shama 2667724 %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Md Sayed Hossen    2705341 %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ss2_problem1(n)
    % SS2_PROBLEM1 Demonstrates the sampling theorem
    %   This function shows signal reconstruction from samples with varying
    %   sampling rates controlled by parameter n:
    %   - n: Controls sampling frequency (larger n means lower sampling freq)
    %   - First subplot: Original signal x(t) and samples x_k
    %   - Second subplot: Reconstructed signal using the sampling theorem
    %
    % Usage:
    %   ss2_problem1(10)  % Sampling theorem is satisfied
    %   ss2_problem1(30)  % Sampling theorem is violated
    
    % Check if input argument is provided
    if nargin < 1
        error('Please provide a value for n. Example: ss2_problem1(10)');
    end
    
    % Time interval parameters
    t_start = 0.0025;
    t_end = 1;
    T = 0.0025; % Temporal resolution
    
    % Generate time vector
    t = t_start:T:t_end;
    
    % Original signal x(t)
    x = 4*sin(2*pi*t) + cos(pi/4 + 16*pi*t);
    
    % Sampling interval
    Ts = T*n;
    
    % Sample the signal
    x_sampled_indices = 1:n:length(t);
    t_sampled = t(x_sampled_indices);
    x_sampled = x(x_sampled_indices);
    
    % Create the figure with two subplots
    figure;
    
    % First subplot: Original signal and samples
    subplot(2, 1, 1);
    plot(t, x, 'b-', 'LineWidth', 1.5); hold on;
    stem(t_sampled, x_sampled, 'r', 'filled', 'LineWidth', 1);
    title(['Original Signal and Samples (n = ', num2str(n), ', Ts = ', num2str(Ts), ' s)']);
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
    legend('Original Signal x(t)', 'Samples x_k');
    
    % Second subplot: Reconstructed signal
    subplot(2, 1, 2);
    
    % Initialize the reconstructed signal
    x_reconstructed = zeros(size(t));
    
    % Custom sinc function implementation
    my_sinc = @(x) sin(pi*x)./(pi*x + eps);  % Adding eps to avoid division by zero
    
    % For each time point in the reconstructed signal
    for i = 1:length(t)
        % Sum the contributions from all samples
        for k = 1:length(t_sampled)
            % Using the custom sinc function
            arg = (t(i) - t_sampled(k))/Ts;
            if arg == 0
                sinc_val = 1;  % sinc(0) = 1
            else
                sinc_val = my_sinc(arg);
            end
            x_reconstructed(i) = x_reconstructed(i) + x_sampled(k) * sinc_val;
        end
    end
    
    % Plot the reconstructed signal
    plot(t, x_reconstructed, 'g-', 'LineWidth', 1.5); hold on;
    plot(t, x, 'b--', 'LineWidth', 1);
    title('Signal Reconstruction');
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
    legend('Reconstructed Signal \tilde{x}(t)', 'Original Signal x(t)');
    
    % Calculate frequencies and check if sampling theorem is satisfied
    fs = 1/Ts; % Sampling frequency
    f_max = 8; % Maximum frequency in the signal (from the cos component)
    
    fprintf('Sampling frequency fs = %.2f Hz\n', fs);
    fprintf('Maximum signal frequency f_max = %.2f Hz\n', f_max);
    fprintf('Nyquist frequency = %.2f Hz\n', 2*f_max);
    
    if fs > 2*f_max
        fprintf('Sampling theorem is satisfied (fs > 2*f_max)\n');
    else
        fprintf('Sampling theorem is NOT satisfied (fs < 2*f_max)\n');
    end
    
    % Adjust the figure size and layout
    set(gcf, 'Position', [100, 100, 800, 600]);
end