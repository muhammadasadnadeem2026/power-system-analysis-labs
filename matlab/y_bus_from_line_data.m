clear all 
clc
% Input Linedata
linedata = input('Enter Linedata: ');

% Extracting data from Linedata
nl = linedata(:, 1); % Line from bus
nr = linedata(:, 2); % Line to bus
R = linedata(:, 3);  % Resistance
X = linedata(:, 4);  % Reactance

% Total number of lines and buses
nline = length(nl);
nbus = max([max(nl), max(nr)]);

% Impedance Calculation
Z = R + 1j * X; % Complex impedance

% Admittance Matrix (Y) Construction
y_1 = ones(nline, 1) ./ Z;
Y = zeros(nbus, nbus);

for n = 1:nbus
    for k = 1:nline
        if nl(k) == n || nr(k) == n
            Y(n, n) = Y(n, n) + y_1(k);
        end
    end
end

for k = 1:nline
    if nl(k) > 0 && nr(k) > 0
        Y(nl(k), nr(k)) = Y(nl(k), nr(k)) - y_1(k);
        Y(nr(k), nl(k)) = Y(nl(k), nr(k));
    end
end

% Display Y Matrix
disp('Admittance Matrix (Y):');
disp(Y);

% Z-bus Calculation
Zbus = inv(Y);

% Bus Currents and Voltages
Ibus = zeros(nbus, 1); % Update with actual values
Ibus(3) = -1j; % Example value for bus 3
Vbus = Zbus * Ibus;

% Display Z-bus Matrix
disp('Z-bus Matrix:');
disp(Zbus);

% Display Bus Voltages
disp('Bus Voltages:');
disp(Vbus);
