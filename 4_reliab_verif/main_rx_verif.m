%******************************************************************
%
% Purpose: Compute empirical Mx-batch reliability from master dataset
%
% Programmer: Youwei Qin, Dmitri Kavetski,George Kuczera
% Created: 7 July 2018 at Suzhou, China
% Last modified 23 October 2018
%
% Reference
% * Kavetski2018: Dmitri Kavetski, Youwei Qin, George Kuczera (2018),
%                 The fast and the robust: Trade-offs between optimization robustness and cost in the calibration of environmental models,
%                 Water Resources Research, 54. https://doi.org/10.1029/2017WR022051
%
%******************************************************************

% ---
% Input
% * Raw data files for 12 scenarios panels, with each includes the following columns:
%   Column 1: x-axis the index of multistart fraction
%   Column 2-3: Function value and function evaluation of RGN invocations
%   Column 4-5: Function value and function evaluation of QN invocations
%   Column 6-7: Function value and function evaluation of PEST invocations
%   Column 8-9: Function value and function evaluation of SCE-nc10 invocations
%   Column 10-11: Function value and function evaluation of DDS invocations

% * Mx for 12 scenarios panels, with each includes the following columns:
%   Column 1: M_G pre-evaluated for LM
%   Column 2: M_T pre-evaluated for LM
%   Column 3: M_G pre-evaluated for SCE
%   Column 2: M_T pre-evaluated for SCE


% ---
% Output
% * verified reliability rx, and the standard deviation

% ---
% Notes
% 1. The raw data file is in folder "0_raw"
% 2. The numbers of Mx need to be pre-evaluated with mx_cx_eff.xlsx with a
% given target confidence varied from 5% to 99%. In this test, the target
% confidences are 5%, 25%, 50%, 75%, 90%,95%, 99%, and can be verified
% seperately by changing to the corresponding file name(which stores the Mx
% with a given confidence level) in line 63.

% Define variables
fontsize10=10;
fontsize12=10;
fontsize15=14;
linewidth1=1.0;
linewidth1p5=1.5;
NSAVE=42134.69309;
NSDRY=3579.475225;
NSWET=1031881.567;
tolT=0.10;
tolG=0.01;
Ntest=10000;

% open file for output
formatSpec = '%6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f %6.6f\n';
% load the Mx
Mx_vec=textread('alpha99.txt');     % Use 5% to 99% to verify all the tests

