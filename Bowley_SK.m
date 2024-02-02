function [Bowley_Sk]=Bowley_SK(STG_W)
% Bowley's Coefficient of Skewness

Q1=prctile(STG_W,25);
Q2=prctile(STG_W,50);
Q3=prctile(STG_W,75);
Bowley_Sk=(Q3-2*Q2+Q1)/(Q3-Q1);

end
