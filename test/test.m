close all
clear
clc

% Parameters
parameter = 4;
tsim = 5;

% Input
input = timeseries([3 2 3],[0 1 tsim]);

% Output
in = Simulink.SimulationInput('test_model');
in = in.setModelParameter('StopTime',num2str(tsim));
in = in.setModelParameter('ReturnWorkspaceOutputs','on');
out = sim(in);

figure
plot(input)

figure
plot(out.output)