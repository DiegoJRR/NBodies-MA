% Defines a new system with a given G value, and a list of bodies
system = System(6.67408*10^(-11));
system.bodies = [Body('k.-'), Body('b.-'), Body('r.-'), Body('g.-'), Body('c.-')];

dt = 1000;
N = 100;

energyLog = NaN * ones(N,1);

for ti = 1:N
    % Calculates and updates the bodies coordinates
    system.updateBodies(dt)
    
    % Calculates and logs the mechanical energy of the system
    energyLog(ti) = system.calculateEnergy();
end

%plot(t', energyLog)
disp("Energy conserved: " + energyLog(end)*100/energyLog(1) + "%")