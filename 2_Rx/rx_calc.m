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
% * Raw data files for 12 scenarios, with each includes the following columns:
%   Column 1: x-axis the index of multistart fraction
%   Column 2-3: Function value(Column 2) and function evaluation(Column 3) of RGN invocations
%   Column 4-5: Function value(Column 4) and function evaluation(Column 5) of QN invocations
%   Column 6-7: Function value(Column 6) and function evaluation(Column 7) of PEST invocations
%   Column 8-9: Function value(Column 8) and function evaluation(Column 9) of SCE-nc10 invocations
%   Column 10-11: Function value(Column 10) and function evaluation(Column 11) of DDS invocations

% ---
% Output
% * RG, RT, and the best objective function values for each of 12 scenarios

% ---
% Notes
% * The numbers of columns (corresponding to the optimization
% algorithms)can be adjusted based on the research problem.

% Define variables
NSAVE=42134.69309;
NSDRY=3579.475225;
NSWET=1031881.567;
tolT=0.10;          %calculate the Rg
tolG=0.01;          %calculate the Rt

% load the data file for HYMOD_Tambo River
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_araw/HYMOD_Tambo.txt');
gnNS=1-2*gn/NSDRY;
qnNS=1-2*qn/NSDRY;
pestNS=1-2*pest/NSDRY;
sceNS=1-2*sce/NSDRY;
ddsNS=1-2*dds/NSDRY;
% use the best NS of RGN, DDS, LM, SCE-nc10
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
a1T=sum(gnNS>xtolT)/10000;
a2T=sum(pestNS>xtolT)/10000;
a3T=sum(sceNS>xtolT)/10000;
a4T=sum(ddsNS>xtolT)/10000;
a1G=sum(gnNS>xtolG)/10000;
a2G=sum(pestNS>xtolG)/10000;
a3G=sum(sceNS>xtolG)/10000;
a4G=sum(ddsNS>xtolG)/10000;
xbest
aG=[a1G,a2G,a3G,a4G]
aT=[a1T,a2T,a3T,a4T]

% load the data file SXIPAR Tambo River
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_araw/SIXPAR_Tambo.txt');
gnNS=1-2*gn/NSDRY;
qnNS=1-2*qn/NSDRY;
pestNS=1-2*pest/NSDRY;
sceNS=1-2*sce/NSDRY;
ddsNS=1-2*dds/NSDRY;
% use the best NS of RGN, DDS, LM, SCE-nc10
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
a1T=sum(gnNS>xtolT)/10000;
a2T=sum(pestNS>xtolT)/10000;
a3T=sum(sceNS>xtolT)/10000;
a4T=sum(ddsNS>xtolT)/10000;
a1G=sum(gnNS>xtolG)/10000;
a2G=sum(pestNS>xtolG)/10000;
a3G=sum(sceNS>xtolG)/10000;
a4G=sum(ddsNS>xtolG)/10000;
xbest
aG=[a1G,a2G,a3G,a4G]
aT=[a1T,a2T,a3T,a4T]

% load the data file HYMOD Bass River
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_araw/HYMOD_Bass.txt');
gnNS=1-2*gn/NSAVE;
qnNS=1-2*qn/NSAVE;
pestNS=1-2*pest/NSAVE;
sceNS=1-2*sce/NSAVE;
ddsNS=1-2*dds/NSAVE;
% use the best NS of RGN, DDS, LM, SCE-nc10
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
a1T=sum(gnNS>xtolT)/10000;
a2T=sum(pestNS>xtolT)/10000;
a3T=sum(sceNS>xtolT)/10000;
a4T=sum(ddsNS>xtolT)/10000;
a1G=sum(gnNS>xtolG)/10000;
a2G=sum(pestNS>xtolG)/10000;
a3G=sum(sceNS>xtolG)/10000;
a4G=sum(ddsNS>xtolG)/10000;
xbest
aG=[a1G,a2G,a3G,a4G]
aT=[a1T,a2T,a3T,a4T]

