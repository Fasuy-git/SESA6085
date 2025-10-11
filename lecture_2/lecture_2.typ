#import "../template.typ": *

= Lecture 2

== Frequency Histograms

A *frequency histogram* is a type of bar chart which is used to represent the distribution of data, on the *x axis* are bins of data and the *y axis* represents the frequency that occurs within that bin, an example of a frequency histogram is shown in *@2-freq-hist*.

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
