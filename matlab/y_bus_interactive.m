clc;
clear all;
disp("------- Y BUS Formation--------");

% Input the number of nodes
x = input('Enter the number of nodes: ');

% Initialize the admittance matrix
YBUS = zeros(x, x);

% Populate the admittance matrix
for i = 1:x
    for j = 1:x
        if (i == j)
            YBUS(i, j) = input(['Enter the value of admittance Y', num2str(i), '0: ']);
        else
            YBUS(i, j) = -input(['Enter the value of admittance Y', num2str(i), num2str(j), ': ']);
        end
    end
end

% Compute the YBUS matrix
for i = 1:x
    for j = 1:x
        if i ~= j
            YBUS(i, i) = YBUS(i, i) - YBUS(i, j);
        end
    end
end

% Display Admittance Matrix (YBUS)
disp('Admittance Matrix (YBUS):');
disp(YBUS);

% Calculate Z-bus Matrix
Zbus = inv(YBUS);
% Display Z-bus Matrix
disp('Z-bus Matrix:');
disp(Zbus);

% Display Bus Voltages
disp('Bus Voltages:');
disp(Vbus);
