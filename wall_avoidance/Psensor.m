function [D] = Psensor(T,head,a,b,r,onum) % 맵과 방향 처음 위치를 받는다.
 %T는 센서의 위치
 %head는 센서의 방향
 %onum은 장애물의 개수
 %Mdistance(a,b,X,Y,onum)
 %(a,b)는 장애물 중심 좌표
 %r은 장애물 반지름

 noise = 10; % 퍼센트(%) 단위

 kk=0;
 C = 61; % 센서와 장애물간 감지된 거리 (초기값)
 stop = 0; % 센서감지 작동 중지 플래그
 
 % 3 Lays
 max_dir=40/180.0*pi; % 양옆 40도 각도
 C_3 = zeros(1,3); % 3 Lays 센서값
 head_origin = head; % 기준 Lay 각도 = 센서 head

 for cnt = 1:3 % 센서 베어링 범위 내 3 Lays
     for i = 1:1:13

        if (stop == 0)
            sensor_dir= (cnt-2)*max_dir; % -40, 0 ,40
            
            head = head_origin + sensor_dir;
            
            % X, Y는 센서의 센싱되는 위치
            X = T(1) + 5*(i-1)*cos(head); % 5mm씩 각 센서에 주어진 방향으로 이동
            Y = T(2) + 5*(i-1)*sin(head);

            if((X>=30)&&(X<=1070)&&(Y>=30)&&(Y<=1070))   % 벽 안에 있을 때
                [d, k, kk] = Mdistance(a,b,r,X,Y,onum,kk);

                % 장애물 위험 감지(kk)
                if(kk==1)                                 % 장애물 안에 있을 때
                    stop=1;

                    C = 5*(i-1);

                    for t = 1:1:5                         % 하나씩 줄이면서 측정
                        X = X-t*cos(head);
                        Y = Y-t*sin(head);
                        [d, k, kk] = Mdistance(a,b,r,X,Y,onum,kk);

                        if(kk==0)
                            C = C-t;
                        end
                    end
                end
            else                              % 벽 밖에 있을 때
                C = 5*(i-1);
                xx = X;
                yy = Y;

                for t = 1:1:5                 % 하나씩 줄이면서 측정       
                    X = xx-t*cos(head);
                    Y = yy-t*sin(head);

                    if((X>=30)&&(X<=1070)&&(Y>=30)&&(Y<=1070))&&(stop ==0)
                        C = C-t;
                        stop = 1;
                    end
                end
            end
        end
     end

     C_3(cnt) = C;
 end
 
D_3 = 0;
for cnt = 1:3
    C=C_3(cnt);
    
	if (C <= 20) %Tmp는 센서 값.
        Tmp = 1023;
	elseif ((C <=25)&&(C > 20))
        Tmp = 1023 - (((1023-756)/5)*(C-20));
	elseif ((C <= 30)&&(C > 25))
        Tmp = 756 - (((756-400)/5)*(C-25));  
	elseif ((C <=35)&&(C >30))
        Tmp = 400 - (((400-260)/5)*(C-30));   
	elseif ((C <=40)&&(C >35))
        Tmp = 260 - (((260-145)/5)*(C-35));   
	elseif ((C <=45)&&(C >40))
        Tmp = 145 - (((145-92)/5)*(C-40));  
	elseif ((C <=50)&&(C >45))
        Tmp = 92 - (((92-74)/5)*(C-45));   
	elseif ((C <=55)&&(C >50))
        Tmp = 74 - (((74-60)/5)*(C-50));  
	elseif ((C <=60)&&(C > 55))
        Tmp = 60 - (((60-48)/5)*(C-55)); 
    else
        Tmp = 0;    
    end
    
    D_3 = D_3+Tmp;
end
D_3 = D_3/3.0;

	D_3 = D_3 + (rand*noise*2 - noise)/100 * 1024; % 센서에 노이즈값 포함 (-noise ~ noise, %)
    
    D=D_3;
    % 범위 맞추기 (0 ~ 1023)
	if D > 1023
        D = 1023;
	elseif D < 0 
        D = 0;
	end
 
end