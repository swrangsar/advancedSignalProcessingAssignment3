close all; clear all;

addpath /Users/swrangsarbasumatary/Desktop/advancedSignalProcessingAssignment3/ch4/

[dataSpectrum1, musicSpectrum1, minnormSpectrum1, espritSpectrum1] = frequencyEstimateOfLineSpectra(4, 12, 1);

w = -(length(musicSpectrum1)/2):(length(musicSpectrum1)/2-1);
w = 2 * pi * (w/length(musicSpectrum1));

figure(100); clf;
subplot(3, 1, 1);
plot(w, dataSpectrum1);
hold on;
musicplot = plot(w, musicSpectrum1);
hold off;
axis tight;
title('Frequency spectrum using MUSIC(green) and original');
xlabel('Frequency (hz)');
set(musicplot, 'Color', 'green');

subplot(3, 1, 2);
plot(w, dataSpectrum1);
hold on;
minnormplot = plot(w, minnormSpectrum1);
hold off;
axis tight;
title('Frequency spectrum using min-Norm(green) and original');
xlabel('Frequency (hz)');
set(minnormplot, 'Color', 'green');

subplot(3, 1, 3);
plot(w, dataSpectrum1);
hold on;
espritplot = plot(w, espritSpectrum1);
hold off;
axis tight;
title('Frequency spectrum using ESPRIT(green) and original');
xlabel('Frequency (hz)');
set(espritplot, 'Color', 'green');


rmpath /Users/swrangsarbasumatary/Desktop/advancedSignalProcessingAssignment3/ch4/