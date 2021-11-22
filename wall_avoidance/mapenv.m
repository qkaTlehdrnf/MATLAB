function [xx, yy, rr, long] = mapenv()


% xx yy rr ��ֹ��� ���� ����
% obstacles in arena
% rr=[ 50  75  48  65  30  58  45  81  47  83]; % ��ֹ� ũ�� 1
% %rr=[ 35  35  38  35  30  38  35  41  37  43]; % 2
% xx=[ 90 200 230 780 600 920 450 570 420 880];
% yy=[600 700 360 610 820 330 550 250 890 950];
% 

%% non-obstacles in arena
rr = [ 50  75  48  65  30  58  45  81  47  83];
xx = [ 90 200 230 780 600 920 450 570 420 880];
yy = [600 700 360 610 820 330 550 250 890 950];

long = 1100;
t=0:0.1:2*pi+0.1; % 0~360 ���� �迭

obstacle_num = 10;
for i = 1:obstacle_num %��ֹ� ������ŭ �� �׷��ֱ�
    x=rr(i)*cos(t) + xx(i); y=rr(i)*sin(t) + yy(i);
    fill(x,y,'g');
    
    hold on
end

%% wall ����
%�Ʒ���
x = [1 1 long long 1];
y = [1 30 30 1 1];
fill(x, y, 'b*')
hold on
%�����ʺ�
x = [long-30 long-30 long long long-30];
y = [30 long long 30 30];
fill(x, y, 'b*')
hold on
%����
x = [0 0 1070 1070 0];
y = [long-30 long long long-30 long-30];
fill(x, y, 'b*')
hold on
%���ʺ�
x = [0 0 30 30 0];
y = [30 long-30 long-30 30 30];
fill(x, y, 'b*')
axis([0 long 0 long])
grid on

