#import "../template.typ": *

= Lecture 2

== Frequency Histograms

A *frequency histogram* is a type of bar chart which is used to represent the distribution of data, on the *x axis* are bins of data and the *y axis* represents the frequency that occurs within that bin, an example of a frequency h istogram is shown in *@2-freq-hist*.

#figure(
  image("images/2-freq-hist.png", width: 70%),
  caption: [Example of a frequency histogram.],
  supplement: [Figure],
  kind: figure,
) <2-freq-hist>

As we increase the number os samples taken, effectively decreasing the width of each bin, then the data will approach a smooth curve.

== Definition of a PDF

As the frequency histogram bin width approaches an infinitesimal width, the histogram approaches a continuous curve known as the *Probability Density Function* (PDF). A PDF has one criteria in that the *area under the curve must be equal to 1*, the mathematical definition of a PDF is shown in *@2-pdf-definition*.

$
  integral_(-infinity)^(infinity) f(t)d t =1
$<2-pdf-definition>

PDFs can be used to find the probability that a certain value $t$ is that value. In terms of reliability engineering its the *probability that a component fails* at the time $t$.

== Definition of a CDF

A *Cumulative Distribution Function* (CDF) yields the probability that a given value will fall between the limits of $-infinity$ and $t_1$, its mathematical definition is shown in *@2-cdf-definition*.

$
  F(t) = integral_(-infinity)^(t_1)f(t)d t
$<2-cdf-definition>


== Reliability Function

Reliability is the probability that a component will survive from a time $t = 0$ to a time $t = t_1$ and its mathematical definition is shown in *@2-reliability-function*, with a graph depicting the reliability function shown in *@2-reliability-graph*.

$
  R(t) = 1 - F(t) = 1 - integral_(- infinity)^(t_1)f(t)d x equiv integral_(x)^(infinity)f(t)d x
$<2-reliability-function>

#figure(
  image("images/2-reliability-graph.png", width: 70%),
  caption: [Graph of the reliability function and CDF on a PDF.],
  supplement: [Figure],
  kind: figure,
)<2-reliability-graph>

== Hazard Function

Also known as the hazard rate the *hazard function* gives the probability of failure at a time $t$, given that there has not already been a failure. The mathematical definition for the hazard function is shown in *@2-hazard-function*.

$
  h(t) = f(t)/R(t) = f(t)/(1-R(t))
$<2-hazard-function>

The hazard function can be though of as a measure of the probability of eminent failure at $t$ or the proneness of failure after $t$. Note that there does exist a cumulative hazard function which is not assessed as well as methods to rearrange between all of these functions.

== Continuous Distribution

A continuous PDF is a smooth curve representing how the probability varies with an area under the curve being equal to one. Effectively there is an infinite number of probability distributions as long as they satisfy the conditions set above, some of the most common are shown below.

=== Uniform Distribution Function

The most simplest distribution function assumes, that the distribution is zero and then one fixed value for a set time period. The PDF and CDF are defined in *@2-uniform-dist-pdf-cdf*.

#set math.cases(reverse: false) //Was set to reversed in lect 1
$
  f(t) = cases(
    1/(b-a) #h(0.7cm) & t in [a,b],
    0 & "Otherwise"
  ) \
  F(t) = cases(
    0 #h(1cm) & t < a,
    (t-a)/(b-a) & t in [a,b],
    1 & t> b
  )
$<2-uniform-dist-pdf-cdf>

Where:
- *$a$*: Start of non-zero probability.
- *$b$*: End of non-zero probability.

The PDF and CDF for a uniform probability distribution are shown in graphically *@2-uniform-pdf-cdf-plots*.

#figure(
  grid(
    columns: 2,
    [#image("images/2-uniform-pdf.png")], [#image("images/2-uniform-cdf.png")],
  ),
  caption: [Plots of uniform PDFs [left] and plots of uniform CDFs [right]. ],
  supplement: [Figure],
  kind: figure,
)<2-uniform-pdf-cdf-plots>

=== Triangular Distribution Functions

Triangular distribution functions are slightly more complex than the aforementioned uniform distribution functions. Their PDF and CDF are shown in *@2-triangular-dist-pdf-cdf*.

