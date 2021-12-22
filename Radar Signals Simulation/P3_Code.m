%function x = P3_Code()
%myFun - Description
%This code is for generating P3 Code. 
% Syntax: x = P3_Code()
%
% Long description

close all;
clear;
    
fs = 1200e6; Ts = 1/fs;                    %sample frequency 
fc = fs/6 + rand*(fs/5-fs/6);            %carrier frequency
M = randi(3)+5;                          %random # of code phases                     
Nc = M*M;                                %compression ratio
A = 1;                                   %Amplitude
SAR = ceil(fs/fc);                       %sampling ratio
N = 512+randi(1920-512);
P = fix(N/(M*M*SAR));                    %periods of codes


%Generating the phase matrix
for i = 1:Nc
        phi(i)=pi/Nc*(i-1)^2;            
end


index = 0;
for i = 1:Nc
        for n = 1:SAR
            I(index+1)=A*cos(2*pi*fc*(n-1)*Ts+phi(i));
            Q(index+1)=A*sin(2*pi*fc*(n-1)*Ts+phi(i));
            index = index + 1;        
        end
end


temp1 = I; I=[];
temp2 = Q; Q=[];
for i =1:P
    I =[I temp1];
    Q =[Q temp2];
end


t = 0:Ts:P*M*M*SAR*Ts-Ts;                    %setup time vector


S = I+sqrt(-1).*Q; %modulated signal
phase_signal = angle(S);

figure(1);
t_plot = t(1:floor(length(t)/M)); %for plotting using a small fraction of t
I_plot = I(1:floor(length(I)/M));
plot(t_plot*10e6,I_plot);
set(get(gca, 'Title'), 'String', 'Phase Shift Signal');
set(get(gca, 'XLabel'), 'String', 'Time/us');
set(get(gca, 'YLabel'), 'String', 'Amplitude');


figure(2);
n = 1:Nc;
undoo = rem(phi,2*pi);
stairs(n,undoo);grid;
set(get(gca, 'Title'), 'String', 'P3 Phase Code');
xlabel('i - index for phase change');
set(get(gca, 'YLabel'), 'String', 'P3 Phase shift');

figure(3);
periodogram(S);
set(get(gca, 'Title'), 'String', 'Periodogram of Modulated Signal');



sprintf('The number of code phases is %g', M)
sprintf('The carrier frequency is %g', fc)
sprintf('The number of samples is %g',N)
%end