% load the data file SIXPAR Bass River
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_araw/SIXPAR_Bass.txt');
gnNS=1-2*gn/NSAVE;
qnNS=1-2*qn/NSAVE;
pestNS=1-2*pest/NSAVE;
sceNS=1-2*sce/NSAVE;
ddsNS=1-2*dds/NSAVE;
% use the best NS of RGN, DDS, LM, SCE-nc10
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
a1T=sum(gnNS>xtolT)/10000;
a2T=sum(pestNS>xtolT)/10000;
a3T=sum(sceNS>xtolT)/10000;
a4T=sum(ddsNS>xtolT)/10000;
a1G=sum(gnNS>xtolG)/10000;
a2G=sum(pestNS>xtolG)/10000;
a3G=sum(sceNS>xtolG)/10000;
a4G=sum(ddsNS>xtolG)/10000;
xbest
aG=[a1G,a2G,a3G,a4G]
aT=[a1T,a2T,a3T,a4T]

% load the data file HYMOD Coopers Creek
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_araw/HYMOD_Coopers.txt');
gnNS=1-2*gn/NSWET;
qnNS=1-2*qn/NSWET;
pestNS=1-2*pest/NSWET;
sceNS=1-2*sce/NSWET;
ddsNS=1-2*dds/NSWET;
% use the best NS of RGN, DDS, LM, SCE-nc10
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
a1T=sum(gnNS>xtolT)/10000;
a2T=sum(pestNS>xtolT)/10000;
a3T=sum(sceNS>xtolT)/10000;
a4T=sum(ddsNS>xtolT)/10000;
a1G=sum(gnNS>xtolG)/10000;
a2G=sum(pestNS>xtolG)/10000;
a3G=sum(sceNS>xtolG)/10000;
a4G=sum(ddsNS>xtolG)/10000;
xbest
aG=[a1G,a2G,a3G,a4G]
aT=[a1T,a2T,a3T,a4T]

% load the data file SIXPAR Coopers Creek
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_araw/SIXPAR_Coopers.txt');
gnNS=1-2*gn/NSWET;
qnNS=1-2*qn/NSWET;
pestNS=1-2*pest/NSWET;
sceNS=1-2*sce/NSWET;
ddsNS=1-2*dds/NSWET;
% use the best NS of RGN, DDS, LM, SCE-nc10
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
a1T=sum(gnNS>xtolT)/10000;
a2T=sum(pestNS>xtolT)/10000;
a3T=sum(sceNS>xtolT)/10000;
a4T=sum(ddsNS>xtolT)/10000;
a1G=sum(gnNS>xtolG)/10000;
a2G=sum(pestNS>xtolG)/10000;
a3G=sum(sceNS>xtolG)/10000;
a4G=sum(ddsNS>xtolG)/10000;
xbest
aG=[a1G,a2G,a3G,a4G]
aT=[a1T,a2T,a3T,a4T]

% load the data file SIMHYD Tambo River
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_araw/SIMHYD_Tambo.txt');
gnNS=1-2*gn/NSDRY;
qnNS=1-2*qn/NSDRY;
pestNS=1-2*pest/NSDRY;
sceNS=1-2*sce/NSDRY;
ddsNS=1-2*dds/NSDRY;
% use the best NS of RGN, DDS, LM, SCE-nc10
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
a1T=sum(gnNS>xtolT)/10000;
a2T=sum(pestNS>xtolT)/10000;
a3T=sum(sceNS>xtolT)/10000;
a4T=sum(ddsNS>xtolT)/10000;
a1G=sum(gnNS>xtolG)/10000;
a2G=sum(pestNS>xtolG)/10000;
a3G=sum(sceNS>xtolG)/10000;
a4G=sum(ddsNS>xtolG)/10000;
xbest
aG=[a1G,a2G,a3G,a4G]
aT=[a1T,a2T,a3T,a4T]

% load the data file FUSE Tambo River
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_araw/FUSE_Tambo.txt');
gnNS=1-2*gn/NSDRY;
qnNS=1-2*qn/NSDRY;
pestNS=1-2*pest/NSDRY;
sceNS=1-2*sce/NSDRY;
ddsNS=1-2*dds/NSDRY;
% use the best NS of RGN, DDS, LM, SCE-nc10
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
a1T=sum(gnNS>xtolT)/1000;
a2T=sum(pestNS>xtolT)/1000;
a3T=sum(sceNS>xtolT)/1000;
a4T=sum(ddsNS>xtolT)/1000;
a1G=sum(gnNS>xtolG)/1000;
a2G=sum(pestNS>xtolG)/1000;
a3G=sum(sceNS>xtolG)/1000;
a4G=sum(ddsNS>xtolG)/1000;
xbest
aG=[a1G,a2G,a3G,a4G]
aT=[a1T,a2T,a3T,a4T]

