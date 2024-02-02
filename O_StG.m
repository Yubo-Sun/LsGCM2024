function [stg_weight]=O_StG(Datafilepath)

[~,STG_Weight]=I_StG(Datafilepath);% Weight matrix STG_Weight loading

%%

Anodes_number=24;
beta=0.34;


stg_weight=zeros(size(STG_Weight,1),size(STG_Weight,2));

SK=zeros(1,size(STG_Weight,1));
for i=1:size(STG_Weight,1)
    SK(1,i)=Bowley_SK(nonzeros(STG_Weight(i,:)));%Bowley’s Coefficient of Skewness
end

for i=1:size(STG_Weight,1)
    for j=i:ceil(i/Anodes_number)*Anodes_number
        
        if isnan(SK(i)) || isnan(SK(j))
            
            stg_weight(i,j)= STG_Weight(i,j); 
            
        else
            
            L_Row_lim=(0.5-0.25*sign(SK(i)))*( max(nonzeros(STG_Weight(i,:))) - min(nonzeros(STG_Weight(i,:))) ) + min(nonzeros(STG_Weight(i,:)));
            L_Col_lim=(0.5-0.25*sign(SK(j)))*( max(nonzeros(STG_Weight(:,j))) - min(nonzeros(STG_Weight(:,j))) ) + min(nonzeros(STG_Weight(:,j)));
            
            f_Row_beta=2*(max(nonzeros(STG_Weight(i,:))) -  min(nonzeros(STG_Weight(i,:))))/pi*atan(beta*  tan( pi*(STG_Weight(i,j)- min(nonzeros(STG_Weight(i,:))) )/(2*(max(nonzeros(STG_Weight(i,:)))-min(nonzeros(STG_Weight(i,:))))) )    )+min(nonzeros(STG_Weight(i,:)));
            f_Col_beta=2*(max(nonzeros(STG_Weight(:,j))) -  min(nonzeros(STG_Weight(:,j))))/pi*atan(beta*  tan( pi*(STG_Weight(i,j)- min(nonzeros(STG_Weight(:,j))) )/(2*(max(nonzeros(STG_Weight(:,j)))-min(nonzeros(STG_Weight(:,j))))) )    )+min(nonzeros(STG_Weight(:,j)));
            
            if f_Row_beta>=L_Row_lim || f_Col_beta>=L_Col_lim
                
                stg_weight(i,j)=STG_Weight(i,j);
                
            else
                stg_weight(i,j)=0;
            end
 
        end
        
        if i<=Anodes_number*(size(STG_Weight,1)/Anodes_number-1)
             
            if isnan(SK(i)) || isnan(SK(j))
                
                stg_weight(i,j)= STG_Weight(i,j); 
                
            else
                
                L_Row_lim=(0.5-0.25*sign(SK(i)))*( max(nonzeros(STG_Weight(i,:))) - min(nonzeros(STG_Weight(i,:))) ) + min(nonzeros(STG_Weight(i,:)));
                L_Col_lim=(0.5-0.25*sign(SK(j)))*( max(nonzeros(STG_Weight(:,j))) - min(nonzeros(STG_Weight(:,j))) ) + min(nonzeros(STG_Weight(:,j)));
                
                f_Row_beta=2*(max(nonzeros(STG_Weight(i,:))) -  min(nonzeros(STG_Weight(i,:))))/pi*atan(beta*  tan( pi*(STG_Weight(i,j)- min(nonzeros(STG_Weight(i,:))) )/(2*(max(nonzeros(STG_Weight(i,:)))-min(nonzeros(STG_Weight(i,:))))) )    )+min(nonzeros(STG_Weight(i,:)));
                f_Col_beta=2*(max(nonzeros(STG_Weight(:,j))) -  min(nonzeros(STG_Weight(:,j))))/pi*atan(beta*  tan( pi*(STG_Weight(i,j)- min(nonzeros(STG_Weight(:,j))) )/(2*(max(nonzeros(STG_Weight(:,j)))-min(nonzeros(STG_Weight(:,j))))) )    )+min(nonzeros(STG_Weight(:,j)));
                
                if f_Row_beta>=L_Row_lim || f_Col_beta>=L_Col_lim
                    
                   stg_weight(i,j)=STG_Weight(i,j);
                    
                else
                    stg_weight(i,j)=0;
                end
      
            end
            
        end
    
    end
end

stg_weight=stg_weight+stg_weight';

end


