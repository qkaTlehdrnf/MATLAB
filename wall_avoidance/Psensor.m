function [D] = Psensor(T,head,a,b,r,onum) % �ʰ� ���� ó�� ��ġ�� �޴´�.
 %T�� ������ ��ġ
 %head�� ������ ����
 %onum�� ��ֹ��� ����
 %Mdistance(a,b,X,Y,onum)
 %(a,b)�� ��ֹ� �߽� ��ǥ
 %r�� ��ֹ� ������

 noise = 10; % �ۼ�Ʈ(%) ����

 kk=0;
 C = 61; % ������ ��ֹ��� ������ �Ÿ� (�ʱⰪ)
 stop = 0; % �������� �۵� ���� �÷���
 
 % 3 Lays
 max_dir=40/180.0*pi; % �翷 40�� ����
 C_3 = zeros(1,3); % 3 Lays ������
 head_origin = head; % ���� Lay ���� = ���� head

 for cnt = 1:3 % ���� ��� ���� �� 3 Lays
     for i = 1:1:13

        if (stop == 0)
            sensor_dir= (cnt-2)*max_dir; % -40, 0 ,40
            
            head = head_origin + sensor_dir;
            
            % X, Y�� ������ ���̵Ǵ� ��ġ
            X = T(1) + 5*(i-1)*cos(head); % 5mm�� �� ������ �־��� �������� �̵�
            Y = T(2) + 5*(i-1)*sin(head);

            if((X>=30)&&(X<=1070)&&(Y>=30)&&(Y<=1070))   % �� �ȿ� ���� ��
                [d, k, kk] = Mdistance(a,b,r,X,Y,onum,kk);

                % ��ֹ� ���� ����(kk)
                if(kk==1)                                 % ��ֹ� �ȿ� ���� ��
                    stop=1;

                    C = 5*(i-1);

                    for t = 1:1:5                         % �ϳ��� ���̸鼭 ����
                        X = X-t*cos(head);
                        Y = Y-t*sin(head);
                        [d, k, kk] = Mdistance(a,b,r,X,Y,onum,kk);

                        if(kk==0)
                            C = C-t;
                        end
                    end
                end
            else                              % �� �ۿ� ���� ��
                C = 5*(i-1);
                xx = X;
                yy = Y;

                for t = 1:1:5                 % �ϳ��� ���̸鼭 ����       
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
    
	if (C <= 20) %Tmp�� ���� ��.
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

	D_3 = D_3 + (rand*noise*2 - noise)/100 * 1024; % ������ ����� ���� (-noise ~ noise, %)
    
    D=D_3;
    % ���� ���߱� (0 ~ 1023)
	if D > 1023
        D = 1023;
	elseif D < 0 
        D = 0;
	end
 
end