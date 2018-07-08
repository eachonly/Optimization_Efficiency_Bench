%******************************************************************
%
% Purpose: Compute empirical Mx-batch reliability from master dataset
%
% Programmer: Youwei Qin, Dmitri Kavetski,George Kuczera
% Created: 7 July 2018 at Suzhou, China
% Last modified 7 July 2018
%
% Reference
% * Kavetski2018: Dmitri Kavetski, Youwei Qin, George Kuczera (2018),
%                 The fast and the robust: Trade-offs between optimization robustness and cost in the calibration of environmental models,
%                 Water Resources Research, in review
%
%******************************************************************

% ---
% Input
% * Data files for emprical distibution function with three panels, with
% each file includes the following columns:
%   Column 1: x-axis the index of multistart fraction
%   Column 2-3: Function value(Column 2) and function evaluation(Column 3) of RGN invocations
%   Column 4-5: Function value(Column 4) and function evaluation(Column 5) of QN invocations
%   Column 6-7: Function value(Column 6) and function evaluation(Column 7) of PEST invocations
%   Column 8-9: Function value(Column 8) and function evaluation(Column 9) of SCE-nc10 invocations
%   Column 10-11: Function value(Column 10) and function evaluation(Column 11) of DDS invocations

% ---
% Output
% * Matlab figure for empirical distribution function, with the global
% reliability and tolerable reliability lines added.

% ---
% Notes
% * The numbers of columns (corresponding to the optimization
% algorithms)can be adjusted based on the research problem.
% * The position of legengs and labels can be manually adjusted.

% Start the plotting and define variables
figure(1);
fontsize10=18;
fontsize15=15;
linewidthcost=1.5;
linewidth1=2.5;
linewidth1p5=2.5;
xmove=[0.21 0 0 0];
ymove=[0 -0.31 0 0];
NSAVE=42134.69309;
NSDRY=3579.475225;
NSWET=1031881.567;
purp=[0.51 0.0 0.51];
grey=[0.5 0.5 0.5];
xtolTini=0.10;
xtolGini=0.01;
tickLength=[0.025,0.025];

% Plot the first panel
H(1)=subplot(1,3,1);
PN1= get(H(1),'pos');
set(H(1),'pos',PN1);
% load the data file
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('SIXPAR_Coopers_Bench.txt');
gnNS=1-2*gn/NSWET;
qnNS=1-2*qn/NSWET;
pestNS=1-2*pest/NSWET;
sceNS=1-2*sce/NSWET;
ddsNS=1-2*dds/NSWET;
% use the best NS of RGN, DDS, LM, SCE-nc10
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*xtolTini;
xtolG=xbest-xbest*xtolGini;
xtolLineT=xtolT*ones(size(xaxis));
xtolLineG=xtolG*ones(size(xaxis));
%plot other plots
[AX,H1,H2]=plotyy(xaxis,[pestNS,sceNS,xtolLineT,xtolLineG],xaxis,[pestnum,scenum],'plot','semilogy');
axis on;
% set the x-axis,yaxis,xlim,and ylim
y2Ticket=[1e1 1e2 1e3 1e4 1e5 1e6];
y1Ticket=[0.4:0.1:0.8];
x1Ticket=[0:0.2:1.0];
x2Ticket=[0:0.2:1.0];
Y2Lim=[1e1,1e6];
Y1Lim=[0.4,0.8];
xLim=[0,1.0];
% adjust the axis settings
hold(AX(2), 'on');
uistack(AX(1));
set(AX(1), 'Color', 'none');
set(AX(2), 'Color', 'w');
%set(AX(1),'ydir','reverse')
% adjust the xlim and ylim
set(AX(1),'Xlim',xLim,'YLim',Y1Lim,'fontweight','bold','FontSize',fontsize10);
set(AX(2),'Xlim',xLim,'YLim',Y2Lim,'fontweight','bold','FontSize',fontsize10);
set(AX(1),'YTick',y1Ticket);
set(gca,'ticklength',tickLength);%change the length of ticket
%set(AX(1),'YTickLabel',sprintf('%.1f|',y1))
set(AX(2),'YTick',y2Ticket);
set(AX(2),'ticklength',tickLength);%change the length of ticket
%set(AX(2),'YTickLabel',sprintf('%.1f|',y2))
set(AX(1),'XTick',x1Ticket);
set(gca,'ticklength',tickLength);%change the length of ticket
%set(AX(1),'XTickLabel',sprintf('%.2f|',x1))
set(AX(2),'XTick',x2Ticket);
set(gca,'ticklength',tickLength);%change the length of ticket
%set(AX(2),'XTickLabel',sprintf('%.2f|',x2))
set(AX(1),'BOX','Off');
set(AX(2),'BOX','Off');%remove the box
set(AX(2), 'XAxisLocation','top','linewidth',linewidth1)%cover the top box manually
set(AX(2),'XTick',[]) %remove the ticks
set(gca,'ticklength',tickLength);%change the length of ticket
% set the line color and axis color
set(AX(1),'XColor','k','YColor','k','linewidth',linewidth1,'fontsize',fontsize10,'fontname','Times');
set(AX(2),'XColor','k','linewidth',linewidth1,'fontsize',fontsize10,'fontname','Times');
% set the details for each line
set(H1(1),'LineStyle','-','color',purp,'LineWidth',linewidth1p5);
set(H1(2),'LineStyle','-','color','k','LineWidth',linewidth1p5);
set(H1(3),'LineStyle','-','color',grey,'LineWidth',1.4);
set(H1(4),'LineStyle','-','color',grey,'LineWidth',1.4);
set(H2(1),'LineStyle','--','color',purp,'LineWidth',linewidthcost);
set(H2(2),'LineStyle','--','color','k','LineWidth',linewidthcost);
uistack(H1(1), 'top');
uistack(H1(2), 'top');
uistack(H1(3), 'top');
uistack(H1(4), 'top');
title('(A) SIXPAR Coopers','fontsize',fontsize10);
h2=legend([H1(1),H1(2)],'LM','SCE-nc10',fontsize10);
set(get(AX(1),'Ylabel'),'string','Nash-Sutcliffe efficiency','fontweight','bold','FontSize',fontsize10);
text(0.68,0.65,'{\itR_T}','fontsize',fontsize10,'color',grey);
text(0.68,0.72,'{\itR_G}','fontsize',fontsize10,'color',grey);