% re-order the Mx
%Hymod Dry
Mx_Hymod_Dry_LM_Rg=Mx_vec(1,1);Mx_Hymod_Dry_LM_Rt=Mx_vec(1,2);
Mx_Hymod_Dry_SCE_Rg=Mx_vec(1,3);Mx_Hymod_Dry_SCE_Rt=Mx_vec(1,4);
%Hymod Ave
Mx_Hymod_Ave_LM_Rg=Mx_vec(2,1);Mx_Hymod_Ave_LM_Rt=Mx_vec(2,2);
Mx_Hymod_Ave_SCE_Rg=Mx_vec(2,3);Mx_Hymod_Ave_SCE_Rt=Mx_vec(2,4);
%Hymod Wet
Mx_Hymod_Wet_LM_Rg=Mx_vec(3,1);Mx_Hymod_Wet_LM_Rt=Mx_vec(3,2);
Mx_Hymod_Wet_SCE_Rg=Mx_vec(3,3);Mx_Hymod_Wet_SCE_Rt=Mx_vec(3,4);
%SIXPAR Dry
Mx_Sixpar_Dry_LM_Rg=Mx_vec(4,1);Mx_Sixpar_Dry_LM_Rt=Mx_vec(4,2);
Mx_Sixpar_Dry_SCE_Rg=Mx_vec(4,3);Mx_Sixpar_Dry_SCE_Rt=Mx_vec(4,4);
%SIXPAR Ave
Mx_Sixpar_Ave_LM_Rg=Mx_vec(5,1);Mx_Sixpar_Ave_LM_Rt=Mx_vec(5,2);
Mx_Sixpar_Ave_SCE_Rg=Mx_vec(5,3);Mx_Sixpar_Ave_SCE_Rt=Mx_vec(5,4);
%SIXPAR Wet
Mx_Sixpar_Wet_LM_Rg=Mx_vec(6,1);Mx_Sixpar_Wet_LM_Rt=Mx_vec(6,2);
Mx_Sixpar_Wet_SCE_Rg=Mx_vec(6,3);Mx_Sixpar_Wet_SCE_Rt=Mx_vec(6,4);
%SIMHYD Dry
Mx_Simhyd_Dry_LM_Rg=Mx_vec(7,1);Mx_Simhyd_Dry_LM_Rt=Mx_vec(7,2);
Mx_Simhyd_Dry_SCE_Rg=Mx_vec(7,3);Mx_Simhyd_Dry_SCE_Rt=Mx_vec(7,4);
%SIMHYD Ave
Mx_Simhyd_Ave_LM_Rg=Mx_vec(8,1);Mx_Simhyd_Ave_LM_Rt=Mx_vec(8,2);
Mx_Simhyd_Ave_SCE_Rg=Mx_vec(8,3);Mx_Simhyd_Ave_SCE_Rt=Mx_vec(8,4);
%SIMHYD Wet
Mx_Simhyd_Wet_LM_Rg=Mx_vec(9,1);Mx_Simhyd_Wet_LM_Rt=Mx_vec(9,2);
Mx_Simhyd_Wet_SCE_Rg=Mx_vec(9,3);Mx_Simhyd_Wet_SCE_Rt=Mx_vec(9,4);
%FUSE Dry
Mx_Fuse_Dry_LM_Rg=Mx_vec(10,1);Mx_Fuse_Dry_LM_Rt=Mx_vec(10,2);
Mx_Fuse_Dry_SCE_Rg=Mx_vec(10,3);Mx_Fuse_Dry_SCE_Rt=Mx_vec(10,4);
%FUSE Ave
Mx_Fuse_Ave_LM_Rg=Mx_vec(11,1);Mx_Fuse_Ave_LM_Rt=Mx_vec(11,2);
Mx_Fuse_Ave_SCE_Rg=Mx_vec(11,3);Mx_Fuse_Ave_SCE_Rt=Mx_vec(11,4);
%FUSE Wet
Mx_Fuse_Wet_LM_Rg=Mx_vec(12,1);Mx_Fuse_Wet_LM_Rt=Mx_vec(12,2);
Mx_Fuse_Wet_SCE_Rg=Mx_vec(12,3);Mx_Fuse_Wet_SCE_Rt=Mx_vec(12,4);

% load the data file
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_raw/HYMOD_Tambo.txt');
gnNS=1-gn/NSDRY;
qnNS=1-qn/NSDRY;
pestNS=1-pest/NSDRY;
sceNS=1-sce/NSDRY;
ddsNS=1-dds/NSDRY;
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
% create a masker for xtolT
seqSuccessTpest=false(size(pestNS,1),1);
seqSuccessTsce=false(size(sceNS,1),1);
% create a masker for xtolG
seqSuccessGpest=false(size(pestNS,1),1);
seqSuccessGsce=false(size(sceNS,1),1);
% count the number of success trails
PestT=sum(pestNS>xtolT);
PestG=sum(pestNS>xtolG);
sceT=sum(sceNS>xtolT);
sceG=sum(sceNS>xtolG);
% revert the marker for check
seqSuccessTpest(1:PestT)=1;
seqSuccessTsce(1:sceT)=1;
seqSuccessGpest(1:PestG)=1;
seqSuccessGsce(1:sceG)=1;

% LM_rg
Ntest=Ntest; Mx=Mx_Hymod_Dry_LM_Rg;seqSuccess=seqSuccessGpest;
[rx_lm_rg,sdev_rx_lm_rg]=rx_verif(Ntest, Mx, seqSuccess);
% LM_rt
Ntest=Ntest; Mx=Mx_Hymod_Dry_LM_Rt;seqSuccess=seqSuccessTpest;
[rx_lm_rt,sdev_rx_lm_rt]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rg
Ntest=Ntest; Mx=Mx_Hymod_Dry_SCE_Rg;seqSuccess=seqSuccessGsce;
[rx_sce_rg,sdev_rx_sce_rg]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rt
Ntest=Ntest; Mx=Mx_Hymod_Dry_SCE_Rt;seqSuccess=seqSuccessTsce;
[rx_sce_rt,sdev_rx_sce_rt]=rx_verif(Ntest, Mx, seqSuccess);
fprintf(formatSpec,rx_lm_rg,sdev_rx_lm_rg,rx_lm_rt,sdev_rx_lm_rt,rx_sce_rg,sdev_rx_sce_rg,rx_sce_rt,sdev_rx_sce_rt)

