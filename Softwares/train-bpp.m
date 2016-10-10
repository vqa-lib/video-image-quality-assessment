
clear;
load live_vif;
load live_time1;
load live_ssimt1;




load live_dmos;
sc=[live_vif live_time1 live_ssimt1 ]';
live_dmos=live_dmos';

 

in=sc(:,1:2:150);
out=live_dmos(1:2:150);

[inn,minp,maxp,outn,mint,maxt]=premnmx(in,out);

net=newff(minmax(inn),[8,30,1],{'tansig','tansig','purelin'},'traingdx');
 net.trainParam.show = 100;
 net.trainParam.epochs = 650000;       %最大训练轮回
 net.trainParam.Lr = 0.08;            %学习速率
 net.trainParam.goal = 1.0*10^(-2);  %均方误差s
 net=train(net,inn,outn);
 


%figure;
 %an=sim(net,inn);
 %a=postmnmx(an,mint,maxt);


si  = sc;
so  = live_dmos;
sin  = tramnmx(si,minp,maxp);
 cn   = sim(net,sin);
 c    = postmnmx(cn,mint,maxt);
 figure;



plot(live_dmos,c,'k+');