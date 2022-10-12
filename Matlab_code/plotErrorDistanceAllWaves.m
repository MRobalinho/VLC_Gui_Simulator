%% General "Main" to run VLC Sim functions - All Waves
function plotErrorDistanceAllWaves(im, xDistance, xPower,...
    irradiance_ambient, clock_rate, xWave, quantum_efficiency, area)

X = ['Start function parameters - Distance:', xDistance, ', Power:', xPower] ;
disp(X);

power_src = 3.3; % watt

distance = 0;
power_value = 0;
power_range = 0.1:0.05:20;
hold on;

% Power values
setGlobalxV [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ];  % Vector with powers
powerVector = getGlobalxV;     % Vector with powers
disp(powerVector);

% Power values
if xPower     == '1W  '
    power_value = 1;
elseif xPower == '2W  ' 
    power_value = 2;  
elseif xPower == '3W  ' 
    power_value = 3;
elseif xPower == '4W  ' 
    power_value = 4;
elseif xPower == '5W  ' 
    power_value = 5;
elseif xPower == '6W  ' 
    power_value = 6;    
elseif xPower == '7W  ' 
    power_value = 7;   
elseif xPower == '8W  ' 
    power_value = 8;   
elseif xPower == '9W  ' 
    power_value = 9;     
elseif xPower == '10W ' 
    power_value = 10;   
end

%------
i = 0.5;
k = 0.05;
j = power_value;
power_range = ([i:k:j]);  % Creates range for minimum to selected value
%----
% Distance values
if xDistance == '1 m'
    distance = 1;
elseif xDistance == '2 m'  
    distance = 2;
elseif xDistance == '3 m'  
    distance = 3;
elseif xDistance == '4 m'  
    distance = 4;
elseif xDistance == '5 m'  
    distance = 5;
elseif xDistance == '6 m'  
    distance = 6; 
elseif xDistance == '7 m'  
    distance = 7; 
elseif xDistance == '8 m'  
    distance = 8; 
elseif xDistance == '9 m'  
    distance = 9;     
elseif xDistance == '10m'  
    distance = 10;      
end

%------
dist_range = 0.5:0.25:30;
i = 0.5;
k = 0.05;
j = distance;
dist_range = ([i:k:j]);  % Creates range for minimum to selected value
wavelength = 415e-9; % Default
constants = [clock_rate, wavelength, area, quantum_efficiency];
% ------------ calculate distance errors ----------------------------
hold on
clc;  % Clear screen
X = ['2-Distance: ',num2str(distance), ' Power:',num2str(power_value) , ' All Waves'];
disp(X);

% wavelenght global parameters
setGlobalwL [ 0.000000415, 0.000000467, 0.000000492, 0.000000577, 0.000000607, 0.000000687];  % Vector with Wave lenght
vwL = getGlobalwL;     % Vector with wave lenght
disp(vwL);

% Plot Erros Vs Distance
xWave = 'violet';
xWave1 = xWave;
xP = ['Print:', xWave1];
xColor = 'magenta';
wavelength = 415e-9;
constants(2) = wavelength; 
xWavelenght1 = num2str(wavelength * 1000000000);
disp(xP)

errors_d = errors_vs_distance(dist_range, power_value, irradiance_ambient, constants);
x4 = plot(dist_range, errors_d, 'color', xColor);
x4.LineWidth = 2;
hold on

% ----------------
xWave = 'blue  ';
xWave2 = xWave;
xColor = xWave;
wavelength = 467e-9;
constants(2) = wavelength; 
xWavelenght2 = num2str(wavelength * 1000000000);
xP = ['Print:', xWave];
disp(xP)
  
errors_d = errors_vs_distance(dist_range, power_value, irradiance_ambient, constants);
x4=plot(dist_range, errors_d, 'color', xColor);
x4.LineWidth = 2;
hold on
% ----------------
xWave = 'cyan  '; 
xWave3 = xWave;
xColor = xWave;
wavelength = 492e-9;
constants(2) = wavelength; 
xWavelenght3 = num2str(wavelength * 1000000000);
xP = ['Print:', xWave];
disp(xP)

errors_d = errors_vs_distance(dist_range, power_value, irradiance_ambient, constants);
x4=plot( dist_range, errors_d, 'color', xColor);
x4.LineWidth = 2;
hold on
% --------------
xWave = 'yellow';  
xWave4 = xWave;
xColor = xWave;
wavelength = 577e-9; 
constants(2) = wavelength; 
xWavelenght4 = num2str(wavelength * 1000000000);
xP = ['Print:', xWave];
disp(xP)

errors_d = errors_vs_distance(dist_range, power_value, irradiance_ambient, constants);
x4=plot(dist_range, errors_d, 'color', xColor);
x4.LineWidth = 2;
hold on
% --------------
xWave = 'orange'; 
xWave5 = xWave;
xColor = 'black';
wavelength = 607e-9; 
constants(2) = wavelength; 
xWavelenght5 = num2str(wavelength * 1000000000);
xP = ['Print:', xWave];
disp(xP)

errors_d = errors_vs_distance(dist_range, power_value, irradiance_ambient, constants);
x4=plot( dist_range, errors_d, 'color', xColor);
x4.LineWidth = 2;
hold on
% --------------
xWave = 'red   '; 
xWave6 = xWave;
xColor = xWave;
wavelength = 687e-9; 
constants(2) = wavelength; 
xWavelenght6 = num2str(wavelength * 1000000000);
xP = ['Print:', xWave];
disp(xP) 

errors_d = errors_vs_distance(dist_range, power_value, irradiance_ambient, constants);
x4=plot(dist_range, errors_d, 'color', xColor);
x4.LineWidth = 2;
hold on
% ------------------------------------
% add title and legend
zTitle = ['Power:', xPower ,' vs distance:', xDistance, ' Probability of Error for all wave-lenght'];
zLabel = ['Distance (Meters)'];
title(zTitle);
xlabel(zLabel);
ylabel('Probability of Error');

grid on;
grid minor;
legend(xWavelenght1, xWavelenght2,...
    xWavelenght3, xWavelenght4, xWavelenght5, xWavelenght6, 'Location', 'northwest')

leg = legend('show');
title(leg,'wave-length');
hold off
% -  save figures
save VLC_test_allwaves.mat 
xImg = 'VLC_test_allwaves.png';
saveas(gcf,xImg);   % save to disk

end 
%% -----------------------
function setGlobalxV(val)
    global xV;
    xV = val;
end
%% ------------------------
function r = getGlobalxV
    global xV;
    r = xV;
end
%% -----------------------
function setGlobalwL(val)
    global wL;
    wL = val;
end
%% ------------------------
function r = getGlobalwL
    global wL;
    r = wL;
end