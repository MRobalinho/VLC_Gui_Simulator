%% General "Main" to run VLC Sim functions - All Powers
function plotErrorDistanceAllPowers(im, xDistance, xPower,...
    irradiance_ambient, clock_rate, xWave, quantum_efficiency, area)

X = ['Start function AllPowers - Distance:', xDistance, ', Power:', xPower] ;
disp(X);

vColor = [ 'r--o', ':o', 'c*', 'r', 'g+', '.', 'b-', 'm', 'y', 'b', 'g--s', 'b--o' ];   % Vector with colors
powerVector = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ];  % Vector with powers
power_src = 3.3; % watt

distance = 0;
power_value = 0;
power_range = 0.1:0.05:20;
hold on;

% Power values
%powerVector = getGlobalxV;     % Vector with powers
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
X = ['2-Distance: ',num2str(distance), ' Power:',num2str(power_value) , ' AllPowers'];
disp(X);

% wavelenght global parameters
vwL = getGlobalwL;     % Vector with wave lenght
disp(vwL);

% 415e-9, 467e-9, 492e-9, 577e-9, 607e-9, 687e-9
if xWave     == 'violet'
    wavelength = 415e-9;
elseif xWave == 'blue  '  
    wavelength = 467e-9;
elseif xWave == 'cyan  '  
    wavelength = 492e-9;   
elseif xWave == 'yellow'  
    wavelength = 577e-9;  
elseif xWave == 'orange'  
    wavelength = 607e-9; 
elseif xWave == 'red   '  
    wavelength = 687e-9;    
end   
x2 = [' Wavelenght selected:', xWave, num2str(wavelength*1000000000), ' Legnt Powervector: ', num2str(length(powerVector)) ];
disp(x2);

% Plot Erros Vs Distance
iColor = 1;
for i = 1:length(powerVector)
       
        power_value = powerVector(i);
 
        iColor = i;

        xColor = vColor(iColor);
        xWave1 = xWave;
        xWavelenght1 = num2str(wavelength * 1000000000);
        
        xP = ['Print Power:', num2str(i), ' Wave:', xWave1, num2str(xWavelenght1), ' Color:', xColor, ' Power:', num2str(power_value)];
        disp(xP);

        constants(2) = wavelength; 

        errors_d = errors_vs_distance(dist_range, power_value, irradiance_ambient, constants);
        x3 = plot(dist_range, errors_d, xColor);
        x3.LineWidth = 2;
        hold on 

end

% add title and legend
zTitle = ['Wave:', xWave ,' vs distance:', xDistance, ' Probability of Error for all Power values'];
zLabel = ['Distance (Meters)'];
title(zTitle);
xlabel(zLabel);
ylabel('Probability of Error');

grid on;
grid minor;
legend(num2str(powerVector(1)), num2str(powerVector(2)), num2str(powerVector(3)),...
    num2str(powerVector(4)), num2str(powerVector(5)), num2str(powerVector(6)),...
    num2str(powerVector(7)), num2str(powerVector(8)), num2str(powerVector(9)),...
    num2str(powerVector(10)), 'Location', 'northwest');

leg = legend('show');
title(leg,'Power (watts)');
hold off

% -----------------------
% save values
save VLC_test_allpowers.mat 
xImg = 'VLC_test_allpowerss.png';
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