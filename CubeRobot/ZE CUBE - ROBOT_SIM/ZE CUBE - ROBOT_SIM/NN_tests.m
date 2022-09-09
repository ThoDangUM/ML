% The script tests Neural Network toolbox
p = {0 0 1 1 1 1 0 0 0 0 0 0};
stem(cell2mat(p));
% static net
net = linearlayer;
net.inputs{1}.size = 1;
net.layers{1}.dimensions = 1;
net.biasConnect = 0;
net.IW{1,1} = 2;
view(net);
a = net(p);
stem(cell2mat(a));
% Dynamic net
netd = linearlayer([0 1]);
netd.inputs{1}.size = 1;
netd.layers{1}.dimensions = 1;
netd.biasConnect = 0;
netd.IW{1,1} = [1 1];
view(netd);
ad = netd(p);
figure;
stem(cell2mat(ad));
% recurrent dynamic network
netr = narxnet(0,1,[],'closed');
netr.inputs{1}.size = 1;
netr.layers{1}.dimensions = 1;
netr.biasConnect = 0;
netr.LW{1} = 0.5;
netr.IW{1} = 1;
view(netr);
ar = netr(p);
figure;
stem(cell2mat(ar));