% load the data file
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_raw/SIXPAR_Tambo.txt');
gnNS=1-gn/NSDRY;
qnNS=1-qn/NSDRY;
pestNS=1-pest/NSDRY;
sceNS=1-sce/NSDRY;
ddsNS=1-dds/NSDRY;
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
% create a masker for xtolT
seqSuccessTpest=false(size(pestNS,1),1);
seqSuccessTsce=false(size(sceNS,1),1);
% create a masker for xtolG
seqSuccessGpest=false(size(pestNS,1),1);
seqSuccessGsce=false(size(sceNS,1),1);
% count the number of success trails
PestT=sum(pestNS>xtolT);
PestG=sum(pestNS>xtolG);
sceT=sum(sceNS>xtolT);
sceG=sum(sceNS>xtolG);
% revert the marker for check
seqSuccessTpest(1:PestT)=1;
seqSuccessTsce(1:sceT)=1;
seqSuccessGpest(1:PestG)=1;
seqSuccessGsce(1:sceG)=1;
% LM_rg
Ntest=Ntest; Mx=Mx_Sixpar_Dry_LM_Rg;seqSuccess=seqSuccessGpest;
[rx_lm_rg,sdev_rx_lm_rg]=rx_verif(Ntest, Mx, seqSuccess);
% LM_rt
Ntest=Ntest; Mx=Mx_Sixpar_Dry_LM_Rt;seqSuccess=seqSuccessTpest;
[rx_lm_rt,sdev_rx_lm_rt]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rg
Ntest=Ntest; Mx=Mx_Sixpar_Dry_SCE_Rg;seqSuccess=seqSuccessGsce;
[rx_sce_rg,sdev_rx_sce_rg]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rt
Ntest=Ntest; Mx=Mx_Sixpar_Dry_SCE_Rt;seqSuccess=seqSuccessTsce;
[rx_sce_rt,sdev_rx_sce_rt]=rx_verif(Ntest, Mx, seqSuccess);
fprintf(formatSpec,rx_lm_rg,sdev_rx_lm_rg,rx_lm_rt,sdev_rx_lm_rt,rx_sce_rg,sdev_rx_sce_rg,rx_sce_rt,sdev_rx_sce_rt)

% load the data file
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_raw/HYMOD_Bass.txt');
gnNS=1-gn/NSAVE;
qnNS=1-qn/NSAVE;
pestNS=1-pest/NSAVE;
sceNS=1-sce/NSAVE;
ddsNS=1-dds/NSAVE;
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
% create a masker for xtolT
seqSuccessTpest=false(size(pestNS,1),1);
seqSuccessTsce=false(size(sceNS,1),1);
% create a masker for xtolG
seqSuccessGpest=false(size(pestNS,1),1);
seqSuccessGsce=false(size(sceNS,1),1);
% count the number of success trails
PestT=sum(pestNS>xtolT);
PestG=sum(pestNS>xtolG);
sceT=sum(sceNS>xtolT);
sceG=sum(sceNS>xtolG);
% revert the marker for check
seqSuccessTpest(1:PestT)=1;
seqSuccessTsce(1:sceT)=1;
seqSuccessGpest(1:PestG)=1;
seqSuccessGsce(1:sceG)=1;
% LM_rg
Ntest=Ntest; Mx=Mx_Hymod_Ave_LM_Rg;seqSuccess=seqSuccessGpest;
[rx_lm_rg,sdev_rx_lm_rg]=rx_verif(Ntest, Mx, seqSuccess);
% LM_rt
Ntest=Ntest; Mx=Mx_Hymod_Ave_LM_Rt;seqSuccess=seqSuccessTpest;
[rx_lm_rt,sdev_rx_lm_rt]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rg
Ntest=Ntest; Mx=Mx_Hymod_Ave_SCE_Rg;seqSuccess=seqSuccessGsce;
[rx_sce_rg,sdev_rx_sce_rg]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rt
Ntest=Ntest; Mx=Mx_Hymod_Ave_SCE_Rt;seqSuccess=seqSuccessTsce;
[rx_sce_rt,sdev_rx_sce_rt]=rx_verif(Ntest, Mx, seqSuccess);
fprintf(formatSpec,rx_lm_rg,sdev_rx_lm_rg,rx_lm_rt,sdev_rx_lm_rt,rx_sce_rg,sdev_rx_sce_rg,rx_sce_rt,sdev_rx_sce_rt)

