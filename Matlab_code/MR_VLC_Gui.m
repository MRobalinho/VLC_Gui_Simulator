%%------------------------------------
% GUI for VLC Simulator
% Coimbra University
% Manuel Robalinho
% Year: 2022
% References:
%  https://www.mathworks.com/help/matlab/ref/uigridlayout.html
%--------------------------------------------------------------
clear all; % Clear memory
clc;  % Clear screen
%-----------
% Other constants
irradiance_ambient = 10; % watt / m^2 Sunlight = 1000
clock_rate = 15e6; % From IEEE Spec
wavelength = 600e-9; % 590-610 nm based on Cree Spec

setGlobalxV [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ];  % Vector with powers
%disp(xV);
%p = getGlobalxV;    % Get for global variable
%disp(p);

setGlobalwL [ 0.000000415, 0.000000467, 0.000000492, 0.000000577, 0.000000607, 0.000000687];  % Vector with Wave lenght
%           415e-9, 467e-9, 492e-9, 577e-9, 607e-9, 687e-9
%           'violet', 'blue ,'cyan', 'yellow', 'orange', 'red   '
%          https://calculator.name/scientific-notation-to-decimal/687e-9

% Reciever Info
area = 1e-6; % 1 mm^2
quantum_efficiency = 0.75; % Generally 50-90%. Not a huge factor
%% -------------------------------------------------
%  Create GUI
% Figure and Panel That Each Have a Grid - Grid 1
fig = uifigure('Position',[100 100 900 450]); % top lef(x/y) / box length / box height
grid1 = uigridlayout(fig,[1 2]);   % 1 Fig with 2 columns
grid1.ColumnWidth = {250,'1x'};  % Define Column with to grid 1
% Add title for Simulator
fig.Name = "My App VLC Simulator-MRobalinho";
%----------------
% Add Grid 2

grid2 = uigridlayout(grid1,[10 2]);  % 10 rows and 2 columns 
grid2.RowHeight = {20, 20, 20, 20, 20, 15, 15, 15, 30, 30};  % Dimention for each row
grid2.ColumnWidth = {150,'1x'};  % Define Column with to grid 2

ax = uiaxes(grid1);
ax.XGrid = 'on';
ax.YGrid = 'on';

%---------------------------------------------
%Add three drop-downs to the first three rows of grid2.
% Grid in the panel

%----------------------------------
% Power label 1
dlPower = uilabel(grid2);
dlPower.HorizontalAlignment = 'left';
dlPower.Text = 'Power';
% Power drop-down
ddPower = uidropdown(grid2);
ddPower.Items = {'1W  ', '2W  ', '3W  ', '4W  ','5W  ','6W  ','7W  ','8W  ','9W  ','10W '};

%-------------------------------------------
% Distance label 2
dlDistance = uilabel(grid2);
dlDistance.HorizontalAlignment = 'left';
dlDistance.Text = 'Distance';
% Distance drop-down
ddDistance = uidropdown(grid2);
ddDistance.Items = {'1 m', '2 m', '3 m', '4 m', '5 m', '6 m', '7 m', '8 m', '9 m' '10m'};

%-------------------------------------------
% wavelength label 3
dlWave = uilabel(grid2);
dlWave.HorizontalAlignment = 'left';
dlWave.Text = 'Wavelenght';
% wavelength drop-down
% https://en.wikipedia.org/wiki/Visible_spectrum
% violet (380-450) = 415
% blue (450-485) = 467
% cyan (485-500) = 492
% yellow (565-590) = 577
% orange (590-625) = 607
% red (625-750) = 687
ddWave = uidropdown(grid2);
ddWave.Items = {'violet', 'blue  ','cyan  ', 'yellow', 'orange', 'red   '};

