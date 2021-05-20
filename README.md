# A second benchmarking exercise on estimating extreme environmental conditions
This is the official respository for the second benchmarking excercise, announced at OMAE 2021. It is the successor of EC benchmark 1 (https://github.com/ec-benchmark-organizers/ec-benchmark).

## Participating in the benchmark
To participate in the benchmark, please contact us at <ecbenchmark@gmail.com>

The benchmark exercises and instructions are described in detail in the OMAE paper, a preprint of which is available [here](https://github.com/ec-benchmark-organizers/ec-benchmark-2/blob/main/publications/OMAE2021-64874_EC_Benchmark2.pdf)

## Datasets
The 6 datasets are located in the folder [datasets](https://github.com/ec-benchmark-organizers/ec-benchmark-2/tree/main/datasets).

## Preparing your results
Please submit your results in comma-separated value (CSV) files.

For each exercise and each site, please submit a separate file for the return values and the full distribution (12 files total)

Examples of formatted submission files are provided [here](https://github.com/ec-benchmark-organizers/ec-benchmark-2/tree/main/results/baseline)

For Exercise 1, the files for each site should be named "Ex1_SiteX_ReturnValues_YourName.csv" and "Ex1_SiteX_AnnualDist_YourName.csv"

The return value files should have the following content, (where "CI 2.5%" and "CI 97.5%" are the 2.5% and 97.5% confidence interval for the return value):

Return Period [years],Return Value [m],CI 2.5% [m],CI 97.5% [m]\
5,xxx,xxx,xxx\
50,xxx,xxx,xxx\
500,xxx,xxx,xxx

The annual distribution files should have the following content:

Exceedance Prob,Quantile [m],CI 2.5% [m],CI 97.5% [m]\
1.00000,xxx,xxx,xxx\
0.93260,xxx,xxx,xxx\
0.86975,xxx,xxx,xxx\
...

For Exercise 2, the files for each site should be named "Ex1_SiteX_Quantiles_YourName.csv" and "Ex1_SiteX_F25Dist_YourName.csv"

Both files should follow this format:

Exceedance Prob,Quantile [m],CI 2.5% [m],CI 97.5% [m]\
xxx,xxx,xxx,xxx\
...

For the "Quantiles" file, please use exceedance probabilities of (1-1/N)^(1/25) for N = 5, 50 and 500.\
For the "F25Dist" file, please use exceedance probabilities of (1-1/N)^(1/25) for N at 100 equally spaced logarithmic increments, between 1 and 1000.

## Example analysis
MATLAB code for the baseline analysis, described in the OMAE2021 paper, is provided as an example [here](https://github.com/ec-benchmark-organizers/ec-benchmark-2/tree/main/organizers-code/baseline_annual_maxima)

## Questions
Please feel free to [open an issue](https://github.com/ec-benchmark-organizers/ec-benchmark-2/issues/new) if you have a questions and we will answer it publicly in the same issue. Alternatively, you can contact us by email: <ecbenchmark@gmail.com>
