%% Código de los Mecanicos para el proyecto de MA, Nov 2020, ITESM. 
% Datos recolectados de: https://ssd.jpl.nasa.gov/horizons.cgi
Ms = 1.989*10^30; % Masa del Sol
rs = [0; 0; 0]; % Posición del Sol respecto al Sol
vs = [0; 0; 0]; % Velocidad del Sol respecto al Sol

% Posición y velocidades de 624 Hektor (Jupiter Trojan) respecto al Sol en [m-s] @  2020-Nov-01 00:01:00.0000 TDB 
Mh = 7.9*10^18;
rh = [7.432423254845194E+08; 1.770182666063152E+08; 2.439368890651525E+08]*10^3;
vh = [-4.795677020573542E+00; 9.217399904591785E+00; 7.378504151678817E+00]*10^3;

% Posición y velocidades de Europa (JII) respecto al Sol en [m-s] @ 2020-Nov-01 00:01:00.0000 TDB 
Me = 479.7*10^20;
re = [3.981616947336732E+08; -5.966385157156168E+08; -2.654357104523347E+08]*10^3;
ve = [3.012358971819925E+00; -2.947106592245137E+00; -2.243790002250488E+00]*10^3;

% Posición y velocidades de Jupiter respecto al Sol en [m-s] @  2020-Nov-01 00:01:00.0000 TDB 
Mj = 1898.13*10^24;
rj = [3.987115520646092E+08; -5.969984545142169E+08; -2.655955268210070E+08]*10^3;
vj = [1.100944861615655E+01; 6.927344955364256E+00; 2.701360723805806E+00]*10^3;

% Posición y velocidades de la Tierra respecto al Sol en [m-s] @  2020-Nov-01 00:01:00.0000 TDB
Mt = 5.97219*10^24;
rt = [1.158072924429310E+08; 8.524969138403501E+07; 3.695545309284867E+07]*10^3;
vt = [-1.911908618220732E+01; 2.120730556918139E+01; 9.192445870848287E+00]*10^3;

% Posición y velocidades de Marte respecto al Sol en [m-s] @  2020-Nov-01 00:01:00.0000 TDB
Mm =  6.4171 *10^23;
rm = [1.828647882074063E+08; 1.038311606171984E+08; 4.269069340916425E+07]*10^3;
vm = [-1.174989869013095E+01; 2.053875160813733E+01; 9.737697936545949E+00]*10^3;

% Posición y velocidades de Mercurio respecto al Sol en [m-s] @  2020-Nov-01 00:01:00.0000 TDB
Mme = 3.302*10^23;
rme = [1.556075127245677E+07; 3.888915173485027E+07; 1.916142169417799E+07]*10^3;
vme = [-5.559700117912301E+01; 1.419569860178160E+01; 1.334611086431540E+01]*10^3;


%% Caso: Sol, Jupiter, Europa (JII)
system = System(6.67408*10^(-11));
system.bodies = [Body('k.-', rs, vs, Ms), Body('b.-', rj, vj, Mj), Body('c.-', re, ve, Me)];
dt = 60*60*12;  
N = 300;

%% Caso: Sol, Jupiter, 624 Hektor
%system = System(6.67408*10^(-11));
%system.bodies = [Body('k.-', rs, vs, Ms), Body('b.-', rj, vj, Mj), Body('c.-', rh, vh, Mh)];
%dt = 60*60*24*30;
%N = 150;

%% Caso: Sistema de 3 cuerpos en triangulo equilatero
%system = System(1);
%M = 2550;
%system.bodies = [Body('k.-', [1000; 0; 1]*1.5, [0.00005; 1.005; 0], M), Body('b.-', [-500; sqrt(3)*500; 1]*1.5, [-0.87 ; -0.51; 0], M), Body('c.-', [-500; -sqrt(3)*500; 1]*1.5, [0.889 ; -0.491; 0], M)];
%dt = 40;
%N = 100;

%% Inicio de simulación
% energyLog = NaN * ones(N,1);
Ei = system.calculateEnergy();
Ef = Ei;

pause(1)

for ti = 1:N
    % Calcula y actualiza las coordenadas de los cuerpos
    system.updateBodies(dt, 0.05)
    
    % Calcula y registra la energía mecánica del sistema
    %energyLog(ti) = system.calculateEnergy();
    Ef = system.calculateEnergy();
end

%plot(t', energyLog)
disp("Porcentaje de energía conservada: " + Ef*100/Ei + "%")