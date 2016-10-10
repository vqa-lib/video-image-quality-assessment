function [ff score]=PCA(Y,Y2)
[rr cc]=size(Y);
ff=zeros(1,50);
rr=floor(rr/16)*16;
cc=floor(cc/16)*16; 
Y=Y(1:rr,1:cc);
Y2=Y2(1:rr,1:cc);
Ym2=mat2cell(Y2,ones(rr/16,1)*16,ones(cc/16,1)*16);
Ym=mat2cell(Y,ones(rr/16,1)*16,ones(cc/16,1)*16);
YYY=zeros(256,rr*cc/256);
YYY2=zeros(256,rr*cc/256);
for i=1:rr*cc/256 
    YYY(:,i)=reshape(Ym{i},16*16,1); 
    YYY2(:,i)=reshape(Ym2{i},16*16,1);
end
Ys=YYY';
Yb=YYY2';
[ss,coef,c]=princomp(Ys);
Cs=Ys*ss;
Cb=Yb*ss;
tst=cell(16,16);
for i=1:256
    tst{i}=reshape(ss(:,i),16,16);
    tmmp=tst{i};
    maxx=max(tmmp(:));
    minn=min(tmmp(:));
    tst{i}=(tst{i}-minn)/(maxx-minn);
end  
for i=1:10
    tY=double(Y); 
    tY2=double(Y2);
    tY=conv2(tY,tst{i},'same');
    tY2=conv2(tY2,tst{i},'same');
    tmp=abs(tY-tY2);
    ff(i)=mean(tmp(:));
end 
a11=Cs(:,1:50)';
a22=Cb(:,1:50)';
a1=mapminmax(a11);
a2=mapminmax(a22);
a1=(a1+1)/2;
a2=(a2+1)/2;
del=abs(a1-a2);

del=del'; 
ff=mean(del); 
score=ff*c(1:50);
score=score./sum(c(1:50));