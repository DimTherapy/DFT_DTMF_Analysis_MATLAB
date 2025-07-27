# DFT, Signal Spectrum & DTMF Generation in MATLAB

This repository implements and analyzes three digital signal processing tasks in MATLAB, as part of the course *Signals and Systems 2 – Lab 3* at HAW Hamburg.

## 🔧 Contents

1. **Custom DFT Implementation:**
   - Manual calculation of the Discrete Fourier Transform without using `fft`
   - Runtime comparison with MATLAB's `fft`
   - Performance profiling (`tic`, `toc`, `profile viewer`)

2. **Spectrum of a Rectangular Signal:**
   - Theoretical Fourier transform derivation
   - Sampling, spectrum resolution tuning, axis labeling
   - Impact of sample rate and signal duration on DFT shape

3. **DTMF Signal Analysis and Generation:**
   - Frequency analysis of real audio samples (e.g., touchtone.wav)
   - Dual-tone generation from digit vectors (e.g., telephone number)
   - Time & frequency domain visualization

## 🔍 Tools

- MATLAB
- Built-in signal processing functions (`fft`, `audioread`, `zplane`, etc.)
- Plots: Time domain, Frequency domain, Pole-zero, Spectra

## 📁 Files

- `.m` scripts and functions for each problem (grouped by task)
- `.wav` files for audio signal testing
- Plots and profile results (optional)

---

*Created during Information Engineering (B.Sc.), HAW Hamburg*
