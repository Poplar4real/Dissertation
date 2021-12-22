%function x = T2_Code()
%myFun - Description
%
% Syntax: x = T2_Code()
%
% Long description
    

close all;
clear;
    
fs = 1200e6; Ts = 1/fs;                    %sample frequency 
fc = fs/6 + rand*(fs/5-fs/6);              %carrier frequency
A=1;                                       %Amplitude
k = randi(3)+3;                              %Number of stepped frequency segments
m =2;                                      %Number of phase states 
N = 512 + randi(1920 - 512);
SAR = floor(fc/fs);
T = N*Ts;
t = 0:Ts:N*Ts-Ts;
deltaf = 250;
deltaphi = 2*pi/m;


index = 1;
for tt = 0:Ts:(N*Ts-Ts)
    jj = floor(k*tt/T);
    phase(index) = mod(((2*pi/m)*floor((((k*tt - jj*T)*((2*jj-k+1)/T)*(m/2))))), 2*pi); 
    index = index + 1;
end

for i = 1: N
    I(i) = A*cos(2*pi*fc*(i-1)*Ts+phase(i));
    Q(i) = A*sin(2*pi*fc*(i-1)*Ts+phase(i));
end

S = I + sqrt(-1)*Q;

figure(1);
plot(t*10e6,phase);
set(get(gca, 'Title'), 'String', 'Phase Shift of T2 Code');
set(get(gca, 'XLabel'), 'String', 'Time/us');
set(get(gca, 'YLabel'), 'String', 'Phase');

figure(2);
plot(t(1:100)*10e6,I(1:100));
set(get(gca, 'Title'), 'String', 'Modulated Signal');
set(get(gca, 'XLabel'), 'String', 'Time/us');
set(get(gca, 'YLabel'), 'String', 'Amplitude');


figure(3);
periodogram(I);

sprintf('Number of stepped frequency segments is %g.', k)
sprintf('The length of signal is %g.', N)

%end