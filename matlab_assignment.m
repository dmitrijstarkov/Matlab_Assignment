% Matlab assignment
% Dmitrij Starkov

% 1.)	
% Generate 200 real numbers from a Gaussian distribution, with mean 0 and 
% standard deviation 1:
datasize = 200;
data_distribution=randn(datasize,1);


% Generate a histogram of the sample, choosing the number of bins with the 
% Freedman-Diaconis rule:
% Plotting 1st histogram with original distribution
figure
histogram(data_distribution,'BinMethod','fd') 

% Main plot, where all histograms go for comparison
standard_deviation=std(data_distribution);
figure
subplot(3,5,1)
histfit(data_distribution) 
title( 'Before replacements')        
xlabel(strcat('standard deviation =', num2str(standard_deviation)))
axis([-7 7 0 60])

% 2.) Run a Chi-square test for Gaussianity to test the hypothesis that the 
% numbers are a sample from a Gaussian distribution. Report the result in 
% terms of answer (yes or no) and significance level:
variance=var(data_distribution); 
fprintf ('significance level \t| test rejects H0 that data follows a normal distribution \n')
for significance_lvl = 0.01:0.01:0.05
    response = chi2gof(data_distribution, 'Alpha', significance_lvl);
    if response(1)==0
        response_text='Yes, it is Gaussian, as it failed to reject H0';
    else
        response_text='No, it is not Gaussian, because it does reject H0';
    end
fprintf ('\t\t%.2f \t\t\t%s \n', significance_lvl, response_text)
end

% 3.) Eliminate 10 numbers, chosen at random, from the initial set, and 
% replace them with numbers drawn from a uniform distribution of mean 0 and 
% standard deviation 3.
newvalues=10;
uniform_stddev=3;
newdata = data_distribution;
% range [-x_max:x_max]
% sd = ( b - a ) / sqrt(12) = x_max / sqrt (3) => x_max = sd * sqrt (3) 
x_max = uniform_stddev * sqrt (3);

% Loop 10 times for step 5
loopnumb=10;
for loop_i = 1:loopnumb
    fprintf ('Loop #%d \n', loop_i);    
    randvalue=rand(newvalues,1) * 2 * x_max - x_max ;
    std(randvalue)
    randindex=round(rand(newvalues,1)*datasize) + 1;
    for i = 1:newvalues
        newdata ( randindex(i) ) = randvalue (i) ;
    end


% 4.) Repeat step 2.

variance = var(newdata);
standard_deviation=std(newdata);
fprintf ('significance level \t| test rejects H0 that data follows a normal distribution \n')
for significance_lvl = [0.01 0.05 0.1]
        response = chi2gof(newdata, 'Alpha', significance_lvl);
        if response(1)==0
            response_text='Yes, it is Gaussian, as it failed to reject H0';
        else
            response_text='No, it is not Gaussian, because it does reject H0';
        end
    fprintf ('\t\t%.2f \t\t\t%s \n', significance_lvl, response_text)
end

% Plotting rest histograms

subplot(3,5,loop_i+1)
histfit(newdata)
    title( strcat('After' , {' '}, num2str(loop_i * newvalues ), ' replacements'))
    xlabel(strcat('standard deviation =', num2str(standard_deviation)))
axis([-7 7 0 60])


end

% 5.) Repeat steps 3 and 4 for 10 times, each time removing 10 numbers in 
% random positions from the original Gaussian sample, and replacing them 
% with a new set of uniform deviates. (Loop used)