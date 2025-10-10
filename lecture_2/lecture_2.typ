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
