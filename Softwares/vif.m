function minf=vif(sY,tY)

[a1 b1 c1 d1]=dwt2(sY,'db1');
[a2 b2 c2 d2]=dwt2(tY,'db1');
[m,n]=size(b1);
m=floor(m/8)*8;
n=floor(n/8)*8;
b1=b1(1:m,1:n);
b2=b2(1:m,1:n);
cc=mat2cell(b1,ones(m/8,1)*8,ones(n/8,1)*8);
dd=mat2cell(b2,ones(m/8,1)*8,ones(n/8,1)*8);
for ii=1:m/8
    for jj=1:n/8
      cc{ii,jj}=reshape(cc{ii,jj},64,1);
      dd{ii,jj}=reshape(dd{ii,jj},64,1);
    end
end


CU=zeros(64,64);
for ii=1:m/8
   for jj=1:n/8
     CU=CU+cc{ii,jj}*cc{ii,jj}';
   end
end
CU=CU/(m*n/64);



si=zeros(m/8,n/8);
for ii=1:m/8
    for jj=1:n/8
     si(ii,jj)=cc{ii,jj}'*inv(CU)*cc{ii,jj}/64;
    end
end

gi=zeros(m/8,n/8);
vn=zeros(m/8,n/8);
for ii=3:m/8-2
    for jj=3:n/8-2
      CC=[cc{ii-2,jj-2};cc{ii-2,jj-1};cc{ii-2,jj};cc{ii-2,jj+1};cc{ii-2,jj+2};cc{ii-1,jj-2};cc{ii-1,jj-1};cc{ii-1,jj};cc{ii-1,jj+1};cc{ii-1,jj+2};cc{ii,jj-2};cc{ii,jj-1};cc{ii,jj};cc{ii,jj+1};cc{ii,jj+2};cc{ii+1,jj-2};cc{ii+1,jj-1};cc{ii+1,jj};cc{ii+1,jj+1};cc{ii+1,jj+2};cc{ii+2,jj-2};cc{ii+2,jj-1};cc{ii+2,jj};cc{ii+2,jj+1};cc{ii+2,jj+2}];
      DD=[dd{ii-2,jj-2};dd{ii-2,jj-1};dd{ii-2,jj};dd{ii-2,jj+1};dd{ii-2,jj+2};dd{ii-1,jj-2};dd{ii-1,jj-1};dd{ii-1,jj};dd{ii-1,jj+1};dd{ii-1,jj+2};dd{ii,jj-2};dd{ii,jj-1};dd{ii,jj};dd{ii,jj+1};dd{ii,jj+2};dd{ii+1,jj-2};dd{ii+1,jj-1};dd{ii+1,jj};dd{ii+1,jj+1};dd{ii+1,jj+2};dd{ii+2,jj-2};dd{ii+2,jj-1};dd{ii+2,jj};dd{ii+2,jj+1};dd{ii+2,jj+2}];
      CCX=CC-mean(CC);
      DDX=DD-mean(DD);
      co1=CCX'*DDX/1600;
      co2=CCX'*CCX/1600;
      if co2==0
        co2=co2+0.0001;
      end
      gi(ii,jj)=co1/co2;

      vn(ii,jj)=DDX'*DDX/1600-gi(ii,jj)*CCX'*DDX/1600;
    end
end

[AA BB]=eig(CU);
sinfo=0;
tinfo=0;
nn=50;
for ii=3:m/8-2
    for jj=3:n/8-2
     for kk=1:64
        sinfo=sinfo+log2(1+si(ii,jj)*BB(kk,kk)/nn);
        tinfo=tinfo+log2(1+gi(ii,jj)^2*si(ii,jj)*BB(kk,kk)/(vn(ii,jj)+nn));
     end
    end
end
minf1=tinfo/sinfo;



c1=c1(1:m,1:n);
c2=c2(1:m,1:n);
cc=mat2cell(c1,ones(m/8,1)*8,ones(n/8,1)*8);
dd=mat2cell(c2,ones(m/8,1)*8,ones(n/8,1)*8);
for ii=1:m/8
    for jj=1:n/8
      cc{ii,jj}=reshape(cc{ii,jj},64,1);
      dd{ii,jj}=reshape(dd{ii,jj},64,1);
    end
end


CU=zeros(64,64);
for ii=1:m/8
   for jj=1:n/8
     CU=CU+cc{ii,jj}*cc{ii,jj}';
   end
end
CU=CU/(m*n/64);



si=zeros(m/8,n/8);
for ii=1:m/8
    for jj=1:n/8
     si(ii,jj)=cc{ii,jj}'*inv(CU)*cc{ii,jj}/64;
    end
end

gi=zeros(m/8,n/8);
vn=zeros(m/8,n/8);
for ii=3:m/8-2
    for jj=3:n/8-2
      CC=[cc{ii-2,jj-2};cc{ii-2,jj-1};cc{ii-2,jj};cc{ii-2,jj+1};cc{ii-2,jj+2};cc{ii-1,jj-2};cc{ii-1,jj-1};cc{ii-1,jj};cc{ii-1,jj+1};cc{ii-1,jj+2};cc{ii,jj-2};cc{ii,jj-1};cc{ii,jj};cc{ii,jj+1};cc{ii,jj+2};cc{ii+1,jj-2};cc{ii+1,jj-1};cc{ii+1,jj};cc{ii+1,jj+1};cc{ii+1,jj+2};cc{ii+2,jj-2};cc{ii+2,jj-1};cc{ii+2,jj};cc{ii+2,jj+1};cc{ii+2,jj+2}];
      DD=[dd{ii-2,jj-2};dd{ii-2,jj-1};dd{ii-2,jj};dd{ii-2,jj+1};dd{ii-2,jj+2};dd{ii-1,jj-2};dd{ii-1,jj-1};dd{ii-1,jj};dd{ii-1,jj+1};dd{ii-1,jj+2};dd{ii,jj-2};dd{ii,jj-1};dd{ii,jj};dd{ii,jj+1};dd{ii,jj+2};dd{ii+1,jj-2};dd{ii+1,jj-1};dd{ii+1,jj};dd{ii+1,jj+1};dd{ii+1,jj+2};dd{ii+2,jj-2};dd{ii+2,jj-1};dd{ii+2,jj};dd{ii+2,jj+1};dd{ii+2,jj+2}];
      CCX=CC-mean(CC);
      DDX=DD-mean(DD);
      co1=CCX'*DDX/1600;
      co2=CCX'*CCX/1600;
      if co2==0
        co2=co2+0.0001;
      end
      gi(ii,jj)=co1/co2;

      vn(ii,jj)=DDX'*DDX/1600-gi(ii,jj)*CCX'*DDX/1600;
    end
end

[AA BB]=eig(CU);
sinfo=0;
tinfo=0;
nn=50;
for ii=3:m/8-2
    for jj=3:n/8-2
     for kk=1:64
        sinfo=sinfo+log2(1+si(ii,jj)*BB(kk,kk)/nn);
        tinfo=tinfo+log2(1+gi(ii,jj)^2*si(ii,jj)*BB(kk,kk)/(vn(ii,jj)+nn));
     end
    end
end
minf2=tinfo/sinfo;
minf=minf1+minf2;
end











