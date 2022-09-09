function [y1] = myNeuralNetworkFunction_decoupling_noNoise_Accel(x1)
%MYNEURALNETWORKFUNCTION neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 30-Jun-2022 15:57:09.
%
% [y1] = myNeuralNetworkFunction(x1) takes these arguments:
%   x = 3xQ matrix, input #1
% and returns:
%   y = 4xQ matrix, output #1
% where Q is the number of samples.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [-20;-20;-108];
x1_step1.gain = [0.05;0.05;0.00925925925925926];
x1_step1.ymin = -1;

% Layer 1
b1 = [0.0041443116289630582;0.0085716052261298903564;-0.0041902455370988658107;-0.0018458522621971531347;-0.0072557930544598098904;0.004464952453438936035;0.00036590446961261649268;-0.000146635771909129492;-0.00094500897216133754493;-5.1407622010580226622e-05];
IW1_1 = [-0.39388930031103674967 -0.40395787422177531489 0.44179056693650486931;0.37226957792968101701 -0.13934552558135052114 -0.43847544797669435468;0.4041409723533717635 0.40522085363830845361 -0.44137436905473453885;0.35232048231871160304 -0.39530716707345042726 -0.44598246641770000753;-0.42199173848907156614 -0.44073052797898415456 -0.44614692151986551361;-0.35012429390998411893 0.41672103875598154321 0.44989271535850328121;0.36737191944650327002 -0.36779683672186469501 0.43579448783118329702;-0.42151427618273928921 -0.43868492383306328941 -0.44263250458413960775;-0.30384415457679236905 0.3708202985385632422 -0.43541529388969324454;0.37692379941261822118 -0.30609616606074097067 0.44103553022805669359];

% Layer 2
b2 = [-0.0013784500539916870205;0.0080560387984793327409;0.00020333407611567658885;0.0066639528862425046266];
LW2_1 = [-0.52938251833210947517 0.50446884160332250424 0.53692598883008657573 0.50252744674457761054 -0.063178153415281559924 -0.50662353778359858758 0.032056228266754298317 -0.061043464629472424243 0.014390724157169278163 0.031811630036924117004;0.062563594276557693563 0.33731679599262825997 -0.063563029992390315814 0.51606392790516097957 0.55193535882161270933 -0.52967598314725317099 0.031353321538462534945 0.55013704629753135134 -0.033614763920473383907 -0.012431333385335110314;0.04847156822926465547 -0.036021096024190124574 -0.057209411590672575032 -0.0068089924341472414168 0.55435011697142810849 -0.00060543348110320778423 -0.4973903366864822484 0.55625693831581957127 0.44989702720770485822 -0.51196716534899922024;-0.53102537157138041124 0.13714791529562930794 0.53205654197980989384 -0.055335016441020019873 -0.093587466570046629055 0.072511401497475674871 -0.50117633809056760796 -0.09302583071128389669 0.50348294543767690978 -0.45294708834733737879];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = [0.01;0.01;0.01;0.01];
y1_step1.xoffset = [-100;-100;-100;-100];

% ===== SIMULATION ========

% Dimensions
Q = size(x1,2); % samples

% Input 1
xp1 = mapminmax_apply(x1,x1_step1);

% Layer 1
a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*xp1);

% Layer 2
a2 = repmat(b2,1,Q) + LW2_1*a1;

% Output 1
y1 = mapminmax_reverse(a2,y1_step1);
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings)
y = bsxfun(@minus,x,settings.xoffset);
y = bsxfun(@times,y,settings.gain);
y = bsxfun(@plus,y,settings.ymin);
end

% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n,~)
a = 2 ./ (1 + exp(-2*n)) - 1;
end

% Map Minimum and Maximum Output Reverse-Processing Function
function x = mapminmax_reverse(y,settings)
x = bsxfun(@minus,y,settings.ymin);
x = bsxfun(@rdivide,x,settings.gain);
x = bsxfun(@plus,x,settings.xoffset);
end
