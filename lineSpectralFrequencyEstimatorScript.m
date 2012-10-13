close all; clear all;

addpath /Users/swrangsarbasumatary/Desktop/advancedSignalProcessingAssignment3/ch4/
addpath /Users/swrangsarbasumatary/Desktop/advancedSignalProcessingAssignment3/data/

load sunspotdata

N = 2 ^ nextpow2(4 * length(sunspot));
mag = 10 * log10(abs(fft(sunspot, N)));
figure(100); clf;
w = 0:length(mag)-1;
w = 2 * pi * w ./ length(mag);
plot(w, mag); axis tight;
title('Magnitude spectrum of sunspot data');
xlabel('Frequency (rad/s)');

clear all;


%% fot the loglynx data

load lynxdata

N = 2 ^ nextpow2(4 * length(loglynx));
mag = 10 * log10(abs(fft(loglynx, N)));
figure(200); clf;
w = 0:length(mag)-1;
w = 2 * pi * w ./ length(mag);
plot(w, mag); axis tight;
title('Magnitude spectrum of loglynx data');
xlabel('Frequency (rad/s)');




rmpath /Users/swrangsarbasumatary/Desktop/advancedSignalProcessingAssignment3/data/
rmpath /Users/swrangsarbasumatary/Desktop/advancedSignalProcessingAssignment3/ch4/