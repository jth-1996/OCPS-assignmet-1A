clear;
clc;
H=[749.55 6.950 9.68e-4; 1285.0 7.051 7.375e-4; 1531.0 6.531 1.040e-3]; #Fuel Function of Generators
f=[1;1;1]; #Fuel cost of each Generators
P_limits=[320 800; 300 1200; 275 1100]; #Power Limits of each generator in MW
P_load=2500; # Load on the system in MW
lamda=8e0;
tolerence=10; #Tolerence for iterations in MW
itr_limit=1000;
############################################################
F=H.*f; #calculation of Cost function
n=size(F)(1);
dL=F(:,2:n);
for i=[1:n-1]
  dL(:,i)=dL(:,i).*i;
 end ;
 dL=flip(dL,2); #Derivativve matrix
#dL matrix formed. lamda iteration begins
##############
#fprintf("Itr\t\P_total\tlamda\n")
for itr=[1:itr_limit]
  dl=dL;
  dl(:,n-1)=dL(:,n-1).-lamda(itr);
  P_total(itr)=0;
  for i=[1:n]
    P(i)=roots(dl(i,:)); #assuming that Cost functions are quadratic.
    P_total(itr)+=P(i);
  end
  #fprintf("%d\t%f\t%f\n",itr,P_total(itr),lamda(itr))
  if(P_total(itr)<P_load)
    lamda(itr+1)=1.001*lamda(itr);
  else
    lamda(itr+1)=0.999*lamda(itr);
  end
  if(tolerence>abs(P_total(itr)-P_load))
    fprintf("Terminating Iterations at itr:%d as Tolerence (%d MW)\n",itr,tolerence)
    break;
  end
end
fprintf("Iteration terminated at itr:%d ",itr)
    fprintf("Total Power Generated is : %0.2f MW\nPower generatators is\n",P_total(itr))
    for i=[1:n]
      fprintf("Generator (%d) : %0.2f MW\n",i,P(i))
    end
#plot([1:itr],P_total,[1:itr],P_load);