% load the data file
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_raw/SIXPAR_Bass.txt');
gnNS=1-gn/NSAVE;
qnNS=1-qn/NSAVE;
pestNS=1-pest/NSAVE;
sceNS=1-sce/NSAVE;
ddsNS=1-dds/NSAVE;
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
% create a masker for xtolT
seqSuccessTpest=false(size(pestNS,1),1);
seqSuccessTsce=false(size(sceNS,1),1);
% create a masker for xtolG
seqSuccessGpest=false(size(pestNS,1),1);
seqSuccessGsce=false(size(sceNS,1),1);
% count the number of success trails
PestT=sum(pestNS>xtolT);
PestG=sum(pestNS>xtolG);
sceT=sum(sceNS>xtolT);
sceG=sum(sceNS>xtolG);
% revert the marker for check
seqSuccessTpest(1:PestT)=1;
seqSuccessTsce(1:sceT)=1;
seqSuccessGpest(1:PestG)=1;
seqSuccessGsce(1:sceG)=1;
% LM_rg
Ntest=Ntest; Mx=Mx_Sixpar_Ave_LM_Rg;seqSuccess=seqSuccessGpest;
[rx_lm_rg,sdev_rx_lm_rg]=rx_verif(Ntest, Mx, seqSuccess);
% LM_rt
Ntest=Ntest; Mx=Mx_Sixpar_Ave_LM_Rt;seqSuccess=seqSuccessTpest;
[rx_lm_rt,sdev_rx_lm_rt]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rg
Ntest=Ntest; Mx=Mx_Sixpar_Ave_SCE_Rg;seqSuccess=seqSuccessGsce;
[rx_sce_rg,sdev_rx_sce_rg]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rt
Ntest=Ntest; Mx=Mx_Sixpar_Ave_SCE_Rt;seqSuccess=seqSuccessTsce;
[rx_sce_rt,sdev_rx_sce_rt]=rx_verif(Ntest, Mx, seqSuccess);
fprintf(formatSpec,rx_lm_rg,sdev_rx_lm_rg,rx_lm_rt,sdev_rx_lm_rt,rx_sce_rg,sdev_rx_sce_rg,rx_sce_rt,sdev_rx_sce_rt)

