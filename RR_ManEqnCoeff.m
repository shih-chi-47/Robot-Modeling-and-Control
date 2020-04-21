function [M,C,P] = RR_ManEqnCoeff(I1,I2,g,l1,lc1,lc2,m1,m2,th1,th2,thd1,thd2)
%RR_MANEQNCOEFF
%    [M,C,P] = RR_MANEQNCOEFF(I1,I2,G,L1,LC1,LC2,M1,M2,TH1,TH2,THD1,THD2)

%    This function was generated by the Symbolic Math Toolbox version 8.4.
%    20-Apr-2020 22:39:29

t2 = cos(th1);
t3 = cos(th2);
t4 = sin(th2);
t5 = th1+th2;
t6 = lc2.^2;
t7 = l1.*t3;
t8 = cos(t5);
t9 = m2.*t6;
t11 = l1.*lc2.*m2.*t4.*thd1;
t12 = l1.*lc2.*m2.*t4.*thd2;
t10 = lc2+t7;
t13 = -t12;
t14 = lc2.*m2.*t10;
t15 = I2+t14;
M = reshape([I1+I2+t9+l1.^2.*m2+lc1.^2.*m1+lc2.*m2.*t7.*2.0,t15,t15,I2+t9],[2,2]);
if nargout > 1
    C = reshape([t13,t11,-t11+t13,0.0],[2,2]);
end
if nargout > 2
    P = [g.*m2.*(l1.*t2+lc2.*t8)+g.*lc1.*m1.*t2;g.*lc2.*m2.*t8];
end
