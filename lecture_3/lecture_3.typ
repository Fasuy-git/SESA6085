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

=== MLE for a Gaussian Distribution

Recall that the form that the PDF takes for a Gaussian distribution is given in *@2-gaussian-dist-pdf*. Currently, $mu " & " sigma$ are unknown for a given set of data, MLE can be used to obtain $accent(mu, hat) " & " accent(sigma, hat)$. For a given observation $t_i$, the log likelihood of the Guassian PDF is given in *@3-guassian-MLE-1*.

$
  ln(f(t_i)) = - ln(sigma) - 1/2 ln(2 pi) - 1/2 ((t_i - mu)/(sigma))^2
$<3-guassian-MLE-1>

Moving on from *@3-guassian-MLE-1*, the MLE parameters are defined and the equation is re-written in *@3-guassian-MLE-2*.

$
  l(mu,sigma) = ln(L(mu,sigma)) = ln(product^n_(i=1) f(t_i:mu, sigma)) = sum^n_(i=1) ln(f(t_i:mu, sigma))
$<3-guassian-MLE-2>

Note that in *@3-guassian-MLE-2*, using the log likelihood here is advantageous as it converts the products into much more manageable sums. Applying the sums in  *@3-guassian-MLE-2* to  *@3-guassian-MLE-1* yields  *@3-guassian-MLE-3*.

$
  ln(f(t_i)) = -n ln(sigma) - n/2 ln(2 pi) - sum^n_(i=1) 1/2 ((t_i - mu)/(sigma))^2
$<3-guassian-MLE-3>

Taking the partial derivative of the log likelihood function with respect to the PDF parameters yields *@3-guassian-MLE-4*, note that when these equations are set to zero and rearranged, the MLE parameters are obtained.

$
  (partial l)/(partial mu) = - 1/sigma^2 sum^n_(i=1)(mu - t_i)^2 quad -> quad accent(mu, hat) = 1/n sum^n_(i=1) t_i
  \
  (partial l)/(partial sigma) = -n/sigma + 1/sigma^3 sum^n_(i=1)(t_i - mu)^2 quad -> quad accent(sigma, hat) = sqrt(1/n sum^n_(i=1) (t_i - mu)^2)
$<3-guassian-MLE-4>

Note that the MLE params for a Guassian distribution are the mean and standard deviation.

=== MLE for an Exponential Distribution

Recall that the PDF for a exponential distribution is defined in *@2-exponential-dist-pdf-cdf*. Currently $lambda$ is unknown for a set of data, MLE can find $accent(lambda, hat)$. Taking logs of the PDF, for a given observation $t_i$, the log likelihood is given in *@3-exp-MLE-1*.

$
  ln(f(t_i)) = ln(lambda exp(-lambda t_i)) = ln(lambda) - t_i
$<3-exp-MLE-1>

Taking the product of the probability of all of the events yields *@3-exp-MLE-2*. This equation is then differentiated with respect to $lambda$, set to zero and rearranged for the MLE parameter.

$
  l(lambda) = n exp(lambda) - lambda sum^n_(i=1) t_i
  \
  (partial l)/(partial lambda) = n/lambda - sum^n_(i=1) t_i quad -> quad accent(lambda, hat) = n/(sum^n_(i=1) t_i)
$<3-exp-MLE-2>

Note that $accent(lambda, hat)$ is the $1"/"mu$ and is also the reaction that 1/$lambda$ is the mean time to failure (MTTF).

== Parameter Confidence

Now that the MLE parameters have been defined, the confidence in the value of these parameters must also be quantified. It is clear that *as the data set size increases*, the *confidence in the calculated MLE parameter should increase*. To quantify parameter confidence, a Fisher information matrix is used, shown in *@3-fisher-information-matrix*.

$
  "The " I_(i j) "component" -> I_(i j) = E[-(partial^2l(t:theta))/(partial theta_i partial theta_j)]
$<3-fisher-information-matrix>

Calculating and constructing the Fisher information  matrix and then inverting it yields the *covariance* matrix which allows for the calculation of the variance of a specific MLE parameter and the covariance between two MLE parameters, this is shown in

