clc,clear,close all;
originalPic=imread('cameraman.tif');
m=3;
n=(m-1)/2;
[M,N]=size(originalPic);
noisePic = imnoise(originalPic,'salt & pepper');      %�ӽ�������
tempPic=zeros(M+n*2,N+n*2);                           %%����
tempPic(n+1:M+n,n+1:N+n)=noisePic;                    %%���
resultMinPic=zeros(M,N);                              %%��Сֵ��ʱ����
resultMidPic=zeros(M,N);                              %%��ֵ��ʱ����
resultMaxPic=zeros(M,N);                              %%���ֵ��ʱ����
sortResult=zeros(1,m*m);                              %����������ʱ����
for i=(n+1):(M+n)
    for j=(n+1):(N+n)
        tempMatrix=tempPic((i-n):(i+n),(j-n):(j+n));   %ȡ��m*m�ķ���
        sortResult=sort(tempMatrix(:));                %�Է����е�Ԫ�ؽ�������
        resultMinPic((i-n),(j-n))=sortResult(1);       %ȡ����Сֵ
        resultMaxPic((i-n),(j-n))=sortResult(m*m);      %ȡ�����ֵ
        resultMidPic((i-n),(j-n))=sortResult((m*m+1)/2);  %ȡ����ֵ
    end
end
resultMinPic=uint8(resultMinPic);       %doubleת��Ϊuint8
resultMaxPic=uint8(resultMaxPic);
resultMidPic=uint8(resultMidPic);
subplot(2,2,1),imshow(noisePic),title('\fontsize{16}��������ͼƬ');
subplot(2,2,2),imshow(resultMinPic),title('\fontsize{16}��Сֵ�˲�ͼƬ');
subplot(2,2,3),imshow(resultMidPic),title('\fontsize{16}��ֵ�˲�ͼƬ');
subplot(2,2,4),imshow(resultMaxPic),title('\fontsize{16}���ֵ�˲�ͼƬ');
set(gcf,'unit','normalized','position',[0,0,1.0,1.0]);
saveas(gcf,strcat(mfilename,'_pic'),'jpg');