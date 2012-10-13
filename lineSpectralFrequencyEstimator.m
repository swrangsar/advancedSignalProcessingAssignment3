function lineSpectralFrequencyEstimator(data, modelOrder)

totalOrder = 3 * modelOrder;
count = 2 * length(data);
[musicSpectrum, minnormSpectrum, espritSpectrum] = ...
    getFrequencySpectra(data, modelOrder, totalOrder, count);
dataSpectrum = getDataSpectrum(data, count);
subplotDouble(dataSpectrum, musicSpectrum, minnormSpectrum, espritSpectrum);


end

%% get the frequency spectra using MUSIC, min-Norm and ESPRIT methods

function [musicSpectrum, minnormSpectrum, espritSpectrum] ...
    = getFrequencySpectra(data, modelOrder, totalOrder, count)

frequenciesMusic = music(data, modelOrder, totalOrder);
frequenciesMinNorm = minnorm(data, modelOrder, totalOrder);
frequenciesEsprit = esprit(data, modelOrder, totalOrder);

musicSpectrum = getSpectrum(frequenciesMusic, count);
minnormSpectrum = getSpectrum(frequenciesMinNorm, count);
espritSpectrum = getSpectrum(frequenciesEsprit, count);

end

%% get the spectrum of given frequencies

function estimatedSpectrum = getSpectrum(frequencyEstimates, N)

t = 1:N;

x = zeros(size(t));
for k = 1:length(frequencyEstimates)
    x = x + (exp(1i * frequencyEstimates(k) .* t));
end

% now get the spectrum using fft

M = 2 ^ nextpow2(4 * length(x));
estimatedSpectrum = 10 *log10(abs(fftshift(fft(x, M))));

end

%% get the spectrum of the input data

function dataSpectrum = getDataSpectrum(data, N)

M = 2 ^ nextpow2(4 * N); 
dataSpectrum = 10 * log10(abs(fftshift(fft(data, M))));

end

%% superpose two subplots

function subplotDouble(dataSpectrum, musicSpectrum, minnormSpectrum, espritSpectrum)

w = 0:length(dataSpectrum)-1;
w = 2 * pi * w ./ length(dataSpectrum);

figure;
subplot(3, 1, 1);
plot(w, dataSpectrum);
hold on;
p = plot(w, musicSpectrum);
hold off;
axis tight;
title('Music spectrum (green) over data spectrum');
xlabel('Frequency (rad/s)');
set(p, 'Color', 'green');

subplot(3, 1, 2);
plot(w, dataSpectrum);
hold on;
p = plot(w, minnormSpectrum);
hold off;
axis tight;
title('Min-norm spectrum (green) over data spectrum');
xlabel('Frequency (rad/s)');
set(p, 'Color', 'green');

subplot(3, 1, 3);
plot(w, dataSpectrum);
hold on;
p = plot(w, espritSpectrum);
hold off;
axis tight;
title('ESPRIT spectrum (green) over data spectrum');
xlabel('Frequency (rad/s)');
set(p, 'Color', 'green');

end