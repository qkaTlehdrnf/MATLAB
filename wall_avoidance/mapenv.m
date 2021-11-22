function [xx, yy, rr, long] = mapenv()


% xx yy rr 장애물에 대한 정보
% obstacles in arena
% rr=[ 50  75  48  65  30  58  45  81  47  83]; % 장애물 크기 1
% %rr=[ 35  35  38  35  30  38  35  41  37  43]; % 2
% xx=[ 90 200 230 780 600 920 450 570 420 880];
% yy=[600 700 360 610 820 330 550 250 890 950];
% 

%% non-obstacles in arena
rr = [ 50  75  48  65  30  58  45  81  47  83];
xx = [ 90 200 230 780 600 920 450 570 420 880];
yy = [600 700 360 610 820 330 550 250 890 950];

long = 1100;
t=0:0.1:2*pi+0.1; % 0~360 각도 배열

obstacle_num = 10;
for i = 1:obstacle_num %장애물 갯수만큼 원 그려주기
    x=rr(i)*cos(t) + xx(i); y=rr(i)*sin(t) + yy(i);
    fill(x,y,'g');
    
    hold on
end

%% wall 생성
%아래벽
x = [1 1 long long 1];
y = [1 30 30 1 1];
fill(x, y, 'b*')
hold on
%오른쪽벽
x = [long-30 long-30 long long long-30];
y = [30 long long 30 30];
fill(x, y, 'b*')
hold on
%윗벽
x = [0 0 1070 1070 0];
y = [long-30 long long long-30 long-30];
fill(x, y, 'b*')
hold on
%왼쪽벽
x = [0 0 30 30 0];
y = [30 long-30 long-30 30 30];
fill(x, y, 'b*')
axis([0 long 0 long])
grid on