% Plot the second panel
H(2)=subplot(1,3,2);
PN2= get(H(2),'pos');
% PN2=PN1+ymove;
set(H(2),'pos',PN2);
% load the data file
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('SIMHYD_Bass_Bench.txt');
gnNS=1-2*gn/NSAVE;
qnNS=1-2*qn/NSAVE;
pestNS=1-2*pest/NSAVE;
sceNS=1-2*sce/NSAVE;
ddsNS=1-2*dds/NSAVE;
% use the best NS of RGN, DDS, LM, SCE-nc10
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*xtolTini;
xtolG=xbest-xbest*xtolGini;
xtolLineT=xtolT*ones(size(xaxis));
xtolLineG=xtolG*ones(size(xaxis));
%plot other plots
[AX,H1,H2]=plotyy(xaxis,[pestNS,sceNS,xtolLineT,xtolLineG],xaxis,[pestnum,scenum],'plot','semilogy');
axis on;
% set the x-axis,yaxis,xlim,and ylim
y2Ticket=[1e1 1e2 1e3 1e4 1e5 1e6];
y1Ticket=[0.4:0.1:0.8];
x1Ticket=[0:0.2:1.0];
x2Ticket=[0:0.2:1.0];
Y2Lim=[1e1,1e6];
Y1Lim=[0.4,0.8];
xLim=[0,1.0];
% adjust the axis settings
hold(AX(2), 'on');
uistack(AX(1));
set(AX(1), 'Color', 'none');
set(AX(2), 'Color', 'w');
%set(AX(1),'ydir','reverse')
% adjust the xlim and ylim
set(AX(1),'Xlim',xLim,'YLim',Y1Lim,'fontweight','bold','FontSize',fontsize10);
set(AX(2),'Xlim',xLim,'YLim',Y2Lim,'fontweight','bold','FontSize',fontsize10);
set(AX(1),'YTick',y1Ticket);
set(gca,'ticklength',tickLength);%change the length of ticket
set(AX(2),'YTick',y2Ticket);
set(AX(2),'ticklength',tickLength);%change the length of ticket
set(AX(1),'XTick',x1Ticket);
set(gca,'ticklength',tickLength);%change the length of ticket
set(AX(2),'XTick',x2Ticket);
set(gca,'ticklength',tickLength);%change the length of ticket
set(AX(1),'BOX','Off');
set(AX(2),'BOX','Off');%remove the box
set(AX(2), 'XAxisLocation','top','linewidth',linewidth1)%cover the top box manually
set(AX(2),'XTick',[]) %remove the ticks
% set the line color and axis color
set(AX(1),'XColor','k','YColor','k','linewidth',linewidth1,'fontsize',fontsize10,'fontname','Times');
set(AX(2),'XColor','k','linewidth',linewidth1,'fontsize',fontsize10,'fontname','Times');
% set the details for each line
set(H1(1),'LineStyle','-','color',purp,'LineWidth',linewidth1p5);
set(H1(2),'LineStyle','-','color','k','LineWidth',linewidth1p5);
set(H1(3),'LineStyle','-','color',grey,'LineWidth',1.4);
set(H1(4),'LineStyle','-','color',grey,'LineWidth',1.4);
set(H2(1),'LineStyle','--','color',purp,'LineWidth',linewidthcost);
set(H2(2),'LineStyle','--','color','k','LineWidth',linewidthcost);
uistack(H1(1), 'top');
uistack(H1(2), 'top');
uistack(H1(3), 'top');
uistack(H1(4), 'top');
title('(B) SIMHYD Bass','fontsize',fontsize10);
set(get(AX(1),'Xlabel'),'string','Fraction of multi-starts','fontweight','bold','FontSize',fontsize10);
text(0.62,0.635,'{\itR_T}','fontsize',fontsize10,'color',grey);
text(0.62,0.698,'{\itR_G}','fontsize',fontsize10,'color',grey);

