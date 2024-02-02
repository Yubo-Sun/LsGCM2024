data=load(datafile);%sub-spatio-temporal graph
Sample01=data(481:720,4:27);
Sample01_standardization=reshape(mapstd(reshape(Sample01,1,size(Sample01,1)*size(Sample01,2))),size(Sample01,1),size(Sample01,2))';
B=StIEM01(24,1150,660,220,40);

G=0.03;
g_1=G*ones(size(B,1),size(B,2));
g_2=2*ones(size(B,1),size(B,2));
B_f=(2*ones(size(B,1),size(B,2))./(pi*ones(size(B,1),size(B,2))+2*atan(g_2))).*(atan(g_1.*tan(pi/2*B)-g_2)+atan(g_2));

%Spatio-temporal information expansion method of sub-spatio-temporal graph
Anodes_number=24;
X=ones(size(Sample01_standardization,1),size(Sample01_standardization,2),size(Sample01_standardization,1));
for i=1:Anodes_number
    S_copy_row=kron(Sample01_standardization(i,:),ones(size(Sample01_standardization,1),1));
    assi_f_copy_col=kron(B_f(:,i),ones(1,size(Sample01_standardization,2)));
    X(:,:,i)=Sample01_standardization + assi_f_copy_col.*(S_copy_row-Sample01_standardization);
end




