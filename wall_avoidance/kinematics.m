
x = rand * 10 + 75; y = rand * 10 + 75; %initial position
head = 0; %initial head angle
r = 55/2; % robot radius
L=55;
hold off;
[wallsx,wallsy,wallsr, long]=mapenv();
while true
    Vl=15*rand;
    Vr=15*rand;
    if abs(Vl-Vr)<0.1
        Vr=Vr+1;
    end
    theta = 100*rand;
    angle = 360*rand
    for t = 0:0.1:5
        mapenv();
        angle = 0:0.1:2*pi+0.2;
        R=L*(Vr+Vl)/(2*(Vr-Vl));
        w=(Vr-Vl)/L;
        theta = theta + w*0.1;
        x = x + R*0.1*w*cos(theta);
        y = y + R*w*0.1*sin(theta);
        %x = R*(sin(o_ang+w*t)-sin(o_ang)); %x position change
        %y = R*(cos(o_ang)-cos(o_ang+w*t));
        %if x<0 || x>1100 || y<0 || y>1100
        %    x=75;y=75;
        %end


        sensor = IRsensor_reading(head, [x,y],wallsx,wallsy,wallsr,0)

        VLs = 0:2:15;
        VRs = 1:2:15;
        sum(sensor)

        for VL_ = VLs
            for VR_ = VRs
                



        rx = x + 0.1*r * cos(angle); ry = y + 0.1*r * sin(angle); % robot drawing  
        head = theta; % change head angle
        plot(rx,ry); % draw robot body
        hold on;
        head_line = line([x x+r*cos(head)], [y y+r*sin(head)]); % mark head
        axis([0 long 0 long])
        pause(0.01); %you can control the speed of animation with this
        %delete(head_line);  
        hold off;
    end
end