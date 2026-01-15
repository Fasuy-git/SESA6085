#import "../template.typ": *

= Lecture 13

== Design Optimization

Often there exist many competing functions that either need to be maximized or minimized. Design optimization is a process whereby trade-offs are made to create a design solution that best satisfies overall performance requirements under given constraints. Typically this is an automated iterative process, growing closer to an optimized solution. Consider the cost function shown in *@13-example-cost-function*.


#figure(
  image("images/13-example-cost.png", width: 50%),
  caption: [Example cost function.],
  supplement: [Figure],
  kind: figure,
)<13-example-cost-function>

The most optimal solution for this function is *`A`*, however if there is an uncertainty in the value of *`x`*, then the most robust solution is *`B`*, as any variation in *`x`* yields less of a change in the cost function.

== Robust Design Optimization

Normal design optimization does have a ew issues as was highlighted by *@13-example-cost-function*., some other issues are:

- Typically the function *`f(x)`* represents an approximation of the real world.
- Normal optimization is sensitive to small changes and doesn't allow for any fluctuations.
- On top of this the actual manufacturing of an optimum design may be difficult resulting in errors.

Robust design optimization is similar to normal design optimization except the *solutions generated will be the most robust* not necessarily the most optimal. Design uncertainties can come form many places, some include:

- Changing environmental & operating conditions.
- Production tolerances.
- Uncertainties in system outputs (modelling uncertainties).
- Feasibility uncertainties concerning how well constraints are met.

Robust design optimization methods construct a robust form of *`f(x)`* which is then optimized. Some methods that do this are:

- Robust regularization.
- Expectancy measure

#pagebreak()

== Aleatory and Epistemic Uncertainties

Aleatory (objective) and epistemic (subjective) uncertainties are two different categories of uncertainties. Attributes of these two family of uncertainties are shown below:

- *Aleatory:*
  - Uncertainties due to physical nature that can be modelled using a PDF.
  - Are stochastic and cannot be removed.
- *Epistemic:*
  - Designer has lack of knowledge of this type of uncertainty, cannot be modelled using a PDF.
  - Typically generated from numerical methods or physical simulations.

Both aleatory and epistemic uncertainties can be modelled using a *deterministic method* (e.g., tolerance of +/- 2mm). Only aleatory uncertainties can be modelled using *probabilistic methods* by using a PDF.

== Robust Regularization

A nominal optimization problem would be $min(f(x))$. Robust regularization first applies a tolerance $epsilon$ to the function, this will be added in a way that always maximizes f(x). Then the resulting function is minimized, this equation is shown in *@13-robust-reg*.

$
  x_r = min(f_r (x)) = min(max(f(x plus.minus epsilon)))
$<13-robust-reg>

An example of this method is shown in *@13-robust-reg-graph-example* for a piecewise function shown in *@13-robust-reg-eq-example*. Note that in this example, it is possible to derive an expression for $f_r$ however this is not always possible.

#grid(
  columns: 2,
  column-gutter: 0cm,
  [ \ $
    f(x) = cases(-x quad quad "If" x < 0, sqrt(x) quad quad "If" x gt.eq 0) \
    f_r (x) = cases(-x + epsilon quad quad "If" x < 0, sqrt(x + epsilon) quad quad "If" x gt.eq 0)
  $<13-robust-reg-eq-example>],
  [
    #figure(
      image("images/13-robust-reg.png", width: 100%),
      caption: [Plot of $f(x)$ and $f_r (x)$ from *@13-robust-reg-eq-example*.],
      supplement: [Figure],
      kind: figure,
    )<13-robust-reg-graph-example>
  ],
)

== Expectancy Measures of Robustness

Robust regularization has some problems in that the robust function cannot always be found and the selection of $epsilon$ is up to guessing (too large $->$ conservative, too small $->$ fragile). Instead expectancy based methods use a PDF to act as the input, randomizing f(x) the two expectancy measure based methods are:

- Aggregation.
- Randomized approaches.

