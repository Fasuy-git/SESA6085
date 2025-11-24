#import "../template.typ": *

= Lecture 8

== Balanced m-out-of-n Systems

A balanced system is where if one branch fails, another branch must be turned off to allow for the system to still function. An example would be a four thruster lander, if one thruster fails, the opposite thruster must then turn off for stability. The reliability of such a system is given in *@8-balanced-m-n*.

$
  R_(s y s) = 1 - P(Y = 0) = 1 - product_(i=1)^n P(X^(i) = 0)
$<8-balanced-m-n>

The system reliability of a balanced m-out-of-n system will always be less than a regular m-out-of-n system as one branch needs to be turned off, this is shown in *@8-balanced-m-n-graph*.

#figure(
  image("images/8-balanced-m-out-of-n.png", width: 50%),
  caption: [System reliability of a standard m-out-of-n system vs a balanced m-out-of-n system.],
  supplement: [Figure],
  kind: figure,
)<8-balanced-m-n-graph>

== Active Vs Inactive Redundancy

In the previous lecture, the redundant system covered was an active one where both sections of the system are active and sharing the load. There is also the case of an inactive redundant system where one section only activates if the other fails. The RBD for both of these systems is shown in *@8-active-inactive-rbd*.

#figure(
  image("images/8-active-inactive.png", width: 60%),
  caption: [RBD for an active redundant system [Left] and an inactive redundant system [Right].],
  supplement: [Figure],
  kind: figure,
)<8-active-inactive-rbd>

=== Types of Standby System

For inactive redundant systems, there are a few different types of standby systems, depending on how the failure rate of the back up component differs from the original component, these are:

- *Hot* standby:
  - Standby components have the same failure rate as the primary component.
  - $lambda_("hot") = lambda$
- *Warm* standby:
  - Standby components have a smaller failure rate than the primary.
  - $lambda_("warm") < lambda$
- *Cold* standby:
  - Standby components don't fail in standby and have a zero failure rate until activated
  - $lambda_("cold") = 0$

=== Reliability of a Standby Redundant System

Consider a two component standby redundant system, shown in *@8-active-inactive-rbd*. The reliability for this system is given by *@8-active-reliability*.

$
  R_(s y s) = R_A (t) + integral_(tau = 0)^t f_A (tau) R_B (t-tau)d tau
$<8-active-reliability>

Where $tau$ is the failure time of component A. What *@8-active-reliability* does is effectively shift the PDF for component B along by $tau$, this is graphically shown in *@8-active-reliability-graph*.

#figure(
  image("images/8-active-reliability-graph.png", width: 60%),
  caption: [Graph illustrating the effect of active redundancy.],
  supplement: [Figure],
  kind: figure,
)<8-active-reliability-graph>

If it is assumed that both of the components have an exponential distribution, then a closed form solution for the system reliability can be determined, this is shown in *@8-active-dual*. Note that the equation can be further simplified if the components are assumed to be identical $lambda_A = lambda_B = lambda$.

$
  R_(s y s) = exp(-lambda_A t) + (lambda_A exp(-lambda_B t))/(lambda_A - lambda_B) (1-exp(-(lambda_A + lambda_B)t))
  \
  R_(s y s) = (1 + lambda t)exp(- lambda t)
$<8-active-dual>

For multiple inactive redundant branches, all with the same component, assuming perfect switching and all having an exponential PDF, the general expression for the reliability is given by *@8-active-general*.

$
  R_(s y s) = exp(- lambda t)[1 + lambda t + (lambda t)^2/(2!) + ... + (lambda t)^(n - 1)/((n - 1)!)]
$<8-active-general>

Typically, inactive redundant systems have a higher reliability than active ones however, these equations assuming perfect switching which may not be necessarily true. A graph depicting the comparative reliability of an active and inactive system is shown in *@8-active-vs-inactive-plot*.

#figure(
  image("images/8-active-vs-inactive-plot.png", width: 60%),
  caption: [Graph illustrating reliability gain of an inactive dual redundant system over an active one.],
  supplement: [Figure],
  kind: figure,
)<8-active-vs-inactive-plot>

== Multistate Components

So far, all components have been modelled as existing in one of two states, working or not working. In reality components can have multiple states of operation or failure, and these are called multistate components. Consider a simple diode, it can exits in one of three states:

- Component operates normally.
- Components fails due to short circuit (zero resistance in both directions).
- Component fails due to open circuit (infinite resistance in both directions).

For a set of diodes in series or parallel, the circuit fails if *one of the diodes short circuits* or if *all of the diodes are in an open circuit*. The expression for the reliability of this system in series or parallel is shown in *@8-multistate-reliability*.

$
  R_(s y s)_"Series" = product_(i = 1)^n (1 - q_(o i)) - product_(i = 1)^n q_(s i) quad quad
  R_(s y s)_"Parallel" = product_(i = 1)^n (1 - q_(s i)) - product_(i = 1)^n q_(o i)
$<8-multistate-reliability>

Where $q_(o)$ is the probability of failure for an open circuit and $q_(s)$ is the probability of failure for a short circuit. Note that for more complex systems, a monte-carlo simulation is often used to calculate a numerical solution to the system reliability.

#pagebreak()
