clear all ;
clear vars ;
close all ; % mag2db()
%% -------------------------Digital IIR Filters----------------------------
K = 1024 ; % Number of freq. sampling
T = 1 ; 
% Digital Specs 
keySet_dig = {'wp','ws','delp','dels'};
valueSet_dig = [0.25*pi 0.35*pi 0.1 0.175];
M_dig = containers.Map(keySet_dig,valueSet_dig) ; % Dict for specs

% Analog Specs for Imp. Inv. method 
keySet_II = {'Wp','Ws','Delp','Dels'};
valueSet_II = [0.25*pi 0.35*pi 0.1 0.175];
M_II = containers.Map(keySet_II,valueSet_II) ; % Dict for specs
Wc_II = 0.859 ; % Cutoff freq. 
N_II = 8 ; % Filter's order

% Analog Specs for Bi. Tr. method 
keySet_BT = {'Wp','Ws','Delp','Dels'};
valueSet_BT = [2*tan(0.125*pi) 2*tan(0.175*pi) 0.1 0.175];
M_BT = containers.Map(keySet_BT,valueSet_BT) ; % Dict for specs
Wc_BT = 0.918 ; % Cutoff freq. 
N_BT = 7 ; % Filter's order

%% -----------------------------Section c------------------------------------
% Find the analog filter coefficients
[b_II,a_II] = butter(N_II,Wc_II,'s') ; 
[b_BT,a_BT] = butter(N_BT,Wc_BT,'s') ;

% Find the analog filter frequency responce (W=angular frequency)
[H_II,W_II] = freqs(b_II,a_II,K) ; 
[H_BT,W_BT] = freqs(b_BT,a_BT,K) ;

% Plot H for Imp. Inv. method
Yp_II = interp1(W_II,abs(H_II),M_II('Wp'));
Ys_II = interp1(W_II,abs(H_II),M_II('Ws'));
plot(W_II,abs(H_II)) ;

hold on 
plot([0,M_II('Wp')],[Yp_II,Yp_II],'--','color','[0 0 1]') ;
plot([M_II('Wp'),M_II('Wp')],[0,Yp_II],'--','color','[0 0 1]') ;
plot([0,M_II('Ws')],[Ys_II,Ys_II],'--','color','[0 0 1]') ;
plot([M_II('Ws'),M_II('Ws')],[0,Ys_II],'--','color','[0 0 1]') ;
hold off
xlabel('W [rad/sec]') ;
ylabel('Analog |H(jW)|') ;
title('Butterworth-Impulse Invariance Method') 
% xticklabels({'0','0.25\pi','0.35\pi','pi','2\pi','3\pi','4\pi'})

% Plot H for Bi. Tr. method
Yp_BT = interp1(W_BT,abs(H_BT),M_BT('Wp'));
Ys_BT = interp1(W_BT,abs(H_BT),M_BT('Ws'));
figure() ;
plot(W_BT,abs(H_BT)) ;

hold on 
plot([0,M_BT('Wp')],[Yp_BT,Yp_BT],'--','color','[0 0 1]') ;
plot([M_BT('Wp'),M_BT('Wp')],[0,Yp_BT],'--','color','[0 0 1]') ;
plot([0,M_BT('Ws')],[Ys_BT,Ys_BT],'--','color','[0 0 1]') ;
plot([M_BT('Ws'),M_BT('Ws')],[0,Ys_BT],'--','color','[0 0 1]') ;
hold off

xlabel('W [rad/sec]') ;
ylabel('Analog |H(jW)|') ;
title('Butterworth-Bilinear Transfprm Method') 


% Plot the filters on Db 
figure() ;
plot(W_II,mag2db(abs(H_II))) ;
xlabel('W [rad/sec]') ;
ylabel('Analog |H(jW)| [dB]') ;
title('Butterworth-Impulse Invariance Method') 

figure() ;
plot(W_BT,mag2db(abs(H_BT))) ;
xlabel('W [rad/sec]') ;
ylabel('Analog |H(jW)| [dB]') ;
ylim([-80,0]) ;
title('Butterworth-Bilinear Transfprm Method') 

%% ---------------------------Section d------------------------------------
% Find the digital filter coefficients for Imp. Inv method
[bz_II,az_II] = impinvar(b_II,a_II,1/T) ; 
%% ---------------------------Section e------------------------------------
% Find the digital filter coefficients for Bu. Tr. method
[bz_BT,az_BT] = bilinear(b_BT,a_BT,1/T) ; 

%% ---------------------------Section f------------------------------------
[Hz_II,w_II] = freqz(bz_II,az_II,K) ; % Small omega 
[Hz_BT,w_BT] = freqz(bz_BT,az_BT,K) ; % Small omega

% Plot H(z) for Imp. Inv. method
figure() ;
yp_II = interp1(w_II,abs(Hz_II),M_dig('wp'));
ys_II = interp1(w_II,abs(Hz_II),M_dig('ws'));
plot(w_II,abs(Hz_II)) ;

hold on 
plot([0,2.5],[yp_II,yp_II],'--','color','[0 0 1]') ;
plot([0,2.5],[ys_II,ys_II],'--','color','[1 0 0]') ;
legend('','0.8986','0.1374')
hold off
xlabel('w [rad]') ;
xlim([0 pi]) ;
ylabel('Digital |H(w)|') ;
title('Butterworth-Impulse Invariance Method') 

% Plot H(z) for Bi. Tr. method
figure() ;
yp_BT = interp1(w_BT,abs(Hz_BT),M_dig('wp'));
ys_BT = interp1(w_BT,abs(Hz_BT),M_dig('ws'));
plot(w_BT,abs(Hz_BT)) ;

hold on 
plot([0,2.5],[yp_BT,yp_BT],'--','color','[0 0 1]') ;
plot([0,2.5],[ys_BT,ys_BT],'--','color','[1 0 0]') ;
legend('','0.8989','0.1311')
hold off
xlabel('w [rad]') ;
xlim([0 pi]) ;
ylabel('Digital |H(w)|') ;
title('Butterworth-Bilinear Transform Method') 

% Plot the filters on dB 
figure() ;
plot(w_II,mag2db(abs(Hz_II))) ;
xlabel('w [rad]') ;
xlim([0 pi]) ;
xticks([0 0.05*pi 0.15*pi 0.25*pi 0.35*pi 0.45*pi 0.55*pi 0.65*pi 0.75*pi 0.85*pi 0.95*pi pi])
xticklabels({'0','0.5\pi','0.15\pi','0.25\pi','0.35\pi','0.45\pi','0.55\pi','0.65\pi','0.75\pi','0.85\pi','0.95\pi' '\pi'})
ylabel('Digital |H(w)| [dB]') ;
ylim([-80 0]) ;
title('Butterworth-Impulse Invariance Method') 

figure() ;
plot(w_BT,mag2db(abs(Hz_BT))) ;
xlabel('w [rad]') ;
xlim([0 pi]) ;
ylabel('Digital |H(w)| [dB]') ;
ylim([-80 0]) ;
title('Butterworth-Bilinear Transform Method')