$
  I^(-1) = mat(
    "Var"(theta_1), "Cov"(theta_1, theta_2), ..., "Cov"(theta_1, theta_k);
    "Cov"(theta_2, theta_1), "Var"(theta_2), ..., "Cov"(theta_2, theta_k);
    dots.v, dots.v, dots.down, dots.v;
    "Cov"(theta_k, theta_1), "Cov"(theta_k, theta_2), ..., "Var"(theta_k);
  )_(k times k)
$<3-covariance-matrix>

=== Parameter Confidence for Guassian Distribution

To form the Fisher information matrix for a Guassian distribution, the second partial derivative as well as the mixed partial derivative must be calculated, this is shown in *@3-param-conf-gaussian-1*. Note that $E$ in the Fisher matrix *represents the expected value*, allowing the moments of a normal to be applied

$
  "Moments of a Guassian Dist:" cases(E[t_i - mu] = 0, E[mu- t_i] = 0, E[(t_i - mu)^2] = sigma^2, E[(mu - t_i)^2] = -sigma^2)
  \
  E[-(partial^2l)/(partial mu^2)] = E[-partial/(partial mu)( - 1/sigma^2 sum^n_(i=1)(mu - t_i))] = bold(n/(accent(sigma, hat)))
  \
  E[-(partial^2l)/(partial sigma^2)] = E[-partial/(partial sigma)(-n/sigma + 1/sigma^3 sum^n_(i=1)(t_i - mu)^2)] = E[-n/sigma^2 + (3)/sigma^4 sum^n_(i=1)(t_i - mu)^2]
  \
  = -n/sigma^2 + (3)/sigma^4 (sigma^2) = bold((2 n)/accent(sigma, hat)^2)
  \
  E[-(partial^2l)/(partial mu partial sigma)] = [-partial/(partial sigma)(partial/(partial mu))] = E[2 /sigma^3 sum^n_(i=1)(mu - t_i)] = 0
$<3-param-conf-gaussian-1>

Now the Fisher information matrix can be constructed, noting that both of the covariance terms are zero, this is shown in *@3-param-conf-gaussian-2* alongside the inverted matrix.

$
  I_(2 times 2) = mat(n/sigma^2, 0; 0, (2n)/sigma^2)_(2 times 2) quad -> quad I_(2 times 2)^(-1) = mat(sigma^2/n, 0; 0, sigma^2/(2n))_(2 times 2)
  \
  therefore "Var"(accent(mu, hat)) = accent(sigma, hat)^2 / n quad "Var"(accent(sigma, hat)) = accent(sigma, hat)^2 / (2n)
$<3-param-conf-gaussian-2>

This means that each of the MLE parameters themselves have a normal distribution associated with themselves where for $accent(mu, hat): mu = accent(mu, hat), sigma = sqrt("Var"(accent(mu, hat)))$  and for $accent(sigma, hat): mu = accent(sigma, hat), sigma = sqrt("Var"(accent(sigma, hat)))$. The confidence in a given MLE parameter is therefore written in the form show in *@3-param-conf*.

$
  P(theta_l lt.eq accent(theta, hat), lt.eq theta_u) = gamma
$<3-param-conf>

Where $theta_l " & " theta_u$ are the upper and lower bounds of the MLE parameter and $gamma$ is the confidence level. For example if $gamma = 0.95$, then 95% of the time, $theta$ is within the upper and lower bounds. The upper and lower bounds are calculated using the formula shown in.

$
  theta_l = accent(theta, hat) - Z_(alpha"/"2) sqrt("Var"(accent(theta, hat)))
  \
  theta_u = accent(theta, hat) + Z_(alpha"/"2) sqrt("Var"(accent(theta, hat)))
$<3-upper-lower-bounds>

Where $alpha = 1 - gamma$ and $Z$ is the the standard normal statistic (negative of the inverse CDF of a normal distribution with mean of 0 and a standard deviation of 1 for the probability $alpha"/"2$).

#pagebreak()
