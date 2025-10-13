#import "../template.typ": *

= Lecture 3

== Parameter Estimation

This is the process of estimating the key parameters within a given PDF ($mu , sigma$ for Gaussian $lambda$ for exponential etc) by using the current set of data. for all parameter estimation techniques, the following must be true:

- *Unbiased:*: The estimator should not consistently under or overestimate the true value of the parameter.
- *Consistent*: The estimator should converge to the true value as the sample size increases.
- *Efficient*: The estimator should be consistent with a standard deviation in that estimate smaller than any other estimator for the same population.
- *Sufficient*: The estimator should use all of the information about the parameter that the data sample possesses.

All parameter estimation models depend on the quality of the data used. The three most common methods are the *method of moments*, the *maximum likelihood method* and the *least squares method*.

== Maximum Likelihood Estimation

Maximum Likelihood Estimation (MLE) is a parameter estimation processed based on the most likely estimate of the data, and roughly consists of the following steps:

+ Define the formulation of the PDF.
+ Define the parameter to estimate.
+ Define the natural log of the PDF
+ Define the log likelihood function.
+ Define it's derivative(s).
+ Equate the derivative(s) to zero and solve for the parameter(s).

== How to Do MLE

For MLE we assume we already know which PDF form we are using (Gaussian, exponential, Weibull etc). The PDF as well as the parameters are written in the form shown in *@3-density-function*, known as the *density function*.

$
  f(t; theta_1, theta_2 ,...,theta_m) equiv f(t:theta)
$<3-density-function>

Where:

- *$theta$*: PDF parameters ($theta_1, theta_2 ,...,theta_m$)

For example, $theta_1 "and" theta_2$ for a Gaussian distribution would be $mu "and" sigma$. Following on from *@3-density-function*, the likelihood is mathematically defined in *@3-likelihood-function*.

$
  L(theta) = product^n_(i=1)f(t_i:theta)
$<3-likelihood-function>

Where $L(theta)$ is the *likelihood* for a given PDF parameter. Effectively, the likelihood itself will hel to fit the correct PDF parameters to the given form of the data. The definition of $L(theta)$ has its issues however, mainly that the product of the probabilities reduce very quickly and so instead the log-likelihood is used, defined in *@3-log-likelihood-function*.

$
  l(theta) = log L(theta)
$<3-log-likelihood-function>

Where $l(theta)$ is the log-likelihood and gets around the issue of very small probabilities. The maximum likelihood estimators of the PDF parameters are written in the notation shown in *@3-most-likely-parameters*.

$
  accent(theta, hat)_1,accent(theta, hat)_2, ... ,accent(theta, hat)_m
$<3-most-likely-parameters>

The values of *@3-most-likely-parameters* can be obtained using an optimization algorithm, or can be obtained via analytical equations using the criteria shown in *@3-likelihood-criteria*.

$
  (diff l)/(diff theta_j) = 0 #h(1cm) j=1,2,...,m
$<3-likelihood-criteria>

== MLE for a Gaussian Distribution

