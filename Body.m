classdef Body < handle
    properties
        r {mustBeNumeric}
        v {mustBeNumeric}
        a {mustBeNumeric}
        
        m {mustBeNumeric}
        
        pos = [];
        G = 6.67408*10^(-11);
    end
    methods
        function obj = Body()
            obj.r = rand(3, 1)'*10^8;
            obj.v = rand(3, 1)';
            obj.a = rand(3, 1)';
            obj.m = rand(1)*10^24;
        end
        
        function plotPosition(obj)
            plot3(obj.r(:,1), obj.r(:,2), obj.r(:,3), 'k.-');
        end
        
        function obj = updateBody(obj, body2, body3, dt, ti)
           arguments
              obj Body
              body2 Body
              body3 Body
              dt {mustBeNumeric}
              ti {mustBeNumeric}
           end
           
           obj.a = obj.G*body2.m*(obj.r - body2.r)/norm(obj.r - body2.r)^3;
           obj.a = obj.a + obj.G*body3.m*(obj.r - body3.r)/norm(obj.r - body3.r)^3;
           
           obj.v = obj.v + obj.a*dt;
           obj.r = obj.r + obj.v*dt;
           
           obj.pos(ti, 1:3) = obj.r;
        end
    end
end



