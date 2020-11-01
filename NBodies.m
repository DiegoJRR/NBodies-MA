%% Código de los Mecanicos para el proyecto de MA, Nov 2020, ITESM. 


% Datos recolectados de: https://ssd.jpl.nasa.gov/horizons.cgi#results
Mj = 1898.13*10^24; % Masa de Jupiter
Ms = 1.989*10^30; % Masa del Sol
rs = [0; 0; 0]; % Posición del Sol
Me = 479.7*10^20; % Masa de Europa (JII)
Mh = 7.9*10^18; % Masa del asteroide 624 Hektor (Jupiter Trojan)

% Posición y velocidades de 624 Hektor (Jupiter Trojan) respecto al Sol en [m-s] @ 1/11/2020 2:25 pm
rh = [7.432423254845194E+08; 2.594436062290894E+08; 1.533938973555800E+08]*10^3;
vh = [-4.795677020573542E+00; 1.139179946786777E+01; 3.103174084932687E+00]*10^3;

% Posición y velocidades de Europa (JII) respecto al Sol en [m-s] @ 1/11/2020 2:25 pm
re = [3.981616947336732E+08; -6.529893976951566E+08; -6.203331071809828E+06]*10^3;
ve = [3.012358971819925E+00; -3.596445838994409E+00; -8.863453996235267E-01]*10^3;

% Posición y velocidades de Jupiter respecto al Sol en [m-s] @ 1/11/2020 2:25 pm
rj = [3.987115520646092E+08; -6.533832063869169E+08; -6.206784291675091E+06]*10^3;
vj = [1.100944861615655E+01; 7.430254320173791E+00; -2.770895672340354E-01]*10^3;

% Define un nuevo sistema, dado un valor de G
system = System(6.67408*10^(-11));

%% Caso: Sol, Jupiter, Europa (JII)
system.bodies = [Body('k.-', rs, [0;0;0], Ms), Body('b.-', rj, vj, Mj), Body('c.-', re, ve, Me)];

dt = 60*60; % Con deltas de una hora 
N = 1000;

energyLog = NaN * ones(N,1);

for ti = 1:N
    % Calcula y actualiza las coordenadas de los cuerpos
    system.updateBodies(dt, 0.001)
    
    % Calcula y registra la energía mecánica del sistema
    energyLog(ti) = system.calculateEnergy();
end

%plot(t', energyLog)
disp("Porcentaje de energía conservada: " + energyLog(end)*100/energyLog(1) + "%")