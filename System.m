classdef System < handle
    properties
        bodies = [];
        G {mustBeNumeric}
    end
    methods
        function obj = System(G)
            arguments
                G {mustBeNumeric} = 6.67408*10^(-11);
            end

            obj.G = G;
        end

        function updateBodies(obj, dt, pauseTime)
            arguments
                obj System
                dt {mustBeNumeric}
                pauseTime {mustBeNumeric} = 0.05;
            end

            sizeOfSystem = size(obj.bodies);
            N = sizeOfSystem(2);

            for bodyIDX = 1:N
                % Setting the indexes for the other bodies
                otherBodiesIDXS = setdiff(1:N, bodyIDX); 

                % Set the acceleration to 0, so it overrides with the new accelerations
                obj.bodies(bodyIDX).a = 0;
                % This loop calculates the net new acceleration
                for otherBodyIDX = 1:N-1
                    % Values from the other body
                    m = obj.bodies(otherBodiesIDXS(otherBodyIDX)).m;
                    r = obj.bodies(otherBodiesIDXS(otherBodyIDX)).r;

                    a = obj.G*m*(obj.bodies(bodyIDX).r - r)/(norm(obj.bodies(bodyIDX).r - r))^3;
                    obj.bodies(bodyIDX).a = obj.bodies(bodyIDX).a - a;
                end

                % Updates the velocity and position vectors, Euler method
                obj.bodies(bodyIDX).v = obj.bodies(bodyIDX).v + obj.bodies(bodyIDX).a*dt;
                obj.bodies(bodyIDX).r = obj.bodies(bodyIDX).r + obj.bodies(bodyIDX).v*dt;


                % Plotting
                hold on
                obj.bodies(bodyIDX).plotPosition()
                pause(pauseTime);
                hold off
            end
        end

        function energy = calculateEnergy(obj)
            sizeMatrix = size(obj.bodies);
            N = sizeMatrix(2);

            kineticEnergy = 0;
            potentialEnergy = 0;
            
            for bodyIDX = 1:N
                kineticEnergy = kineticEnergy + obj.bodies(bodyIDX).kineticEnergy;
                
                otherBodiesIDXS = setdiff(1:N, bodyIDX);
                for otherBodyIDX = 1:N-1
                    m = obj.bodies(bodyIDX).m;
                    M = obj.bodies(otherBodiesIDXS(otherBodyIDX)).m;
                    r1 = obj.bodies(bodyIDX).r;
                    r2 = obj.bodies(otherBodiesIDXS(otherBodyIDX)).r;
                    
                    potentialEnergy = potentialEnergy + -obj.G*m*M/norm(r1 - r2);
                end
            end
            
            potentialEnergy = potentialEnergy/N;
            
            energy = kineticEnergy + potentialEnergy;
        end
    end
end