%---------------------------------
% label 4 ------------
dlLbl2 = uilabel(grid2);
dlLbl2.HorizontalAlignment = 'left';
dlLbl2.Text = 'Constant Parameters ';
dlLbl2.FontWeight = 'bold';
dlLbl2.BackgroundColor = 'c';
% label  
dlLbl3 = uilabel(grid2);
dlLbl3.HorizontalAlignment = 'left';
dlLbl3.Text = '';
% label 5 ------------
dlLbl20 = uilabel(grid2);
dlLbl20.HorizontalAlignment = 'left';
dlLbl20.Text = 'Irradiance ';
% label 
dlLbl21 = uilabel(grid2);
dlLbl21.HorizontalAlignment = 'right';
dlLbl21.Text = num2str(irradiance_ambient);
% label 6 ------------
dlLbl30 = uilabel(grid2);
dlLbl30.HorizontalAlignment = 'left';
dlLbl30.Text = 'Efficiency Quantum ';
% label 
dlLbl31 = uilabel(grid2);
dlLbl31.HorizontalAlignment = 'right';
dlLbl31.Text = num2str(quantum_efficiency);
% label 7 ------------
dlLbl40 = uilabel(grid2);
dlLbl40.HorizontalAlignment = 'left';
dlLbl40.Text = 'Clock rate(15x10^-6) ';
% label 
dlLbl41 = uilabel(grid2);
dlLbl41.HorizontalAlignment = 'right';
dlLbl41.Text = num2str(clock_rate); %'15 x 10^-6 ';
% label 8 ------------
dlLbl50 = uilabel(grid2);
dlLbl50.HorizontalAlignment = 'left';
dlLbl50.Text = 'Area(mm^2) ';
% label 
dlLbl51 = uilabel(grid2);
dlLbl51.HorizontalAlignment = 'right';
dlLbl51.Text = num2str(area);

% Create a 1-by-2 grid called grid3 inside the last row of grid2. 
% Then add two buttons to grid3. Remove the padding on the left and right 
% edges of grid3 so that the buttons align with the left and right 
% edges of the drop-downs.
% Create Buttons

%grid3 = uigridlayout(grid2,[1 2]);
%grid3.Padding = [0 10 0 10];

% label 9 ------------
dlLbl2 = uilabel(grid2);
dlLbl2.HorizontalAlignment = 'left';
dlLbl2.Text = 'Execution';
dlLbl2.FontWeight = 'bold';
dlLbl2.BackgroundColor = 'c';

% Create a push button EXECUTE - 9
b1 = uibutton(grid2,'Text','Start',...
    'ButtonPushedFcn', @(b1,event) plotErrorDistance(ax, ddDistance.Value, ddPower.Value,...
    irradiance_ambient, clock_rate, ddWave.Value, quantum_efficiency, area));

% - Blank label 10
dlLbl4 = uilabel(grid2);
dlLbl4.HorizontalAlignment = 'left';
dlLbl4.Text = '';

b2 = uibutton(grid2,'Text','All Waves',...
    'ButtonPushedFcn', @(b1,event) plotErrorDistanceAllWaves(ax, ddDistance.Value,ddPower.Value,...
    irradiance_ambient, clock_rate, ddWave.Value, quantum_efficiency, area));

% - Blank label 11
dlLbl5 = uilabel(grid2);
dlLbl5.HorizontalAlignment = 'left';
dlLbl5.Text = '';

b3 = uibutton(grid2,'Text','All Powers',...
    'ButtonPushedFcn', @(b1,event) plotErrorDistanceAllPowers(ax, ddDistance.Value,ddPower.Value,...
    irradiance_ambient, clock_rate, ddWave.Value, quantum_efficiency, area));

% - Blank label 12
dlLbl6 = uilabel(grid2);
dlLbl6.HorizontalAlignment = 'left';
dlLbl6.Text = '';

% Create a push button CANCEL - 13
b4 = uibutton(grid2,'Text','Stop',...
               'ButtonPushedFcn', @(b2,event) ExitButtonPushed(b2,ax, fig));

% - Blank label 14
dlLbl7 = uilabel(grid2);
dlLbl7.HorizontalAlignment = 'left';
dlLbl7.Text = '';       

% -- GUI FINISH DESIGN ----------------------------
%% General "Main" to run VLC Sim functions
function plotErrorDistance(ax, xDistance, xPower,...
    irradiance_ambient, clock_rate, xWave, quantum_efficiency, area)

