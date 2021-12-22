%function x = Barker_Code()
%myFun - Description
%
% Syntax: x = Barker_Code()
%
% Long description
    
clc;clear all;

A = 1;                                   %Amplitude
fs = 1200e6; Ts = 1/fs;                    %sample frequency 
fc = fs/6 + rand*(fs/5-fs/6);            %carrier frequency
SAR = floor(fs/fc);                      %sample rate
M = randi(3);                            %# of Barker Code


%Generating Barker Code
if M == 1
    Barker = [ones(1,SAR*3)  -(ones(1,SAR*2)) ones(1,SAR*1) -ones(1,SAR)];
    k = 7;
elseif M == 2
    Barker = [ones(1,SAR*3)  -(ones(1,SAR*3)) ones(1,SAR*2) -ones(1,SAR) -ones(1,SAR) ones(1,SAR*2) -ones(1,SAR)];
    k = 11;
else
    Barker = [ones(1,SAR*5) -(ones(1,SAR*2)) ones(1,SAR*2) -ones(1,SAR) ones(1,SAR*2) -ones(1,SAR) ones(1,SAR*2)];
    k = 13;
end


brkseq = [];
N_b = length(Barker);
N = fix((512+randi(1920-512))/N_b);           %Code Periods
n = 1:1:N*N_b;                            %set up vectors for n


for i = 1:N
    brkseq = [brkseq,Barker];
end

%modulated signal
I = A*cos(2*pi.*n*fc/fs).*brkseq;
Q = A*sin(2*pi.*n*fc/fs).*brkseq;
signal = I + sqrt(-1)*Q;

figure(1)
subplot(2,1,1);
plot(n,brkseq);
set(get(gca, 'XLabel'), 'String', 'n');
set(get(gca, 'YLabel'), 'String', 'Code');
set(get(gca, 'Title'), 'String', 'Barker Code');
subplot(2,1,2);
stem(n,I);
set(get(gca, 'Title'), 'String', 'Sampled signals of Barker Code');
set(get(gca, 'XLabel'), 'String', 'n');
set(get(gca, 'YLabel'), 'String', 'Amplitude');


figure(2)
periodogram(signal);

sprintf('The number of Barker code is %g.', k)
sprintf('The total length of the signal is %g', length(n))


%end