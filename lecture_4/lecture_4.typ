#import "../template.typ": *

= Lecture 4

== Multivariate Models

In many scenarios, more than one factor will effect the failure and therefore the reliability and most of the time, these factors are not independent from one another. For univariate data, the CDF can be used to calculate the probability in the manner shown in *@4-univariate-probability*.

$
  P(a lt x lt.eq b) = F(b) - F(a)
$<4-univariate-probability>

For multivariate models, multiple occurrence are observed at the same time. The probability two variables fall between two bounds is shown in *@4-bivariate-probability*.

$
  P(a_1 lt x lt b_1, a_2 lt y lt b_2) = F(b_1,b_2) - F(a_1,b_2) - F(b_1,a_2) + F(a_1,a_2)
$<4-bivariate-probability>

=== CDF of a Multivariate Model

In a similar method to univariate model, the CDF of a given multivariate PDF is the integral between minus and positive infinity of that PDF with respect to each variable, this is mathematically written in *@4-multivariate-cdf*

$
  f(x_1,x_2,...,x_n)
  \
  F(a_1,a_2,...,a_n) = integral_(-infinity)^(a_n) ... integral_(-infinity)^(a_2)integral_(-infinity)^(a_1) f(x_1,x_2,...,x_n) d x_1 d x_2 ... d x_n
  \
  integral_(-infinity)^(infinity)integral_(-infinity)^(infinity) ... integral_(-infinity)^(infinity) f(x_1,x_2,...,x_n) d x_1 d x_2 ... d x_n = 1
$<4-multivariate-cdf>

== Multivariate Normal Distribution

A multivariate normal distribution has a different vectorized form from the equation shown in *@2-gaussian-dist-pdf*, the multivariate form is shown in *@4-multivariate-guassian-pdf*.

$
  f(bold(x)) = 1/sqrt((2 pi)^p |bold(Sigma)|) exp(-1/2 (bold(x) - bold(mu))^T bold(Sigma)^(-1)(bold(x)-bold(mu)))
$<4-multivariate-guassian-pdf>

Where:
- *$bold(x)$*: Vector of variables.
- *$p$*: Number of variables
- *$bold(Sigma)$*: Covariance matrix between variables
- *$bold(mu)$*: Vector of means for each variable

Note that when *@4-multivariate-guassian-pdf* has $p = 1$, the equation reduces to the univariate case. Some example plots of bivariate normal distributions are shown in *@4-multi-normal*.

==== Fitting Data to Multivariate Normal Distributions

The MLE process can be applied to obtain the MLE parameters for $bold(mu)$ and $bold(Sigma)$, these are both shown in *@4-mle-multi-gaussian* note that $accent(bold(Sigma), hat)_(i j)$ is the same as the sample covariance matrix.

$
  accent(bold(mu), hat) = [1/n sum^n_(i=1) x_(1_i) , 1/n sum^n_(i=1) x_(2_i), ..., 1/n sum^n_(i=1) x_(k_i) ]
  quad
  accent(bold(Sigma), hat)_(i j) = (bold(x_i) - mu_i)^T (bold(x_j) - mu_j) "/"n
$<4-mle-multi-gaussian>

#figure(
  image("images/4-multi-normal.png"),
  caption: [Various bivariate normal distributions with variations in the $bold(mu)$ vector and $bold(Sigma)$ matrix],
  supplement: [Figure],
  kind: figure,
)<4-multi-normal>


== Joint Distribution Functions

Joint distributions can be created for *two variables that are independent from one another* given that they satisfy a few conditions, these conditions are shown in *@4-joint-dist*

$
  F(-infinity, -infinity, ..., -infinity) = 0
  quad quad F(infinity, infinity,..., infinity) = 0
  \ quad quad "If" a < b "and" c < d "then" F(a,c) < F(b,d)
$<4-joint-dist>

If the conditions in *@4-joint-dist* are satisfied, then the $n$ number of joinable distributions, the PDF and CDF can be written in the form shown in *@4-bivariate-CDF-PDF*.

$
  F(x_1,x_2, ..., x_n) = product_(i=1)^(n) F_i (x)
  \
  f(x_1,x_2, ..., x_n) = (partial^n f)/(partial x_1 partial x_2 ... partial x_nothing)
$<4-bivariate-CDF-PDF>

=== Bivariate Exponential Distribution

Assuming that two distributions are statistically independent from one another, they can be joined in the manner defined in the previous section. The CDF for the bivariate exponential distribution is shown in *@4-bivariate-exp-CDF*.

$
  F(x) = 1 - exp(- lambda x)
  \
  F(x_1,x_2) = F_1(x)F_2(x) = cases(
    (1-exp(-lambda_1 x_1))(1-exp(-lambda_2 x_2)) quad x_(1,2) gt.eq 0,
    0 quad quad quad quad quad quad quad quad quad quad quad quad quad quad quad quad x_(1,2) lt 0
  )
$<4-bivariate-exp-CDF>

The resulting PDF can be calculating by applying *@4-bivariate-CDF-PDF* to *@4-bivariate-exp-CDF*, this yields *@4-bivariate-exp-PDF*.

$
  f(x_1, x_2) = (partial^2 F)/(partial x_1 partial x_2)
  \
  f(x_1, x_2) = cases(
    lambda_1 lambda_2 exp(-lambda_1 x_1 - lambda_2 x_2) quad x_(1,2) gt.eq 0,
    0 quad quad quad quad quad quad quad quad quad quad quad " "x_(1,2) lt 0
  )
$<4-bivariate-exp-PDF>

An example bivariate exponential distribution with $lambda_1 = 5, lambda_2 = 2.5$ is shown in *@4-bi-exp*

#figure(
  image("images/4-bi-exp.png"),
  caption: [A bivariate exponential distributions PDF [Left] and CDF [Right]],
  supplement: [Figure],
  kind: figure,
)<4-bi-exp>

#pagebreak()
