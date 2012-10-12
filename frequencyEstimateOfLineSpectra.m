function [musicEstimates, minnormEstimates, espritEstimates] = frequencyEstimateOfLineSpectra(modelOrder, totalOrder, variance)

numberOfRealizations = 50;
realizations = getMonteCarloRealizations(variance, numberOfRealizations);

musicEstimates = getMusicFrequencyEstimates(realizations, modelOrder, totalOrder);
minnormEstimates = getMinNormFrequencyEstimates(realizations, modelOrder, totalOrder);
espritEstimates = getESPRITFrequencyEstimates(realizations, modelOrder, totalOrder);

end


%% generate random number in [-pi, pi] with uniform distribution

function phaseMatrix = getPhaseMatrix(numberOfRealizations)

phaseMatrix = -pi + ((2 * pi) .* rand(numberOfRealizations, 2));

end


%% generate a single realization of the sinusoidal signal

function data = generateSingleRealization(phase1, phase2, variance)

N = 64; % as given in question
t = 1:N;
y = (10 * sin((0.24 * pi * t) + phase1)) + (5 * sin((0.26 * pi * t) + phase2));
whiteNoise = wgn(1, N, variance, 'linear');
y = y + whiteNoise;
data = y(:);

end

%% generate 50 monte carlo realizations

function realizations = getMonteCarloRealizations(variance, numberOfRealizations)

realizations = cell(numberOfRealizations, 1);
phaseMatrix = getPhaseMatrix(numberOfRealizations);

for k = 1:numberOfRealizations
    realizations{k} = generateSingleRealization(phaseMatrix(k, 1), phaseMatrix(k, 2), variance);
end

end

%% get the average frequency estimates of the monte carlo realizations using Music

function frequencyEstimatesMusic = getMusicFrequencyEstimates(realizations, modelOrder, totalOrder)

frequencyEstimates = cell(length(realizations), 1);

for k = 1:length(realizations)
    frequencyEstimates{k} = music(realizations(k), modelOrder, totalOrder);
end

frequencyEstimatesMusic = zeros(size(frequencyEstimates(1)));
for k = 1:length(frequencyEstimates)
    frequencyEstimatesMusic = frequencyEstimatesMusic + frequencyEstimates{k};
end
frequencyEstimatesMusic = frequencyEstimatesMusic ./ length(frequencyEstimates);

end


%% get the average frequency estimates of the monte carlo realizations using min-Norm

function frequencyEstimatesMinNorm = getMinNormFrequencyEstimates(realizations, modelOrder, totalOrder)

frequencyEstimates = cell(length(realizations), 1);

for k = 1:length(realizations)
    frequencyEstimates{k} = minnorm(realizations(k), modelOrder, totalOrder);
end

frequencyEstimatesMinNorm = zeros(size(frequencyEstimates(1)));
for k = 1:length(frequencyEstimates)
    frequencyEstimatesMinNorm = frequencyEstimatesMinNorm + frequencyEstimates{k};
end
frequencyEstimatesMinNorm = frequencyEstimatesMinNorm ./ length(frequencyEstimates);

end


%% get the average frequency estimates of the monte carlo realizations using ESPRIT

function frequencyEstimatesESPRIT = getESPRITFrequencyEstimates(realizations, modelOrder, totalOrder)

frequencyEstimates = cell(length(realizations), 1);

for k = 1:length(realizations)
    frequencyEstimates{k} = esprit(realizations(k), modelOrder, totalOrder);
end

frequencyEstimatesESPRIT = zeros(size(frequencyEstimates(1)));
for k = 1:length(frequencyEstimates)
    frequencyEstimatesESPRIT = frequencyEstimatesESPRIT + frequencyEstimates{k};
end
frequencyEstimatesESPRIT = frequencyEstimatesESPRIT ./ length(frequencyEstimates);

end
