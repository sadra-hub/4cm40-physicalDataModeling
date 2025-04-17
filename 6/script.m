close all
clear
clc

%% Given

target = @(x,n) n^n*x.^(n-1)/factorial(n-1) .* exp(-n*x) .* (x>=0);
unnormalized_target = @(x,n) 1.2*target(x,n);

n = 5;
number_of_samples = 1e3;
initial_sample = 2.5;

%% What you need to implement

% Part a
proposal = @(xProposed, xPrevious, n) normpdf(xProposed, 1, sqrt(1/5));
sample_from_proposal = @(xPrevious, n) normrnd(1, sqrt(1/5));
compute_acceptance_probability = @(xProposed, xPrevious, n) ...
    min(1, (unnormalized_target(xProposed, n) * normpdf(xPrevious, 1, sqrt(1/5))) / ...
           (unnormalized_target(xPrevious, n) * normpdf(xProposed, 1, sqrt(1/5))));

%% The Metropolis-Hastings algorithm

samples = zeros(number_of_samples,1);
proposed_samples = zeros(number_of_samples,1);
acceptance_probability = zeros(number_of_samples,1);
samples(1) = initial_sample;
for i = 2:number_of_samples
    xPrevious = samples(i-1);
    xProposed = sample_from_proposal(xPrevious,n);
    proposed_samples(i) = xProposed;
    acceptance_probability(i) = compute_acceptance_probability(xProposed,xPrevious,n);
    u = rand;
    if u <= acceptance_probability(i)
        samples(i) = xProposed;
    else
        samples(i) = xPrevious;
    end
end

%% Plotting the results

xPlot = linspace(-1,3,1e3);

figure
    plot(xPlot,target(xPlot,n),'k','DisplayName','Target distribution')
    hold on
    plot(xPlot,unnormalized_target(xPlot,n),'k--','DisplayName','Unnormalized target distribution')
    plot(xPlot,proposal(xPlot,initial_sample,n),'r','DisplayName','(Initial) proposal distribution')
    plot(sort(samples),-0.1*ones(length(samples),1),'b.','MarkerSize',15,'DisplayName','MCMC samples')
    plot(initial_sample,-0.1,'bo','MarkerSize',10,'DisplayName','Initial MCMC sample')
    histogram(samples,'Normalization','pdf','DisplayName','Histogram MCMC samples')
    xlabel('x')
    legend('Location','Best')