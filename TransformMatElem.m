% function g = TransformMatElem(alpha,d,theta,r)
%     rot_x = [1,0,0,0;0,cos(alpha),-sin(alpha),0;0,sin(alpha),cos(alpha),0;0,0,0,1];
%     trans_x = [eye(3),[d;0;0];[0,0,0,1]];
%     rot_z = [cos(theta), -sin(theta),0,0;sin(theta),cos(theta),0,0;0,0,1,0;0,0,0,1];
%     trans_z = [eye(3),[0;0;r];[0,0,0,1]];
%     g=rot_x*trans_x*rot_z*trans_z;
% end

function g = TransformMatElem(alpha,d,theta,r)
    g=[cos(theta),-sin(theta),0,d;
        cos(alpha)*sin(theta), cos(alpha)*cos(theta), -sin(alpha), -r*sin(alpha);
        sin(alpha)*sin(theta), sin(alpha)*cos(theta), cos(alpha), r*cos(alpha);
        0,0,0,1];
end

