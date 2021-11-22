function [d i k]= Mdistance(a,b,r,X,Y,onum,k)
      % onum�� ��ֹ��� ����
      % (a,b)�� ��ֹ��� ��ġ
      % r�� ��ֹ� ������
      % (X,Y)�� ������ ��ġ
      % d�� �Ÿ�, i�� ��ֹ� ��ȣ.
      
     % if obstacles exists in arena
     if onum >= 1
         for i = 1:1:onum % ��� ��ֹ��� ���� ����
             tmp(i) = ((X-a(i))^2+(Y-b(i))^2)^(0.5); % ��ֹ��� �߽ɰ� �������� �Ÿ�
             if(r(i)>tmp(i)) % ��ֹ��� ������ ���� �Ÿ��� ���������
                 k = 1; % �浹 ���� ����
             end
         end
         
         [d i] = min(tmp); % ���� ����� ��ֹ����� �Ÿ�, ��ֹ���ȣ ��ȯ
         
     % if no obstacles exists in arena
     else
         d = 999;
         i = 1;
         k = 0; % �� �ȿ� ��ֹ����� (�浹���� ����)
     end
     
end


