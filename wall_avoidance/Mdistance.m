function [d i k]= Mdistance(a,b,r,X,Y,onum,k)
      % onum은 장애물의 개수
      % (a,b)는 장애물의 위치
      % r은 장애물 반지름
      % (X,Y)는 센서의 위치
      % d는 거리, i는 장애물 번호.
      
     % if obstacles exists in arena
     if onum >= 1
         for i = 1:1:onum % 모든 장애물에 대해 조사
             tmp(i) = ((X-a(i))^2+(Y-b(i))^2)^(0.5); % 장애물의 중심과 센서간의 거리
             if(r(i)>tmp(i)) % 장애물의 반지름 보다 거리가 가까워지면
                 k = 1; % 충돌 위험 감지
             end
         end
         
         [d i] = min(tmp); % 가장 가까운 장애물과의 거리, 장애물번호 반환
         
     % if no obstacles exists in arena
     else
         d = 999;
         i = 1;
         k = 0; % 벽 안에 장애물없음 (충돌위험 없음)
     end
     
end


