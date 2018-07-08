The fast and the robust: Trade-offs between optimization robustness and cost in the calibration of environmental models

Dmitri Kavetski(1,2), Youwei Qin(3) and George Kuczera(2)

(1) School of Civil, Environmental and Mining Engineering, University of Adelaide, SA 5005, Australia
(2) School of Engineering, University of Newcastle, Callaghan, NSW 2300, Australia
(3) State Key Laboratory of Hydrology, Water Resources and Hydraulic Engineering, Centre for Global Change and Water Cycle, Hohai University, Nanjing 210098, China

Research paper submitted to Water Resources Research 3 October 2017, revised 4 July 2018

==================

This file details the organization of files and folders, and the operation of Matlab and Excel files


*** 1. List of Folders ***

0_araw            : Raw data for multiple algorithm invocations over 12 scenarios: objective function value and number of function calls at convergence
1_figure1_best100 : Raw data and matlab skript for emprical distribution function plot
2_rx              : Matlab skript to evaluate global and tolerable reliabilities; uses data in folder "0_araw"
3_mx_cx_eff       : Excel spreedsheet to evaluate Mx, Cx, Efficiency ratio for a given confidence level (eg, 95%); uses a pre-calculated Rx from Item 1.2 above
4_reliab_verif    : Matlab skript to verify Mx estimates (see Sections 4.3.2 and 5.5 in main text); uses data in folder "0_araw"


*** 2. List of Matlab and Excel skripts ***

ecdf.m            : Matlab skript to plot the emprical distribution plot of given algorithm
rx_calc.m         : Matlab skript to evaluate Rx with given global/tolerable reliabilities
main_rx_verif.m   : Matlab skript to verify Mx; requires axiliary function 'rx_verify.m'
rx_verif.m        : Auxilliary function to verify Mx
mx_cx_eff.xlsx    : Excel spreedsheet to evaluate Mx, Cx, Eff over a range of confidence levels


*** Key points ***

1. Excel file 'mx_cx_eff.xlsx' should be run multiple times to get Mx for different confidence levels, eg, 5%, 25%, ... , 95%, 99%, and produces files named alphaXX.txt, where XX is the confidence level
2. Matlab file 'main_rx_verif.m' uses the pre-calculated Mx values from 'mx_cx_eff.xlsx' at given confidence levels
