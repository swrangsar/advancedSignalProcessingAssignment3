close all; clear all;

addpath /Users/swrangsarbasumatary/Desktop/advancedSignalProcessingAssignment3/ch4/

[musicSpectrum1, minnormSpectrum1, espritSpectrun1] = frequencyEstimateOfLineSpectra(4, 12, 1);

figure(100); clf;
w = 0:(length(musicSpectrum1)-1);
w = 2 * pi * (w/length(musicSpectrum1));
musicplot = plot(w, musicSpectrum1);
hold on;
minnormplot = plot(w, minnormSpectrum1);
espritplot = plot(w, espritSpectrun1);
hold off;
axis tight;
title({'Frequency spectrum using MUSIC, '; 'min-norm(green) and ESPRIT(red) methods'});
set(minnormplot, 'Color', 'green');
set(espritplot, 'Color', 'red');



rmpath /Users/swrangsarbasumatary/Desktop/advancedSignalProcessingAssignment3/ch4/