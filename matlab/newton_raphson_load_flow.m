clc;
clear all;
% Bus data: [bus_number voltage_magnitude voltage_angle P_injection Q_injection]
gbus = [1 2.0 1.0 0.0 0.0;  2 0.0 0.0 0.5 1.0;  3 1.5 0.6 0.0 0.0];
% Ybus matrix
ybus = [5.882-j*23.528 -2.941+j*11.764 -2.941+j*11.764;
        -2.941+j*11.764 5.882-j*23.528 -2.941+j*11.764;
        -2.941+j*11.764 -2.941+j*11.764 5.882-j*23.528];
% Tolerance
t = 0.001;
% Initial voltage angles and magnitudes
v1 = 1.04 + j*0;
v2 = 1 + j*0;
v3 = 1.04 + j*0;
del3 = angle(v3);
del1 = angle(v1);
del2 = angle(v2);
% Loop for iterations
for iter = 1:10
    % Calculate active and reactive powers
    p2 = (abs(v2)*abs(v1)*abs(ybus(2,1))*cos((angle(ybus(2,1)))+del1-del2)) + abs(v2)*abs(v2)*abs(ybus(2,2))*cos((angle(ybus(2,2)))) + (abs(v2)*abs(v3)*abs(ybus(2,3))*cos((angle(ybus(2,3))+del3-del2)));
    q2 = -(abs(v2)*abs(v1)*abs(ybus(2,1))*sin((angle(ybus(2,1)))+del1-del2)) - abs(v2)*abs(v2)*abs(ybus(2,2))*sin((angle(ybus(2,2)))) - (abs(v2)*abs(v3)*abs(ybus(2,3))*sin((angle(ybus(2,3))+del3-del2)));
    p3=(abs(v3)*abs(v1)*abs(ybus(3,1))*cos((angle(ybus(3,1)))+del1-del3))+abs(v3)*abs(v3)*abs(ybus(3,3))*cos((angle(ybus(3,3))))+(abs(v2)*abs(v3)* abs(ybus(3,2))*cos((angle(ybus(3,2)))+del2-del3));
    % Calculate changes in powers
    delp20 = gbus(2,4) - gbus(2,2) - p2;
    delp30 = gbus(3,4) - gbus(3,2) - p3;
    delq20 = gbus(2,5) - gbus(2,3) - q2;
    % Jacobian matrix
    J = [
        (abs(v2)*abs(v1)*abs(ybus(2,1))*sin((angle(ybus(2,1)))+del1-del2)) + (abs(v2)*abs(v3)*abs(ybus(2,3))*sin((angle(ybus(2,3)))+del3-del2)), -(abs(v2)*abs(v3)*abs(ybus(2,3))*sin((angle(ybus(2,3)))+del3-del2)), (abs(v1)*abs(ybus(2,1))*cos((angle(ybus(2,1)))+del1-del2)) + 2*(abs(v2)*abs(ybus(2,2))*cos((angle(ybus(2,2))))+(abs(v3)*abs(ybus(2,3))* cos((angle(ybus(2,3)))+del3-del2)));
        -(abs(v3)*abs(v2)*abs(ybus(3,2))*sin((angle(ybus(3,2)))+del2-del3)), (abs(v3)*abs(v1)*abs(ybus(3,1))*sin((angle(ybus(3,1)))+del1-del3)) + (abs(v3)*abs(v2)*abs(ybus(3,2))*sin((angle(ybus(3,2)))+del2-del3)), (abs(v3)*abs(ybus(3,2))*cos((angle(ybus(3,2)))+del2-del3));
        (abs(v2)*abs(v1)*abs(ybus(2,1))*cos((angle(ybus(2,1)))+del1-del2)) - (abs(v2)*abs(v3)*abs(ybus(2,3))*cos((angle(ybus(2,3)))+del2-del3)), (abs(v2)*abs(v3)*abs(ybus(2,3))*cos((angle(ybus(2,3)))+del2-del3)), -(abs(v2)*abs(ybus(2,1))*sin((angle(ybus(2,1)))+del1-del2)) - 2*(abs(v2)*abs(ybus(2,2))*sin((angle(ybus(2,2))))-(abs(v3)*abs(ybus(2,3))* sin((angle(ybus(2,3)))+del3-del2)))
    ];
    % Solve for changes in voltage magnitudes and angles
    delA0 = [delp20; delp30; delq20];
    delA1 = inv(J) * delA0;
    % Update voltage magnitudes and angles
    del2 = del2 + delA1(1);
    del3 = del3 + delA1(2);
    v2 = abs(v2) + delA1(3) * exp(j * angle(v2));
    % Check convergence
    if norm(delA1) <= t
        break;
    end
end

% Display results
fprintf('Converged at iteration: %d\n', iter);
fprintf('Jacobian Matrix: \n ');
disp(J);
fprintf('Voltage Angle at Bus 2: %.4f radians\n', del2);
fprintf('Voltage Angle at Bus 3: %.4f radians\n', del3);
fprintf('Voltage Magnitude at Bus 2: %.4f pu\n', abs(v2));