=== Aggregation

This methods uses integrals to create measures of robustness. The integral measures of robustness, $F_1(x)$ and $F_2(x)$ are shown in *@13-integral-measures-of-robustness*.

$
  F_1(x) = integral f(x + epsilon) P(epsilon) d epsilon
  quad quad quad
  F_2(x) = integral (f(x + epsilon) - f(x))^2 P(epsilon) d epsilon
$<13-integral-measures-of-robustness>

Where:
- *$P(epsilon)$*: PDF of the uncertainty within $epsilon$.
- *$F_1(x)$*: Measure of the mean value of $f(x)$ over the distribution.
- *$F_2(x)$*: Measure of plateau-like like regions in the distribution.

If $P(epsilon)$ is a normal distribution, increasing $sigma$  will yield a smoothed form of $f(x)$ in $F_1(x)$ and will emphasize plateau regions in $F_2(x)$ of $f(x)$, this is shown in *@13-f-1-x* and *@13-f-2-x* respectively.

#grid(
  columns: 2,
  column-gutter: 1cm,
  [#figure(
    image("images/13-f-1-x.png", width: 100%),
    caption: [Plot of $F_1 (x)$ for increasing values of $sigma$.],
    supplement: [Figure],
    kind: figure,
  )<13-f-1-x>],
  [#figure(
    image("images/13-f-2-x.png", width: 120%),
    caption: [Plot of $F_2 (x)$ for increasing values of $sigma$.],
    supplement: [Figure],
    kind: figure,
  )<13-f-2-x>],
)

Typically a given design will most likely want the best mean with low variance (lowest $F_1 (x)$ and $F_2 (x)$), however these are often conflicting (high $F_1 (x)$ means a low $F_2 (x)$). To combat this, the following two options can be used:

How do we combat this?
- We could use some form of weighted sum of $F_1 (x)$ and $F_2 (x)$.
- Apply a multi-objective optimization to create a Pareto front of $F_1 (x)$ and $F_2 (x)$ (see *@13-pareto-front* and *@13-pareto-front-plotted*).

#grid(
  columns: 2,
  column-gutter: 1cm,
  [#figure(
    image("images/13-pareto-front.png", width: 100%),
    caption: [Plot of Pareto front for $F_1 (x)$ and $F_2 (x)$],
    supplement: [Figure],
    kind: figure,
  )<13-pareto-front>],
  [#figure(
    image("images/13-plotted-pareto-front.png", width: 130%),
    caption: [Plot of the Pareto front onto f(x).],
    supplement: [Figure],
    kind: figure,
  )<13-pareto-front-plotted>],
)

#pagebreak()

=== Randomized Approaches

In some cases an analytical form of f(x) cannot be determined or for $P(epsilon)$. Instead a randomized approach for robust optimization can be used such as a Monte Carlo or Quasi-Monte Carlo. An example of this is shown in *@13-monte*.

#figure(
  image("images/13-radnomized-robust-optimzation.png", width: 100%),
  caption: [Utilizing randomized approaches for robust optimization.],
  supplement: [Figure],
  kind: figure,
)<13-monte>

=== Surrogate Models

The issue with Monte Carlo methods is that they can be expensive to perform as many trials are needed. Especially if near the tail end of the PDF. In such cases surrogate modelling can be used which is essentially a curve fit which has an element of uncertainty baked into it.

== Threshold Measures of Robustness

In this method a threshold of q is defined and then the design is optimized to ensure that the function remains above or below q ($Pr(f lt.eq q)$ or $Pr(f gt.eq q)$). This is called reliability design.

== Reliability Design Vs Robust Design

Both methods consider performance of a system with respect to a PDF, the differencaes are:

- *Robust Design*: considers behavior over the whole PDF, mean, standard deviation etc.
- *Reliability Design*: considers behavior at the tails of the PDF, where the system will fail.

Both can be considered as design objectives or constraints and traded against other objectives if necessary.

#pagebreak()
