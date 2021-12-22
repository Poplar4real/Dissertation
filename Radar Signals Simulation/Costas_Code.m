%function x = Costa_Code()
%myFun - Description
%This function is used to generate Costa Code.
% Syntax: x = Costa_Code()
%
% Long description
    
clc;clear all;

A = 1;                                   %Amplitude
fs = 1200e6; Ts = 1/fs;                    %sample frequency 
fc = fs/6 + rand*(fs/5-fs/6);            %carrier frequency
SAR = floor(fs/fc);                      %sample rate
k = randi(3);                            %index of frequency sequence
N = 512 + randi(1920-512);               %length of samples

if k==1
    freq = [3 2 6 4 5 1].*10e6;
elseif k==2
    freq = [5 4 6 2 3 1].*10e6;
else
    freq = [2 4 8 5 10 9 7 3 6 1].*10e6;
end

N_f = length(freq);
np = fix(N/N_f);                %samples per fre                
n = 1:np;                       %set up vectors for modulated signal
t = 0:Ts:np*N_f*Ts-Ts;          %set up time vector

index = 0;
for i = 1:N_f
        I((i-1)*np+1:i*np) = A*cos(2*pi*freq(i).*t((i-1)*np+1:i*np));
        Q((i-1)*np+1:i*np) = A*sin(2*pi*freq(i).*t((i-1)*np+1:i*np));
end


figure(1);
plot(t*10e6,I);
set(get(gca, 'Title'), 'String', 'Costas Code Modulated Signal');
set(get(gca, 'XLabel'), 'String', 'Time/us');
set(get(gca, 'YLabel'), 'String', 'Amplitude');

signal = I + sqrt(-1)*Q;
figure(2);
periodogram(signal);


disp('The frequency sequency is')
disp(freq)

