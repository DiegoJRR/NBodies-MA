classdef Body < handle
    properties
        r {mustBeNumeric}
        v {mustBeNumeric}
        a {mustBeNumeric}
        
        m {mustBeNumeric}
        lineStyle;
        
        pos = [];
        G = 6.67408*10^(-11);
    end
    methods
        function obj = Body(lineStyle, r, v, a, m)
            arguments
                lineStyle = 'k.-';
                r (1, :) {mustBeNumeric} = rand(3, 1)'*10^8
                v (1, :) {mustBeNumeric} = [0; 0; 0]'';
                a (1, :) {mustBeNumeric} = [0; 0; 0]'';
                m {mustBeNumeric} = rand(1)*10^24;
            end

            obj.r = r;
            obj.v = v;
            obj.a = a;
            obj.m = m;
            obj.lineStyle = lineStyle
        end
        
        function plotPosition(obj)
            plot3(obj.r(:,1), obj.r(:,2), obj.r(:,3), obj.lineStyle);
        end
        
        function obj = updateBody(obj, body2, body3, dt, ti)
            % Deprecated function, now uses the system.updateBodies method
           arguments
              obj Body
              body2 Body
              body3 Body
              dt {mustBeNumeric}
              ti {mustBeNumeric}
           end
           
           obj.a = - obj.G*body2.m*(obj.r - body2.r)/(norm(obj.r - body2.r))^3;
           obj.a = obj.a - obj.G*body3.m*(obj.r - body3.r)/(norm(obj.r - body3.r))^3;
           
           obj.v = obj.v + obj.a*dt;
           obj.r = obj.r + obj.v*dt;
        end
        
        function energy = kineticEnergy(obj)
           energy = 0.5*norm(obj.v)^2*obj.m; 
        end
    end
end



