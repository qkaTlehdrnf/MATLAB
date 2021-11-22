close all; clear; clc;
figure(1);

%%

x=150; % 로봇 위치 좌표
y=150;
head = 0; % 로봇 헤드 각도 (ex. 6/pi)

% 장애물 그리기
objx = [80 190 160]; %장애물 좌표
objy = [150 190 60];
oradius = [20 20 20]; % 장애물 반지름
objectNumber = 3; % 장애물 갯수

angle_360=0:0.1:2*pi+0.2; % 0~360도 배열
%장애물 갯수만큼 원 그려주기
for i = 1:objectNumber 
    xx=oradius(i)*cos(angle_360) + objx(i); yy=oradius(i)*sin(angle_360) + objy(i);
    fill(xx,yy,'g');
    
    hold on
end

% robot body
L=55; % 로봇 지름

rx=x+L/2*cos(angle_360);
ry=y+L/2*sin(angle_360);

% 로봇 그리기
%body
plot(rx,ry, 'b', 'LineWidth', 2);
hold on;
%head
plot([x x+L/2*cos(head)], [y y+L/2*sin(head)], 'c', 'LineWidth', 2);
hold on;
axis([0 300 0 300]);

% IR Sensor Test
[IR] = IRsensor_reading (head, [x y], objx, objy, oradius, objectNumber);

round(IR) % 명령 창에 IR 센서값 출력