% load the data file
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_raw/HYMOD_Coopers.txt');
gnNS=1-gn/NSWET;
qnNS=1-qn/NSWET;
pestNS=1-pest/NSWET;
sceNS=1-sce/NSWET;
ddsNS=1-dds/NSWET;
% xbest=max([gnNS(1),qnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
% create a masker for xtolT
seqSuccessTpest=false(size(pestNS,1),1);
seqSuccessTsce=false(size(sceNS,1),1);
% create a masker for xtolG
seqSuccessGpest=false(size(pestNS,1),1);
seqSuccessGsce=false(size(sceNS,1),1);
% count the number of success trails
PestT=sum(pestNS>xtolT);
PestG=sum(pestNS>xtolG);
sceT=sum(sceNS>xtolT);
sceG=sum(sceNS>xtolG);
% revert the marker for check
seqSuccessTpest(1:PestT)=1;
seqSuccessTsce(1:sceT)=1;
seqSuccessGpest(1:PestG)=1;
seqSuccessGsce(1:sceG)=1;
% LM_rg
Ntest=Ntest; Mx=Mx_Hymod_Wet_LM_Rg;seqSuccess=seqSuccessGpest;
[rx_lm_rg,sdev_rx_lm_rg]=rx_verif(Ntest, Mx, seqSuccess);
% LM_rt
Ntest=Ntest; Mx=Mx_Hymod_Wet_LM_Rt;seqSuccess=seqSuccessTpest;
[rx_lm_rt,sdev_rx_lm_rt]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rg
Ntest=Ntest; Mx=Mx_Hymod_Wet_SCE_Rg;seqSuccess=seqSuccessGsce;
[rx_sce_rg,sdev_rx_sce_rg]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rt
Ntest=Ntest; Mx=Mx_Hymod_Wet_SCE_Rt;seqSuccess=seqSuccessTsce;
[rx_sce_rt,sdev_rx_sce_rt]=rx_verif(Ntest, Mx, seqSuccess);
fprintf(formatSpec,rx_lm_rg,sdev_rx_lm_rg,rx_lm_rt,sdev_rx_lm_rt,rx_sce_rg,sdev_rx_sce_rg,rx_sce_rt,sdev_rx_sce_rt)

% load the data file
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_raw/SIXPAR_Coopers.txt');
gnNS=1-gn/NSWET;
qnNS=1-qn/NSWET;
pestNS=1-pest/NSWET;
sceNS=1-sce/NSWET;
ddsNS=1-dds/NSWET;
% xbest=max([gnNS(1),qnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
% create a masker for xtolT
seqSuccessTpest=false(size(pestNS,1),1);
seqSuccessTsce=false(size(sceNS,1),1);
% create a masker for xtolG
seqSuccessGpest=false(size(pestNS,1),1);
seqSuccessGsce=false(size(sceNS,1),1);
% count the number of success trails
PestT=sum(pestNS>xtolT);
PestG=sum(pestNS>xtolG);
sceT=sum(sceNS>xtolT);
sceG=sum(sceNS>xtolG);
% revert the marker for check
seqSuccessTpest(1:PestT)=1;
seqSuccessTsce(1:sceT)=1;
seqSuccessGpest(1:PestG)=1;
seqSuccessGsce(1:sceG)=1;
% LM_rg
Ntest=Ntest; Mx=Mx_Sixpar_Wet_LM_Rg;seqSuccess=seqSuccessGpest;
[rx_lm_rg,sdev_rx_lm_rg]=rx_verif(Ntest, Mx, seqSuccess);
% LM_rt
Ntest=Ntest; Mx=Mx_Sixpar_Wet_LM_Rt;seqSuccess=seqSuccessTpest;
[rx_lm_rt,sdev_rx_lm_rt]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rg
Ntest=Ntest; Mx=Mx_Sixpar_Wet_SCE_Rg;seqSuccess=seqSuccessGsce;
[rx_sce_rg,sdev_rx_sce_rg]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rt
Ntest=Ntest; Mx=Mx_Sixpar_Wet_SCE_Rt;seqSuccess=seqSuccessTsce;
[rx_sce_rt,sdev_rx_sce_rt]=rx_verif(Ntest, Mx, seqSuccess);
fprintf(formatSpec,rx_lm_rg,sdev_rx_lm_rg,rx_lm_rt,sdev_rx_lm_rt,rx_sce_rg,sdev_rx_sce_rg,rx_sce_rt,sdev_rx_sce_rt)

% load the data file
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_raw/SIMHYD_Tambo.txt');
gnNS=1-gn/NSDRY;
qnNS=1-qn/NSDRY;
pestNS=1-pest/NSDRY;
sceNS=1-sce/NSDRY;
ddsNS=1-dds/NSDRY;
% xbest=max([gnNS(1),qnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
% create a masker for xtolT
seqSuccessTpest=false(size(pestNS,1),1);
seqSuccessTsce=false(size(sceNS,1),1);
% create a masker for xtolG
seqSuccessGpest=false(size(pestNS,1),1);
seqSuccessGsce=false(size(sceNS,1),1);
% count the number of success trails
PestT=sum(pestNS>xtolT);
PestG=sum(pestNS>xtolG);
sceT=sum(sceNS>xtolT);
sceG=sum(sceNS>xtolG);
% revert the marker for check
seqSuccessTpest(1:PestT)=1;
seqSuccessTsce(1:sceT)=1;
seqSuccessGpest(1:PestG)=1;
seqSuccessGsce(1:sceG)=1;
% LM_rg
Ntest=Ntest; Mx=Mx_Simhyd_Dry_LM_Rg;seqSuccess=seqSuccessGpest;
[rx_lm_rg,sdev_rx_lm_rg]=rx_verif(Ntest, Mx, seqSuccess);
% LM_rt
Ntest=Ntest; Mx=Mx_Simhyd_Dry_LM_Rt;seqSuccess=seqSuccessTpest;
[rx_lm_rt,sdev_rx_lm_rt]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rg
Ntest=Ntest; Mx=Mx_Simhyd_Dry_SCE_Rg;seqSuccess=seqSuccessGsce;
[rx_sce_rg,sdev_rx_sce_rg]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rt
Ntest=Ntest; Mx=Mx_Simhyd_Dry_SCE_Rt;seqSuccess=seqSuccessTsce;
[rx_sce_rt,sdev_rx_sce_rt]=rx_verif(Ntest, Mx, seqSuccess);
fprintf(formatSpec,rx_lm_rg,sdev_rx_lm_rg,rx_lm_rt,sdev_rx_lm_rt,rx_sce_rg,sdev_rx_sce_rg,rx_sce_rt,sdev_rx_sce_rt)

% load the data file
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_raw/FUSE_Tambo.txt');
gnNS=1-gn/NSDRY;
qnNS=1-qn/NSDRY;
pestNS=1-pest/NSDRY;
sceNS=1-sce/NSDRY;
ddsNS=1-dds/NSDRY;
% xbest=max([gnNS(1),qnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
% create a masker for xtolT
seqSuccessTpest=false(size(pestNS,1),1);
seqSuccessTsce=false(size(sceNS,1),1);
% create a masker for xtolG
seqSuccessGpest=false(size(pestNS,1),1);
seqSuccessGsce=false(size(sceNS,1),1);
% count the number of success trails
PestT=sum(pestNS>xtolT);
PestG=sum(pestNS>xtolG);
sceT=sum(sceNS>xtolT);
sceG=sum(sceNS>xtolG);
% revert the marker for check
seqSuccessTpest(1:PestT)=1;
seqSuccessTsce(1:sceT)=1;
seqSuccessGpest(1:PestG)=1;
seqSuccessGsce(1:sceG)=1;
% LM_rg
Ntest=Ntest; Mx=Mx_Fuse_Dry_LM_Rg;seqSuccess=seqSuccessGpest;
[rx_lm_rg,sdev_rx_lm_rg]=rx_verif(Ntest, Mx, seqSuccess);
% LM_rt
Ntest=Ntest; Mx=Mx_Fuse_Dry_LM_Rt;seqSuccess=seqSuccessTpest;
[rx_lm_rt,sdev_rx_lm_rt]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rg
Ntest=Ntest; Mx=Mx_Fuse_Dry_SCE_Rg;seqSuccess=seqSuccessGsce;
[rx_sce_rg,sdev_rx_sce_rg]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rt
Ntest=Ntest; Mx=Mx_Fuse_Dry_SCE_Rt;seqSuccess=seqSuccessTsce;
[rx_sce_rt,sdev_rx_sce_rt]=rx_verif(Ntest, Mx, seqSuccess);
fprintf(formatSpec,rx_lm_rg,sdev_rx_lm_rg,rx_lm_rt,sdev_rx_lm_rt,rx_sce_rg,sdev_rx_sce_rg,rx_sce_rt,sdev_rx_sce_rt)

% load the data file
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_raw/SIMHYD_Bass.txt');
gnNS=1-gn/NSAVE;
qnNS=1-qn/NSAVE;
pestNS=1-pest/NSAVE;
sceNS=1-sce/NSAVE;
ddsNS=1-dds/NSAVE;
% xbest=max([gnNS(1),qnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
% create a masker for xtolT
seqSuccessTpest=false(size(pestNS,1),1);
seqSuccessTsce=false(size(sceNS,1),1);
% create a masker for xtolG
seqSuccessGpest=false(size(pestNS,1),1);
seqSuccessGsce=false(size(sceNS,1),1);
% count the number of success trails
PestT=sum(pestNS>xtolT);
PestG=sum(pestNS>xtolG);
sceT=sum(sceNS>xtolT);
sceG=sum(sceNS>xtolG);
% revert the marker for check
seqSuccessTpest(1:PestT)=1;
seqSuccessTsce(1:sceT)=1;
seqSuccessGpest(1:PestG)=1;
seqSuccessGsce(1:sceG)=1;
% LM_rg
Ntest=Ntest; Mx=Mx_Simhyd_Ave_LM_Rg;seqSuccess=seqSuccessGpest;
[rx_lm_rg,sdev_rx_lm_rg]=rx_verif(Ntest, Mx, seqSuccess);
% LM_rt
Ntest=Ntest; Mx=Mx_Simhyd_Ave_LM_Rt;seqSuccess=seqSuccessTpest;
[rx_lm_rt,sdev_rx_lm_rt]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rg
Ntest=Ntest; Mx=Mx_Simhyd_Ave_SCE_Rg;seqSuccess=seqSuccessGsce;
[rx_sce_rg,sdev_rx_sce_rg]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rt
Ntest=Ntest; Mx=Mx_Simhyd_Ave_SCE_Rt;seqSuccess=seqSuccessTsce;
[rx_sce_rt,sdev_rx_sce_rt]=rx_verif(Ntest, Mx, seqSuccess);
fprintf(formatSpec,rx_lm_rg,sdev_rx_lm_rg,rx_lm_rt,sdev_rx_lm_rt,rx_sce_rg,sdev_rx_sce_rg,rx_sce_rt,sdev_rx_sce_rt)

% load the data file
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_raw/FUSE_Bass.txt');
gnNS=1-gn/NSAVE;
qnNS=1-qn/NSAVE;
pestNS=1-pest/NSAVE;
sceNS=1-sce/NSAVE;
ddsNS=1-dds/NSAVE;
% xbest=max([gnNS(1),qnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
% create a masker for xtolT
seqSuccessTpest=false(size(pestNS,1),1);
seqSuccessTsce=false(size(sceNS,1),1);
% create a masker for xtolG
seqSuccessGpest=false(size(pestNS,1),1);
seqSuccessGsce=false(size(sceNS,1),1);
% count the number of success trails
PestT=sum(pestNS>xtolT);
PestG=sum(pestNS>xtolG);
sceT=sum(sceNS>xtolT);
sceG=sum(sceNS>xtolG);
% revert the marker for check
seqSuccessTpest(1:PestT)=1;
seqSuccessTsce(1:sceT)=1;
seqSuccessGpest(1:PestG)=1;
seqSuccessGsce(1:sceG)=1;
% LM_rg
Ntest=Ntest; Mx=Mx_Fuse_Ave_LM_Rg;seqSuccess=seqSuccessGpest;
[rx_lm_rg,sdev_rx_lm_rg]=rx_verif(Ntest, Mx, seqSuccess);
% LM_rt
Ntest=Ntest; Mx=Mx_Fuse_Ave_LM_Rt;seqSuccess=seqSuccessTpest;
[rx_lm_rt,sdev_rx_lm_rt]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rg
Ntest=Ntest; Mx=Mx_Fuse_Ave_SCE_Rg;seqSuccess=seqSuccessGsce;
[rx_sce_rg,sdev_rx_sce_rg]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rt
Ntest=Ntest; Mx=Mx_Fuse_Ave_SCE_Rt;seqSuccess=seqSuccessTsce;
[rx_sce_rt,sdev_rx_sce_rt]=rx_verif(Ntest, Mx, seqSuccess);
fprintf(formatSpec,rx_lm_rg,sdev_rx_lm_rg,rx_lm_rt,sdev_rx_lm_rt,rx_sce_rg,sdev_rx_sce_rg,rx_sce_rt,sdev_rx_sce_rt)

% load the data file
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_raw/SIMHYD_Coopers.txt');
gnNS=1-gn/NSWET;
qnNS=1-qn/NSWET;
pestNS=1-pest/NSWET;
sceNS=1-sce/NSWET;
ddsNS=1-dds/NSWET;
% xbest=max([gnNS(1),qnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
% create a masker for xtolT
seqSuccessTpest=false(size(pestNS,1),1);
seqSuccessTsce=false(size(sceNS,1),1);
% create a masker for xtolG
seqSuccessGpest=false(size(pestNS,1),1);
seqSuccessGsce=false(size(sceNS,1),1);
% count the number of success trails
PestT=sum(pestNS>xtolT);
PestG=sum(pestNS>xtolG);
sceT=sum(sceNS>xtolT);
sceG=sum(sceNS>xtolG);
% revert the marker for check
seqSuccessTpest(1:PestT)=1;
seqSuccessTsce(1:sceT)=1;
seqSuccessGpest(1:PestG)=1;
seqSuccessGsce(1:sceG)=1;
% LM_rg
Ntest=Ntest; Mx=Mx_Simhyd_Wet_LM_Rg;seqSuccess=seqSuccessGpest;
[rx_lm_rg,sdev_rx_lm_rg]=rx_verif(Ntest, Mx, seqSuccess);
% LM_rt
Ntest=Ntest; Mx=Mx_Simhyd_Wet_LM_Rt;seqSuccess=seqSuccessTpest;
[rx_lm_rt,sdev_rx_lm_rt]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rg
Ntest=Ntest; Mx=Mx_Simhyd_Wet_SCE_Rg;seqSuccess=seqSuccessGsce;
[rx_sce_rg,sdev_rx_sce_rg]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rt
Ntest=Ntest; Mx=Mx_Simhyd_Wet_SCE_Rt;seqSuccess=seqSuccessTsce;
[rx_sce_rt,sdev_rx_sce_rt]=rx_verif(Ntest, Mx, seqSuccess);
fprintf(formatSpec,rx_lm_rg,sdev_rx_lm_rg,rx_lm_rt,sdev_rx_lm_rt,rx_sce_rg,sdev_rx_sce_rg,rx_sce_rt,sdev_rx_sce_rt)

% load the data file
[xaxis,gn,gnnum,qn,qnnum,pest,pestnum,sce,scenum,dds,ddsnum]=textread('../0_raw/FUSE_Coopers.txt');
gnNS=1-gn/NSWET;
qnNS=1-qn/NSWET;
pestNS=1-pest/NSWET;
sceNS=1-sce/NSWET;
ddsNS=1-dds/NSWET;
% xbest=max([gnNS(1),qnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xbest=max([gnNS(1),pestNS(1),sceNS(1),ddsNS(1)]);
xtolT=xbest-xbest*tolT;
xtolG=xbest-xbest*tolG;
% create a masker for xtolT
seqSuccessTpest=false(size(pestNS,1),1);
seqSuccessTsce=false(size(sceNS,1),1);
% create a masker for xtolG
seqSuccessGpest=false(size(pestNS,1),1);
seqSuccessGsce=false(size(sceNS,1),1);
% count the number of success trails
PestT=sum(pestNS>xtolT);
PestG=sum(pestNS>xtolG);
sceT=sum(sceNS>xtolT);
sceG=sum(sceNS>xtolG);
% revert the marker for check
seqSuccessTpest(1:PestT)=1;
seqSuccessTsce(1:sceT)=1;
seqSuccessGpest(1:PestG)=1;
seqSuccessGsce(1:sceG)=1;
% LM_rg
Ntest=Ntest; Mx=Mx_Fuse_Wet_LM_Rg;seqSuccess=seqSuccessGpest;
[rx_lm_rg,sdev_rx_lm_rg]=rx_verif(Ntest, Mx, seqSuccess);
% LM_rt
Ntest=Ntest; Mx=Mx_Fuse_Wet_LM_Rt;seqSuccess=seqSuccessTpest;
[rx_lm_rt,sdev_rx_lm_rt]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rg
Ntest=Ntest; Mx=Mx_Fuse_Wet_SCE_Rg;seqSuccess=seqSuccessGsce;
[rx_sce_rg,sdev_rx_sce_rg]=rx_verif(Ntest, Mx, seqSuccess);
% SCE_rt
Ntest=Ntest; Mx=Mx_Fuse_Wet_SCE_Rt;seqSuccess=seqSuccessTsce;
[rx_sce_rt,sdev_rx_sce_rt]=rx_verif(Ntest, Mx, seqSuccess);
fprintf(formatSpec,rx_lm_rg,sdev_rx_lm_rg,rx_lm_rt,sdev_rx_lm_rt,rx_sce_rg,sdev_rx_sce_rg,rx_sce_rt,sdev_rx_sce_rt)