X = ['Start function parameters - Distance:', xDistance, ', Power:', xPower ,' Wave:', xWave];
disp(X);

power_src = 3.3; % watt

distance = 0;
power_value = 0;
power_range = 0.1:0.05:20;
hold on

% Power values
powerVector = getGlobalxV;     % Vector with powers
disp(powerVector);

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
x1 = [ num2str(i), '  ' , num2str(k),'  ', num2str(j)];
disp(x1);
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

%--------------
% wavelenght
vwL = getGlobalwL;     % Vector with wave lenght
x2 = [' Wavelenght vector:', vwL];
disp(x2);
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
x2 = [' Wavelenght selected:', wavelength];
disp(x2);
% ------------ calculate power errors ----------------------------
constants = [clock_rate, wavelength, area, quantum_efficiency];

X = ['1-Distance: ',num2str(distance), ' Power:',num2str(power_value) , ' Wave:',num2str(wavelength)];
disp(X);
disp(constants);
errors_p = errors_vs_power(power_range, distance, irradiance_ambient, constants);

%------------
% Plot Erros Vs Power - Screen area
zTitle = ['Power: ', xPower ,' vs distance:', xDistance, ' Probability of Error'];
zLabel = ['Power (Watts) using wavelenght:',xWave];
%ax = subplot(2,2,1) % first subplot
plot(ax, power_range, errors_p, 'r');
title(ax, zTitle);
xlabel(ax,zLabel);
ylabel(ax,'Probability of Error');
grid on;
grid minor;

%------------
% Plot Erros Vs Power - Subplot
zTitle = ['Power: ', xPower ,' vs distance:', xDistance, ' Probability of Error'];
ax1 = subplot(2,2,1) % first subplot
plot(ax1, power_range, errors_p, 'r');
title(ax1, zTitle);
xlabel(ax1,zLabel);
ylabel(ax1,'Probability of Error');
grid on;
grid minor;

%------
dist_range = 0.5:0.25:30;
i = 0.5;
k = 0.05;
j = distance;
dist_range = ([i:k:j]);  % Creates range for minimum to selected value
%-----------------------------------------------------------------------
% ------------ calculate distance errors ----------------------------
hold on

X = ['2-Distance: ',num2str(distance), ' Power:',num2str(power_value) , ' Wave:',num2str(wavelength)];
disp(X);

% -------------------------------
errors_d = errors_vs_distance(dist_range, power_value, irradiance_ambient, constants);
% Plot Erros Vs Distance
ax2 = subplot(2,2,2) % first subplot
plot(ax2,dist_range, errors_d, 'r');
zTitle = ['Power: ', xPower ,' vs distance:', xDistance, ' Probability of Error'];
zLabel = ['Distance (Meters) using wavelenght:',xWave];
title(ax2, zTitle);
xlabel(ax2, zLabel);
ylabel(ax2,'Probability of Error');
grid on;
grid minor;

%------------
% Plot Erros Vs Power - Screen area
errors_d = errors_vs_distance(dist_range, power_value, irradiance_ambient, constants);
zTitle = ['Power: ', xPower ,' vs distance:', xDistance, ' Probability of Error'];
plot(ax, dist_range, errors_d, 'r');
title(ax, zTitle);
xlabel(ax2, zLabel);
ylabel(ax,'Probability of Error');
grid on;
grid minor;
save VLC_test_example.mat 
saveas(gcf,'VLC_test_example.png')

end 

%% -------------------------------------------------------
% Create the function for the ButtonPushedFcn callback
function plotButtonPushed(btn,ax)
        x = linspace(0,2*pi,100);
        y = sin(x);
        plot(ax,x,y)
end

%% -- STOP Function
function ExitButtonPushed(btn,ax, fig)
 
  %  quit; % Shut down the entire app.
  
  anss = uiconfirm(fig, 'Do you wish to quit?', 'Confirm Exit', 'Options',{'Yes','No','Cancel'}, ...
        'DefaultOption',3,'CancelOption',3, 'Icon', 'question');
            
     switch anss
        case 'Yes'
            save VLC_test.mat 
            exit; % Ends this session
         otherwise
            return;
     end     

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