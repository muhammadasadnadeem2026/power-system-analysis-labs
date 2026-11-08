% Gauss-Seidel method implementation in MATLAB
clc;
data=[1 1 2 10-j*20
      2 1 3 10-j*30
      3 2 3 16-j*32];
elements=max(data(:,1)); 
bus=max(max(data(:,2)),max(data(:,3))); 
y=zeros(bus,bus);

% Constructing the admittance matrix
for p=1:bus
    for q=1:elements
        if(data(q,2)==p || data(q,3)==p)
            y(p,p)=y(p,p)+data(q,4);
        end
    end
end

for p=1:bus
    for q=1:bus
        if (p~=q)
            for r=1:elements
                if((data(r,2)==p && data(r,3)==q) || (data(r,2)==q && data(r,3)==p))
                    y(p,q)=-(data(r,4));
                end
            end
        end
    end
end

% Input real and reactive power for bus 2 and bus 3, and base MVA
a1=input('enter p2 in MW:'); 
b1=input('enter q2 in MVAR:'); 
a2=input('enter p3 in MW:'); 
b2=input('enter q3 in MVAR'); 
pu=input('enter the base value in MVA');
p2=(a1/pu); q2=(b1/pu); 
p3=(a2/pu); q3=(b2/pu); 

% Initialize voltages and iteration counter
dx1=1+j*0; dx2=1+j*0; 
v1=1.05; v2=1+j*0; v3=1+j*0; 
iter=0;

% Gauss-Seidel iterations
disp('iter v2 v3'); 
while(abs(dx1) && abs(dx2) >= 0.00001) && iter < 7
    iter=iter+1;
    g1=(((p2-j*q2)/conj(v2))+(-y(1,2)*v1)+(-y(2,3)*v3))/y(2,2);
    g2=(((p3-j*q3)/conj(v3))+(-y(1,3)*v1)+(-y(2,3)*g1))/y(3,3); 
    dx1=g1-v2;
    dx2=g2-v3; 
    v2=v2+dx1; 
    v3=v3+dx2;
    fprintf('%g',iter),disp([v2,v3]); 
end