$
  f(t) = cases(
    (2(t-a))/((c-a)(b-a)) #h(1cm) & a lt.eq t lt.eq b,
    (2(c-t))/((c-a)(c-b)) & b lt.eq t lt.eq c,
    0 & t < a "," t > c
  ) \
  F(t) = cases(
    0 & t < a,
    ((t - a)^2) / ((b - a) * (c - a)) & a lt.eq t lt.eq b,
    1 - ((c - t)^2) / ((c - a) * (c - b)) & b lt.eq t lt.eq c,
    1 & t > c
  )
$<2-triangular-dist-pdf-cdf>

Where:
- *$a$*: Start of non-zero probability.
- *$b$*: Probability peak.
- *$c$*: End of non-zero probability.

The PDF and CDF for a triangular probability distribution are shown graphically in *@2-triangular-pdf-cdf-plots*.

#figure(
  grid(
    columns: 2,
    [#image("images/2-triangular-pdf.png")], [#image("images/2-triangular-cdf.png")],
  ),
  caption: [Plots of triangular PDFs [left] and plots of triangular CDFs [right]. ],
  supplement: [Figure],
  kind: figure,
)<2-triangular-pdf-cdf-plots>

=== Gaussian Distribution

Also known as the the *Normal Distribution* is the most commonly used probability distribution function. The PDF  is shown in *@2-gaussian-dist-pdf* (*Note no close form CDF exists*).

$
  f(t) = 1/(sigma (2pi)^(1/2)) exp(-1/2((t-mu)/sigma)^2)
$<2-gaussian-dist-pdf>

Where:
- *$mu$*: Mean (Location parameter).
- *$sigma$*: Standard Deviation (Scaling parameter).

The PDF and CDF for a Gaussian probability distribution are shown graphically in *@2-gaussian-pdf-cdf-plots*.

#figure(
  grid(
    columns: 2,
    [#image("images/2-gaussian-pdf.png")], [#image("images/2-gaussian-cdf.png")],
  ),
  caption: [Plots of Gaussian PDFs [left] and plots of Gaussian CDFs [right]. ],
  supplement: [Figure],
  kind: figure,
)<2-gaussian-pdf-cdf-plots>

The Gaussian distribution whilst being *symmetrical* also exhibits these key properties:

- *68.26%* of data is within 1 standard deviation of the mean*($sigma$)*.
- *95.44%* of data is within 2 standard deviations of the mean *($2 sigma$)*.
- *99.74%* of data is within 3 standard deviations of the mean *($3 sigma$)*.

=== Log Normal Distribution

A more versatile version of the Gaussian distribution that is better suited at modelling reliability data. The PDf is shown in *@2-log-normal-dist-pdf* (*Note no CDF exists*).

$
  f(t) = cases(
    1/(t sigma (2pi)^(1/2)) exp(-1/2((t-mu)/sigma)^2) #h(1cm) & t gt.eq 0,
    0 & t < 0
  )
$<2-log-normal-dist-pdf>

Where:
- *$mu$*: Mean (Location parameter).
- *$sigma$*: Standard Deviation (Scaling parameter).

The PDF and CDF for a log normal probability distribution are shown graphically in *@2-log-normal-pdf-cdf-plots*.

#figure(
  grid(
    columns: 2,
    [#image("images/2-log-normal-pdf.png")], [#image("images/2-log-normal-cdf.png")],
  ),
  caption: [Plots of log normal PDFs [left] and plots of log normal CDFs [right]. ],
  supplement: [Figure],
  kind: figure,
)<2-log-normal-pdf-cdf-plots>

=== Exponential Distribution

These distributions feature a *constant hazard rate* which is useful to model some processes. The PDf and CDF are shown mathematically in *@2-exponential-dist-pdf-cdf*.

$
  f(t) = cases(
    lambda exp(-lambda t) #h(1cm) & t gt.eq 0,
    0 & t < 0
  ) \
  F(t) = cases(
    0 #h(2.7cm) && t < 0,
    1 - exp(-lambda t) && t gt.eq 0
  )
$<2-exponential-dist-pdf-cdf>

Where:
- *$lambda$*: Scaling parameter (Also is the constant hazard rate)

It is important to note that 1/$lambda$ is the mean time to failure (MTTF). The PDF and CDF for an exponential distribution are shown graphically in *@2-exponential-pdf-cdf-plots*.

#figure(
  grid(
    columns: 2,
    [#image("images/2-exponential-pdf.png")], [#image("images/2-exponential-cdf.png")],
  ),
  caption: [Plots of exponential PDFs [left] and plots of exponential CDFs [right]. ],
  supplement: [Figure],
  kind: figure,
)<2-exponential-pdf-cdf-plots>

