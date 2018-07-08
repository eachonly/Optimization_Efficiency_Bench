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

function [ rx , sdev_rx ] = rx_verif( Ntest,Mx,seqSuccess)
% Input
%   Ntest: number of test used to validate
%   Mx number of multistarts used in each test
%   seqSuccess: master dataset of algorithm performance

% Output
%   Empirical reliability rx
%   Standard deviation of rx

count=0;
nrow=size(seqSuccess,1);
for totalTest=1:Ntest
    for innerTest=1:Mx
        num=round(1+(nrow-1)*rand());
        if seqSuccess(num)
            count=count+1;
            break;
        end
    end
end
rx=real(count)/real(Ntest);
sdev_rx=sqrt(rx*(1-rx)) / Ntest;
end

