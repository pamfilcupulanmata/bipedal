function [lipmD] = initialiseLIPM(zc)
%INITIALISELIPM Gives the LIPM system as a discrete state space
%representation

g = 9.87;
A = [0   1 0    0
    g/zc 0 0    0
    0    0 0    1
    0    0 g/zc 0]; 
B = [0 0
     1 0
     0 0
     0 1]; 
C = [1 0 0 0
     0 0 1 0]; 
D = [0 0;0 0]; 

Ts = 0.5;

lipm = ss(A,B,C,D); 
lipmD = c2d(lipm, Ts); 

end