=== Weibull Distribution

Is one of the most extensible and useful distributions out there, and can be used to model a lot of different distributions. The PDF, CDF and hazard rate are shown in *@2-weibull-dist-pdf-cdf-hazard*.

$
  f(t) = cases(
    beta / eta^beta t^(beta-1) exp(-(t/eta)^beta) #h(1cm) & t gt.eq 0,
    0 & t < 0
  ) \
  F(t) = 1 - exp(-(t/eta)^beta) #h(1cm)
  h(t) = beta / eta^beta t^(beta-1)
$<2-weibull-dist-pdf-cdf-hazard>

Where:

- *$beta$*: Shape parameter
- *$eta$*: Scaling parameter (characteristic life)

$eta$ is also the point at which 63.2% of the population have failed. Weibull distributions are so versatile as the $beta$ parameter changes the shape into different distributions:

#grid(
  columns: 2,
  row-gutter: 1em,
  [- $beta = 1$: Constant hazard function (exponential dist)], [- $beta > 1$: Increasing hazard rate],
  [- $beta < 1$: Decreasing hazard rate], [- $beta = 3.5$: Normal distribution],
)

The PDF and CDF for various Weibull distributions are shown graphically in *@2-weibull-pdf-cdf-plots*.

#figure(
  grid(
    columns: 2,
    [#image("images/2-weibull-pdf.png")], [#image("images/2-weibull-cdf.png")],
  ),
  caption: [Plots of Weibull PDFs [left] and plots of Weibull CDFs [right] for various $beta s$. ],
  supplement: [Figure],
  kind: figure,
)<2-weibull-pdf-cdf-plots>


=== Three Parameter Weibull Distribution

Introduces a new parameter $gamma$ which is used to switch on the probability, its useful if the failures only start after a set time. The PDF, CDF and hazard rate are shown in *@2-three-weibull-dist-pdf-cdf-hazard*.

$
  f(t) = cases(
    beta / eta^beta (t-gamma)^(beta-1) exp(-((t-gamma)/eta)^beta) #h(1cm) & t gt.eq 0,
    0 & t < 0
  ) \
  F(t) = 1 - exp(-((t-gamma)/eta)^beta) #h(1cm)
  h(t) = beta / eta^beta (t-gamma)^(beta-1)
$<2-three-weibull-dist-pdf-cdf-hazard>

Where:

- *$beta$*: Shape parameter
- *$eta$*: Scaling parameter (characteristic life)
- *$gamma$*: Location parameter (failure free time)

=== Other Distribution Functions (Non-Examinable)

Like was stated previously, there are an infin ite number of PDFs as the only criteria is for the area under the curve to sum to 1. Some other common distributions and their purposes are mentioned below:

- *Rayleigh Distribution*: Similar to exponential but with a linearly increasing hazard rate.
- *Gamma Distribution*: Similar to Weibull in that it can model a wide number of distributions by varying the parameters.
- *Beta Distribution*: A complex distribution which uses multiple gamma distributions to ensure that the life is limited to a set interval.
- *Inverse Gamma Distribution*
- *Log-logistic Distribution*
- *Birnbaum-Saunders Distribution*

== Discrete Distributions

Whereas continuous distributions can model the probability over time, discrete distributions model the probability per an $n$ number of events, some common discrete distributions are shown below.

=== Binomial Distribution

Used where the outcome of each discrete event is either pass or fail, the PDF for a binomial distribution function is defined by *@2-binomial-dist-pdf*.

#set math.vec(delim: "(")

$
  f(x) = vec(n, x)p^x q^(n-x) \
  n!/(x!(n-x)!) equiv vec(n, x)
$<2-binomial-dist-pdf>

Where:

- *$x$*: The number of passes
- *$n$*: Total number of trails
- *$p$*: Probability of success
- *$q$*: Probability of failure
- *$vec(n, x)$*: Binomial coefficient

#set math.vec(delim: "[")

Note that the *binomial coefficient* is a parameter that will appear often and is read as `"n choose x"`. Usefully, it also represents the *number of possible combinations of $n$ from $x$*.

=== Other Discrete Distributions

Some other commonly used discrete distributions are:

- *Poisson's Distribution*: Represents an event occurring at a constant rate and can approximate the binomial distribution.
- *Hypergeometric Distribution* Models the probability if there are no replacements.

#pagebreak()
