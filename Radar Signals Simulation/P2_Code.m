%function x = P2_Code()
%myFun - Description
%This code is for generating P2 Code. 
% Syntax: x = P2_Code()
%
% Long description

close all;
clear;
    
fs = 1200e6; Ts = 1/fs;                    %sample frequency 
fc = fs/6 + rand*(fs/5-fs/6);            %carrier frequency
M = 2*randi(2)+4;                          %random # of code phases                     
A = 1;                                   %Amplitude
SAR = ceil(fs/fc);                       %sampling ratio
N = 512 + randi(1920-512);               %length of samples
P = fix(N/(M*M*SAR));                    %periods of codes

%Generating the phase matrix
for i = 1:M
    for j = 1:M
       phi(i,j)=-pi/(2*M)*[2*i-1-M]*[2*j-1-M];       
    end    
end


index = 0;
for i = 1:M
    for j = 1:M
        for n = 1:SAR
            I(index+1)=A*cos(2*pi*fc*(n-1)*Ts+phi(i,j));
            Q(index+1)=A*sin(2*pi*fc*(n-1)*Ts+phi(i,j));
            index = index + 1;        
        end
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
nn = 0;
for ii=1:M
    for jj=1:M
        nn=nn+1;
        phi2(nn)=phi(ii,jj);
    end
end
xx = 0:length(phi2)-1;
stairs(xx,phi2);grid;
set(get(gca, 'Title'), 'String', 'P1 Phase Code');
xlabel('i - index for phase change');
set(get(gca, 'YLabel'), 'String', 'P1 Phase shift');

figure(3);
periodogram(S);
set(get(gca, 'Title'), 'String', 'Periodogram of Modulated Signal');



sprintf('The number of code phases is %g', M)
sprintf('The carrier frequency is %g', fc)
sprintf('The number of samples is %g', P*M*M*SAR)
%end

