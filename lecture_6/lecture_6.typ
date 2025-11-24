#import "../template.typ": *

= Lecture 6

== Deterministic Vs Stochastic Simulation

A *deterministic simulation* is a simulation where *there is no randomness* and the same input will always yield the same output. A *stochastic simulation* however, is a simulation where there *is an element of randomness* based on some probability. Consider the following stochastic and deterministic simulation parameters for an aerofoil:

#grid(
  columns: (auto, auto),
  row-gutter: 1cm,
  column-gutter: 1cm,
  [
    *Deterministic Simulation Parameters*
    - $R_e = 6 times 10^6$
    - $alpha = 2 degree$
    - $M = 0.2$
    *Output Parameter*
    - $C_D = 7.85 times 10^(-3)$

    Performing a stochastic simulation of the aerofoil allows for design in a much more robust manner, as the aerofoil can be optimized for the mean drag it will face in use or it can be optimized for the peak drag. Alternately teh design can be optimized to reduce the variation of $C_d$ over the range of variable values.
  ],
  [
    *Stochastic Simulation Parameters*
    - $5.5 times 10^6 < R_e < 6.5 times 10^6$
    - $1.5 degree < alpha < 2.5 degree$
    - $0.15 < M < 0.25$
    *Output Parameter*
    #figure(
      image("images/6-stochastic.png", width: 70%),
      caption: [Output of a stochastic aerofoil simulation.],
      supplement: [Figure],
      kind: figure,
    )<6-stochastic>
  ],
)


== Distributed Random Numbers

CDFs can be used to map a uniformly distributed set of random numbers into a distributed set according to the associated PDF for the CDF. This is possible due to the CDF linking toi the original PDF as well as the CDF having no repeating values from 0 to 1. In order to generate a set of distributed random numbers, the uniform set is fed into the inverse of the CDF, this is shown for a normal and exponential distribution in *@6-normal-random* and *@6-exp-random*.

#grid(
  columns: (auto, auto),
  row-gutter: 1cm,
  column-gutter: 1cm,
  [#figure(
      image("images/6-normal-random.png", width: 70%),
      caption: [Normally distributed random numbers.],
      supplement: [Figure],
      kind: figure,
    )<6-normal-random>
    $
      t = mu + sigma sqrt(2) "erf"^(-1) (2F(t) - 1)
    $],
  [#figure(
      image("images/6-exponential-random.png", width: 70%),
      caption: [Exponentially distributed random numbers.],
      supplement: [Figure],
      kind: figure,
    )<6-exp-random>
    $
      t = (ln(1-F(t)))/(-lambda)
    $],
)

== Monte Carlo Simulation

A monte carlo simulation is a method of stochastic simulation where thousands of trials are ran with input values sourced from distributed random numbers. Each input variable is randomly distributed via an inverse CDF, each CDF being carefully chosen to mimic the real world conditions of the structure. An example monte carlo simulation is ran on the aerofoil example shown previously and the resulting histogram for the $C_d$ is shown in *@6-aerofoil-monte-carlo*.

#grid(
  columns: 2,
  column-gutter: 1cm,
  row-gutter: 1cm,
  [\ \ \ \
    - $R_e ~ N(mu : 6 times 10^6, sigma: 0.25 times 10^6)$
    - $alpha ~ N(mu : 2 degree, sigma: 0.25 degree)$
    - $M ~ N(mu : 0.2, sigma:0.025)$
  ],
  [
    #figure(
      image("images/6-monte-carlo.png", width: 70%),
      caption: [Monte Carlo simulation for an aerofoil.],
      supplement: [Figure],
      kind: figure,
    )<6-aerofoil-monte-carlo>
  ],
)

== Monte Carlo Convergence

The number of trails required for a monte carlo simulation to converge is case specific and there is no set equation to calculate it. The number of trails depends on:

- The *complexity of the underlying simulation*, a higher complexity will need more runs.
- The *required accuracy,* a more accurate output will require more runs.
- The *variance in the input* or output, a large input variance will mean a high number of runs.
- The *number of inputs*, more inputs require more runs.

As a monte carlo analysis is a statistical measure, the error in the distribution mean can be found by using *@6-convergence-equation*.

$
  "Er"(mu) = (Z_(alpha"/"2) sigma)/sqrt(N)
$<6-convergence-equation>

Note that in this equation, $sigma$ is initially unknown. Critically, this equation also shows that for a *one order of magnitude improvement in accuracy* we need a *two order of magnitude increase in the number of runs*.

== Pseudo-random Vs Quasi-random Numbers

Normal monte carlo simulations make used of *pseudo-random* numbers. Pseudo-random numbers attempt to mimic real world randomness and are generated via a random number generator. One issue with pseudo-random numbers however, is that they are not very uniform, they tend to cluster and leave gaps. For better convergence of the monte carlo simulation, quasi-random numbers are used, which have a focus on uniformity rather than randomness, an example of pseudo-random and quasi-random numbers is shown in *@6-random-numbers*.

#figure(
  image("images/6-random-numbers.png", width: 90%),
  caption: [Pseudo-random vs Quasi-random numbers.],
  supplement: [Figure],
  kind: figure,
)<6-random-numbers>

== Quasi-Monte Carlo Analysis

Quasi-Monte carlo analysis makes use of quasi-random numbers instead of pseudo-random numbers, allowing for better converge than a normal monte-carlo analysis ($O(1"/"sqrt(N)) "vs" O(1"/"N)$). An image showing teh converge rates of a monte-carlo and quasi-monte carlo analysis is shown in *@6-quasi-monte-carlo*.

#figure(
  image("images/6-quasi-monte-carlo.png", width: 70%),
  caption: [Convergence of quasi and normal monte carlo analyses],
  supplement: [Figure],
  kind: figure,
)<6-quasi-monte-carlo>

#pagebreak()