% load the data file SIMHYD Bass River
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_araw/SIMHYD_Bass.txt');
gnNS=1-2*gn/NSAVE;
qnNS=1-2*qn/NSAVE;
pestNS=1-2*pest/NSAVE;
sceNS=1-2*sce/NSAVE;
ddsNS=1-2*dds/NSAVE;
% use the best NS of RGN, DDS, LM, SCE-nc10
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
a1T=sum(gnNS>xtolT)/10000;
a2T=sum(pestNS>xtolT)/10000;
a3T=sum(sceNS>xtolT)/10000;
a4T=sum(ddsNS>xtolT)/10000;
a1G=sum(gnNS>xtolG)/10000;
a2G=sum(pestNS>xtolG)/10000;
a3G=sum(sceNS>xtolG)/10000;
a4G=sum(ddsNS>xtolG)/10000;
xbest
aG=[a1G,a2G,a3G,a4G]
aT=[a1T,a2T,a3T,a4T]

% load the data file FUSE Bass River
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_araw/FUSE_Bass.txt');
gnNS=1-2*gn/NSAVE;
qnNS=1-2*qn/NSAVE;
pestNS=1-2*pest/NSAVE;
sceNS=1-2*sce/NSAVE;
ddsNS=1-2*dds/NSAVE;
% use the best NS of RGN, DDS, LM, SCE-nc10
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
a1T=sum(gnNS>xtolT)/1000;
a2T=sum(pestNS>xtolT)/1000;
a3T=sum(sceNS>xtolT)/1000;
a4T=sum(ddsNS>xtolT)/1000;
a1G=sum(gnNS>xtolG)/1000;
a2G=sum(pestNS>xtolG)/1000;
a3G=sum(sceNS>xtolG)/1000;
a4G=sum(ddsNS>xtolG)/1000;
xbest
aG=[a1G,a2G,a3G,a4G]
aT=[a1T,a2T,a3T,a4T]

% load the data file SIMHYD Coopers Creek
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_araw/SIMHYD_Coopers.txt');
gnNS=1-2*gn/NSWET;
qnNS=1-2*qn/NSWET;
pestNS=1-2*pest/NSWET;
sceNS=1-2*sce/NSWET;
ddsNS=1-2*dds/NSWET;
% use the best NS of RGN, DDS, LM, SCE-nc10
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
a1T=sum(gnNS>xtolT)/10000;
a2T=sum(pestNS>xtolT)/10000;
a3T=sum(sceNS>xtolT)/10000;
a4T=sum(ddsNS>xtolT)/10000;
a1G=sum(gnNS>xtolG)/10000;
a2G=sum(pestNS>xtolG)/10000;
a3G=sum(sceNS>xtolG)/10000;
a4G=sum(ddsNS>xtolG)/10000;
xbest
aG=[a1G,a2G,a3G,a4G]
aT=[a1T,a2T,a3T,a4T]

% load the data file FUSE Coopers Creek
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_araw/FUSE_Coopers.txt');
gnNS=1-2*gn/NSWET;
qnNS=1-2*qn/NSWET;
pestNS=1-2*pest/NSWET;
sceNS=1-2*sce/NSWET;
ddsNS=1-2*dds/NSWET;
% use the best NS of RGN, DDS, LM, SCE-nc10
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
a1T=sum(gnNS>xtolT)/1000;
a2T=sum(pestNS>xtolT)/1000;
a3T=sum(sceNS>xtolT)/1000;
a4T=sum(ddsNS>xtolT)/1000;
a1G=sum(gnNS>xtolG)/1000;
a2G=sum(pestNS>xtolG)/1000;
a3G=sum(sceNS>xtolG)/1000;
a4G=sum(ddsNS>xtolG)/1000;
xbest
aG=[a1G,a2G,a3G,a4G]
aT=[a1T,a2T,a3T,a4T]