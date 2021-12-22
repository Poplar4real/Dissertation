%function x = LFM()
%myFun - Description
%This code if for generating LFM Code
% Syntax: x = LFM()
%
% Long description
 
close all;
clear;
    
fs = 1200e6; Ts = 1/fs;                    %sample frequency 
fc = fs/6 + rand*(fs/5-fs/6);            %carrier frequency
B = fs/20+rand*(fs/16-fs/20);            %Bandwidth
N = 512+randi(1920-512);                 %rand length of signal
T = N*Ts;                                %total time
k = B/T;
t = linspace(-T/2,T/2,N);                        %set up time vector


s = exp(1i*k*pi*t.^2);                   %LFM Signal

figure(1)
subplot(2,1,1);
plot(t*10e6,real(s));
set(get(gca, 'XLabel'), 'String', 't/us');
set(get(gca, 'YLabel'), 'String', 'Amplitude');
set(get(gca, 'Title'), 'String', 'LFM Real part');
subplot(2,1,2);
plot(t*10e6,imag(s));
set(get(gca, 'XLabel'), 'String', 't/us');
set(get(gca, 'YLabel'), 'String', 'Amplitude');
set(get(gca, 'Title'), 'String', 'LFM Imagine part');


figure(2)
f = linspace(-fs/2,fs/2,N);         %setup frequency vector
plot(f*10e-6,fftshift(abs(fft(s))));
set(get(gca, 'Title'), 'String', 'LFM Spectrum');
set(get(gca, 'XLabel'), 'String', 'f/MHz');
set(get(gca, 'YLabel'), 'String', 'Amplitude');

%end