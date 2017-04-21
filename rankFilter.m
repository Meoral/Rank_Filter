clc,clear,close all;
originalPic=imread('cameraman.tif');
m=3;
n=(m-1)/2;
[M,N]=size(originalPic);
noisePic = imnoise(originalPic,'salt & pepper');      %加椒盐噪声
tempPic=zeros(M+n*2,N+n*2);                           %%补零
tempPic(n+1:M+n,n+1:N+n)=noisePic;                    %%填充
resultMinPic=zeros(M,N);                              %%最小值临时变量
resultMidPic=zeros(M,N);                              %%中值临时变量
resultMaxPic=zeros(M,N);                              %%最大值临时变量
sortResult=zeros(1,m*m);                              %排序数组临时变量
for i=(n+1):(M+n)
    for j=(n+1):(N+n)
        tempMatrix=tempPic((i-n):(i+n),(j-n):(j+n));   %取出m*m的方阵
        sortResult=sort(tempMatrix(:));                %对方阵中的元素进行排序
        resultMinPic((i-n),(j-n))=sortResult(1);       %取出最小值
        resultMaxPic((i-n),(j-n))=sortResult(m*m);      %取出最大值
        resultMidPic((i-n),(j-n))=sortResult((m*m+1)/2);  %取出中值
    end
end
resultMinPic=uint8(resultMinPic);       %double转换为uint8
resultMaxPic=uint8(resultMaxPic);
resultMidPic=uint8(resultMidPic);
subplot(2,2,1),imshow(noisePic),title('\fontsize{16}椒盐噪声图片');
subplot(2,2,2),imshow(resultMinPic),title('\fontsize{16}最小值滤波图片');
subplot(2,2,3),imshow(resultMidPic),title('\fontsize{16}中值滤波图片');
subplot(2,2,4),imshow(resultMaxPic),title('\fontsize{16}最大值滤波图片');
set(gcf,'unit','normalized','position',[0,0,1.0,1.0]);
saveas(gcf,strcat(mfilename,'_pic'),'jpg');