% Plot the third panel
H(3)=subplot(1,3,3);
PN3= get(H(3),'pos');
% PN2=PN1+ymove;
set(H(3),'pos',PN3);
% load the data file
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('FUSE_Tambo_Bench.txt');
gnNS=1-2*gn/NSDRY;
qnNS=1-2*qn/NSDRY;
pestNS=1-2*pest/NSDRY;
sceNS=1-2*sce/NSDRY;
ddsNS=1-2*dds/NSDRY;
% use the best NS of RGN, DDS, LM, SCE-nc10
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*xtolTini;
xtolG=xbest-xbest*xtolGini;
xtolLineT=xtolT*ones(size(xaxis));
xtolLineG=xtolG*ones(size(xaxis));
%plot other plots
[AX,H1,H2]=plotyy(xaxis,[pestNS,sceNS,xtolLineT,xtolLineG],xaxis,[pestnum,scenum],'plot','semilogy');
axis on;
% set the x-axis,yaxis,xlim,and ylim
y2Ticket=[1e1 1e2 1e3 1e4 1e5 1e6];
y1Ticket=[0.4:0.1:0.8];
x1Ticket=[0:0.2:1.0];
x2Ticket=[0:0.2:1.0];
Y2Lim=[1e1,1e6];
Y1Lim=[0.4,0.8];
xLim=[0,1.0];
% adjust the axis settings
hold(AX(2), 'on');
uistack(AX(1));
set(AX(1), 'Color', 'none');
set(AX(2), 'Color', 'w');
%set(AX(1),'ydir','reverse')
% adjust the xlim and ylim
set(AX(1),'Xlim',xLim,'YLim',Y1Lim,'fontweight','bold','FontSize',fontsize10);
set(AX(2),'Xlim',xLim,'YLim',Y2Lim,'fontweight','bold','FontSize',fontsize10);
set(AX(1),'YTick',y1Ticket);
set(gca,'ticklength',tickLength);%change the length of ticket
set(AX(2),'YTick',y2Ticket);
set(AX(2),'ticklength',tickLength);%change the length of ticket
set(AX(1),'XTick',x1Ticket);
set(gca,'ticklength',tickLength);%change the length of ticket
set(AX(2),'XTick',x2Ticket);
set(gca,'ticklength',tickLength);%change the length of ticket
set(AX(1),'BOX','Off');
set(AX(2),'BOX','Off');%remove the box
set(AX(2), 'XAxisLocation','top','linewidth',linewidth1)%cover the top box manually
set(AX(2),'XTick',[]) %remove the ticks
% set the line color and axis color
set(AX(1),'XColor','k','YColor','k','linewidth',linewidth1,'fontsize',fontsize10,'fontname','Times');
set(AX(2),'XColor','k','linewidth',linewidth1,'fontsize',fontsize10,'fontname','Times');
% set the details for each line
set(H1(1),'LineStyle','-','color',purp,'LineWidth',linewidth1p5);
set(H1(2),'LineStyle','-','color','k','LineWidth',linewidth1p5);
set(H1(3),'LineStyle','-','color',grey,'LineWidth',1.4);
set(H1(4),'LineStyle','-','color',grey,'LineWidth',1.4);
set(H2(1),'LineStyle','--','color',purp,'LineWidth',linewidthcost);
set(H2(2),'LineStyle','--','color','k','LineWidth',linewidthcost);
uistack(H1(1), 'top');
uistack(H1(2), 'top');
uistack(H1(3), 'top');
uistack(H1(4), 'top');
title('(C) FUSE Tambo','fontsize',fontsize10);
set(get(AX(2),'Ylabel'),'string','Number of objective function calls','fontweight','bold','FontSize',fontsize10);
text(0.68,0.60,'{\itR_T}','fontsize',fontsize10,'color',grey);
text(0.68,0.665,'{\itR_G}','fontsize',fontsize10,'color',grey);