
x = 200 + rand * 100 ; y = 800 +rand * 100 ; %initial position
head = 0; %initial head angle
r = 55/2; % robot radius
L=55;
hold off;
[wallsx,wallsy,wallsr, long, onum]=mapenv();
theta = 360*rand;

robot_x = x; robot_y = y;
step = 0;
showplot = 1;
R2B = 0;
while true
    step = step +1
    if step > 2;
        R2B = 1
    else
        Vl=50*rand+20;
        Vr=50*rand+20;
        if abs(Vl-Vr)<0.1
            Vr=Vr+1;
        end
        R=L*(Vr+Vl)/(2*(Vr-Vl));
        w=(Vr-Vl)/L;
    end
    for t = 0:0.1:5
        if x<200 && y<200
            R2B = 0;
            step = 0;
        end
        mapenv();
        if R2B
            tandeg = (y-50)/(x-50);
            theta = atan(y/x) + pi;
            cosdeg = 1/(tandeg^2+1)^.5;
            sindeg = tandeg*cosdeg;
            x = x - 10*cosdeg;
            y = y - 10*sindeg;
        else 
            theta = theta + w*0.1;
            x = x + R*0.1*w*cos(theta);
            y = y + R*w*0.1*sin(theta);
        end
        %x = R*(sin(o_ang+w*t)-sin(o_ang)); %x position change
        %y = R*(cos(o_ang)-cos(o_ang+w*t));
        %if x<0 || x>1100 || y<0 || y>1100
        %    x=75;y=75;
        %end
        sensor = IRsensor_reading(head, [x,y],wallsx,wallsy,wallsr,long,onum,showplot);
        loss = (sum(sensor) + 1)^.5;
        angles = -loss:loss;
        min_loss = loss;
        if loss > 25
            R2B = 0;
            showplot=0;
            for theta_change = angles(randperm(numel(angles),uint8(min_loss^.5)))
                ptheta = theta + theta_change + w*0.1; % change head angle
                px = x + R*0.1*w*cos(ptheta); 
                py = y + R*w*0.1*sin(ptheta); 
                sensor = IRsensor_reading(ptheta, [px,py],wallsx,wallsy,wallsr,long,onum,0);
                loss = sum(sensor)^.5;
                if loss <= min_loss
                    theta_change;
                    x=px;y=py;theta=ptheta;
                end
            end
        else
            showplot=1;
        end

        hold on;
        angle = 0:0.1:2*pi+0.2;
        rx = x + 0.1*r * cos(angle); ry = y + 0.1*r * sin(angle); % robot drawing  
        head = theta; % change head angle
        plot(rx,ry); % draw robot body
        head_line = line([x x+r*cos(head)], [y y+r*sin(head)]); % mark head
        axis([0 long 0 long]);
        pause(0.01); %you can control the speed of animation with this
        %delete(head_line);  
        hold off;
    end
end
