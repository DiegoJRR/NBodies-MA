%% Código de los Mecanicos para el proyecto de MA, Nov 2020, ITESM. 
% Datos recolectados de: https://ssd.jpl.nasa.gov/horizons.cgi
Ms = 1.989*10^30; % Masa del Sol
rs = [0; 0; 0]; % Posición del Sol respecto al Sol
vs = [0; 0; 0]; % Velocidad del Sol respecto al Sol
G = 6.6*10^(-11);

% Posición y velocidades de 624 Hektor (Jupiter Trojan) respecto al Sol en [m-s] @  2020-Nov-01 00:01:00.0000 TDB 
Mh = 7.9*10^18;
rh = [7.432423254845194E+08; 1.770182666063152E+08; 2.439368890651525E+08]*10^3;
vh = [-4.795677020573542E+00; 9.217399904591785E+00; 7.378504151678817E+00]*10^3;

% Posición y velocidades de Europa (JII) respecto al Sol en [m-s] @ 2020-Nov-01 00:01:00.0000 TDB 
Me = 479.7*10^20;
re = [3.9E+08; -5.966385157156168E+08; -2.6E+08]*10^3;
ve = [3.0E+00; -2.947106592245137E+00; -2.2E+00]*10^3;

% Posición y velocidades de Jupiter respecto al Sol en [m-s] @  2020-Nov-01 00:01:00.0000 TDB 
Mj = 1898.13*10^24;
rj = [3.9E+08; -5.9E+08; -2.6E+08]*10^3;
vj = [1.1E+01; 6.9E+00; 2.7E+00]*10^3;

% Posición y velocidades de la Tierra respecto al Sol en [m-s] @  2020-Nov-01 00:01:00.0000 TDB
Mt = 5.97219*10^24;
rt = [1.1E+08; 8.5E+07; 3.6E+07]*10^3;
vt = [-1.9E+01; 2.1E+01; 9.2E+00]*10^3;

% Posición y velocidades de Marte respecto al Sol en [m-s] @  2020-Nov-01 00:01:00.0000 TDB
Mm =  6.4171 *10^23;
rm = [1.8E+08; 1.0E+08; 4.2E+07]*10^3;
vm = [-1.1E+01; 2.0E+01; 9.7E+00]*10^3;

% Posición y velocidades de Mercurio respecto al Sol en [m-s] @  2020-Nov-01 00:01:00.0000 TDB
Mme = 3.302*10^23;
rme = [1.5E+07; 3.8E+07; 1.9E+07]*10^3;
vme = [-5.5E+01; 1.4E+01; 1.3E+01]*10^3;

%% Caso: Sol, Jupiter, Europa (JII)
%system.bodies = [Body('k.-', rs, vs, Ms), Body('b.-', rj, vj, Mj), Body('c.-', re, ve, Me)];

%system = System(1);
%system.bodies = [Body('k.-', [0 0 0], [0 0 0], 1*10^7), Body('b.-', [800 200 0], [0 -70.5 0], 5*10^3), Body('c.-', [810 190 8], [10 -70 -10.5], 1*10^-7)];
%dt = 0.05; 
%N = 500;

%% Sistema de 3 cuerpos en triangulo equilatero
% system = System(1);
% M = 2550;
% system.bodies = [Body('k.-', [1000; 0; 0]*1.5, [0; 1.005; 0], M), Body('b.-', [-500; sqrt(3)*500; 0]*1.5, [-0.87 ; -0.51; 0], M), Body('c.-', [-500; -sqrt(3)*500; 0]*1.5, [0.889 ; -0.491; 0], M)];
% dt = 5;
% N = 600;

%% Caso: Sol, Jupiter, 624 Hektor
system = System(G);
system.bodies = [Body('k.-', rs, vs, Ms), Body('b.-', rj, vj, Mj), Body('c.-', rh, vh, Mh)];
dt = 60*60*24*30;
N = 150;

%% Sistema de 5 cuerpos: Sol, Mercurio, Tierra, Marte, Jupiter
%system = System(G);
%system.bodies = [Body('y.-', rs, vs, Ms), Body('b.-', rj, vj, Mj), Body('m.-', rt, vt, Mt), Body('c.-', rme, vme, Mme), Body('r.-', rm, vm, Mm), Body('g.-', rh, vh, Mh)];
%dt = 60*60*24*5;
%N = 120;

%% Inicio de simulación

% energyLog = NaN * ones(N,1);
Ei = system.calculateEnergy();
Ef = Ei;

for ti = 1:N
    % Calcula y actualiza las coordenadas de los cuerpos
    system.updateBodies(dt, 0.05)
    view(3);
    
    %zlim([-100,100])
    
    % Calcula y registra la energía mecánica del sistema
    %energyLog(ti) = system.calculateEnergy();
    Ef = system.calculateEnergy();
end

%plot(t', energyLog)
disp("Porcentaje de energía conservada: " + Ef*100/Ei + "%")