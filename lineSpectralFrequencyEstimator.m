function [dataSpectrum, musicSpectrum, minnormSpectrum, espritSpectrum] ...
    = lineSpectralFrequencyEstimator(data, modelOrder)

totalOrder = 3 * modelOrder;
count = 400;
[musicSpectrum, minnormSpectrum, espritSpectrum] = ...
    getFrequencySpectra(data, modelOrder, totalOrder, count);
dataSpectrum = getDataSpectrum(data, count);

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
estimatedSpectrum = abs(fftshift(fft(x, M)));

end

%% get the spectrum of the input data

function dataSpectrum = getDataSpectrum(data, N)

M = 2 ^ nextpow2(4 * N); 
dataSpectrum = abs(fftshift(fft(data, M)));

end

%% superpose two subplots

function subplotDouble(dataSpectrum, musicSpectrum, minnormSpectrum, espritSpectrum)

figure(100); clf;
subplot(3, 1, 1);
plot(dataSpectrum);
hold on;
p = plot(musicSpectrum);
hold off;
axis tight;
set(p, 'Color', 'green');

subplot(3, 1, 2);
plot(dataSpectrum);
hold on;
p = plot(minnormSpectrum);
hold off;
axis tight;
set(p, 'Color', 'green');

subplot(3, 1, 3);
plot(dataSpectrum);
hold on;
p = plot(espritSpectrum);
hold off;
axis tight;
set(p, 'Color', 'green');

end