clear;
clc;
H=[510 7.2 0.00142; 310 7.85 0.00194; 78 7.97 0.00482]; #Fuel Function of Generators
f=[1.2;1;1.1]; #Fuel cost of each Generators
P_limits=[150 600; 100 400; 50 200]; #Power Limits of each generator in MW
lamda=8e0;
tolerence=10; #Tolerence for iterations in MW
itr_limit=1000;
############################################################
F=H.*f; #calculation of Cost function

#define Base Point
P_Load_Base=950; # Base Load on the system in MW
P_Base=[425.18;400;124.67];
P_Load=1000 # New Total  Load on the System in MW

##########
n=size(F)(2); #order of Cost Function
dL=F(:,3:n);
for i=[1:n-2]
  dL(:,i)=dL(:,i)*i*(i+1)
end