close all; clear all;

addpath /Users/swrangsarbasumatary/Desktop/advancedSignalProcessingAssignment3/ch4/
addpath /Users/swrangsarbasumatary/Desktop/advancedSignalProcessingAssignment3/data/

load sunspotdata

lineSpectralFrequencyEstimator(sunspot, 2);
lineSpectralFrequencyEstimator(sunspot, 4);
lineSpectralFrequencyEstimator(sunspot, 8);

clear all;


%% plot the loglynx data

load lynxdata

lineSpectralFrequencyEstimator(loglynx, 2);
lineSpectralFrequencyEstimator(loglynx, 4);
lineSpectralFrequencyEstimator(loglynx, 8);

rmpath /Users/swrangsarbasumatary/Desktop/advancedSignalProcessingAssignment3/data/
rmpath /Users/swrangsarbasumatary/Desktop/advancedSignalProcessingAssignment3/ch4/