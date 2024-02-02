function [Anodes_actual_distance_0_1]=StIEM01(Anodes_number,Anode_long,Anode_width,Anode_middle_distance,Anode_side_distance)

% Anodes_number=24;
%%

% Anode_long=1550;
% Anode_width=660;
% Anode_middle_distance=220;
% Anode_side_distance=40;

Anodes_position=zeros(Anodes_number,6);

for i=1:Anodes_number/2
    %for j=1:2
        %if j==1
            Anodes_position(i,:)=[Anode_width/2+(i-1)*(Anode_width+Anode_side_distance) Anode_long+Anode_middle_distance+Anode_long/2 ...
                Anode_width/2+(i-1)*(Anode_width+Anode_side_distance)-Anode_width/2 Anode_long+Anode_middle_distance ...
                Anode_width/2+(i-1)*(Anode_width+Anode_side_distance)+Anode_width/2 Anode_long+Anode_middle_distance];
        %else
            Anodes_position(i+Anodes_number/2,:)=[Anode_width/2+(i-1)*(Anode_width+Anode_side_distance) Anode_long/2 ...
                Anode_width/2+(i-1)*(Anode_width+Anode_side_distance)-Anode_width/2 Anode_long ...
                Anode_width/2+(i-1)*(Anode_width+Anode_side_distance)+Anode_width/2 Anode_long];
        %end
   %end
end


%**************************************************************************

Anodes_actual_distance_1=zeros(Anodes_number/2,Anodes_number/2);
for i=1:Anodes_number/2
   for j=1:Anodes_number/2
      if i==j
          Anodes_actual_distance_1(i,j)=0;
      else
          if i<j
              Anodes_actual_distance_1(i,j)=j-i;
              Anodes_actual_distance_1(j,i)=j-i;
          end
      end
   end
end

%**************************************************************************

Anodes_actual_distance_2=zeros(Anodes_number/2,Anodes_number);
for i=1:1
   for j=(Anodes_number/2+1):Anodes_number
       
       
       
       if i==j-Anodes_number/2
           Anodes_actual_distance_2(i,j)=1;
       else
           
           
           for k=1:(j-i-Anodes_number/2)
               if Point_AboveBelow_Line([Anodes_position(i,1:2) Anodes_position(j,1:2) Anodes_position(i+k,3:4)])~=1
                   Anodes_actual_distance_2(i,j)= Anodes_actual_distance_2(i,j)+1;
               end
           end
           
           for l=1:(j-i-Anodes_number/2)
               if Point_AboveBelow_Line([Anodes_position(i,1:2) Anodes_position(j,1:2) Anodes_position(j-l,5:6)])~=-1
                   Anodes_actual_distance_2(i,j)= Anodes_actual_distance_2(i,j)+1;
               end
           end
           Anodes_actual_distance_2(i,j)=Anodes_actual_distance_2(i,j)+1;
           
       end
       
       
       
   end
end
Anodes_actual_distance_2(:,1:Anodes_number/2)=[];
Anodes_actual_distance_2(2:end,:)=[];
Anodes_actual_distance_21=zeros(Anodes_number/2,Anodes_number/2);
for k=0:Anodes_number/2-1
    for i=1:Anodes_number/2
        for j=1:Anodes_number/2
            if abs(i-j)==k
                Anodes_actual_distance_21(i,j)=Anodes_actual_distance_2(k+1);
            end
        end
    end
end

%**************************************************************************

Anodes_actual_distance=[Anodes_actual_distance_1 Anodes_actual_distance_21;Anodes_actual_distance_21 Anodes_actual_distance_1];
Anodes_actual_distance(logical(eye(size(Anodes_actual_distance))))=0;
Anodes_actual_distance_0_1=reshape(mapminmax(reshape(Anodes_actual_distance,1,Anodes_number*Anodes_number),0,1),Anodes_number,Anodes_number);
end







    