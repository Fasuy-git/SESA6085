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

Also known as the the *Normal Distribution* is the most commonly used probability distribution function. The PDF  is shown in *@2-gaussian-dist-pdf* (*Note no CDF exists*).

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

===
