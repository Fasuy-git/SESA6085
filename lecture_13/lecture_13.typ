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



