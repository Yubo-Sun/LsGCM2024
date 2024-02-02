function [STG_signals,STG_Weight]=I_StG(Datafilepath)

% Data loading
RawData=load(Datafilepath);
Currentdata=RawData(1:8640,4:27)';

%%
%Data information
fs=0.1;
Subtime=5;
Anodes_number=24;

%%
%Storage matrix of spatio-temporal graph information
STG_signals=-1*ones(Anodes_number,Subtime*60*fs,size(Currentdata,2)/(Subtime*60*fs));
STG_Weight=zeros(Anodes_number*size(STG_signals,3),Anodes_number*size(STG_signals,3));

%%
for i=1:size(STG_signals,3)
    STG_signals(:,:,i)=Currentdata(:,Subtime*60*fs*(i-1)+1:Subtime*60*fs*i);
end

% TRE=zeros(2,1000);
% k=1;
STG_signals_2D=zeros(Anodes_number*size(STG_signals,3),Subtime*60*fs);

for i=1:size(STG_signals,3)
    STG_signals_2D(Anodes_number*(i-1)+1:Anodes_number*i,:)=STG_signals(:,:,i);
end


for i=1:size(STG_Weight,1)
    for j=i:ceil(i/Anodes_number)*Anodes_number
        
        % TRE(:,k)=[i;j];
        % k=k+1;
        STG_Weight(i,j)=edr(STG_signals_2D(i,:),STG_signals_2D(j,:),max(std(STG_signals_2D(i,:)),std(STG_signals_2D(j,:)))/4);
        
        if i<=Anodes_number*(size(STG_signals,3)-1)   
        STG_Weight(i,i+Anodes_number)=edr(STG_signals_2D(i,:),STG_signals_2D(i+Anodes_number,:),max(std(STG_signals_2D(i,:)),std(STG_signals_2D(i+Anodes_number,:)))/4);% Reference literature: Robust and fast similarity search for moving object trajectories
        end
        
    end
end

STG_Weight=STG_Weight+STG_Weight';% symmetrization
STG_Weight=STG_Weight/(Subtime*60*fs);% normalization

end








