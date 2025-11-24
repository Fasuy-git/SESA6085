#import "../template.typ": *

= Lecture 7

== Reliability New Products

An accurate understanding of the reliability of a new product is critical for many reasons, such as:

- Product must be more reliable than other competing products on the market for increased marketability.
- Allows for costing of warranty, spares, maintenance cost etc,
- When replacement/maintenance should occur for continual running of the system.

The issue is however, that a *reliability prediction can rarely be made with high accuracy or confidence*. This is due to each component have a level of uncertainty associated with its reliability prediction. As the system is then constructed of these components, the uncertainty stacks and the final system level reliability has a very high uncertainty. This is further compounded the lower the initial component level. Further to this, the human factor to reliability is almost impossible to include in a model, failure is defined differently by different stake holders and users can use products in unintended ways, effecting reliability.

== Fundamental Limitations

Just as physical equations have limitations (ohms law not true near absolute zero), reliability predictions also have similar limitations. Reasonably credible reliability predictions can be made if:

+ The system is similar to systems developed, built and used previously.
+ The new system does not involve significant technological risk.

Further to this credible predictions must be made if:

+ The system will be manufactured in large quantities, or is very complex, or will be used for a long time, or a combination of these.
+ There is a strong commitment to the achievement of the reliability predicted.

If a prediction is not made in the above scenarios then this opens the door for massive recalls, user injury or other unwanted results.

== Systems Reliability Models

To model the reliability of a system, a *Reliability Block Diagram* (RBD) is used. RBDs are a graphical diagram of the reliability of a system and allow for the calculation of the reliability of the whole system. A RBD works like a flow chart where if it is possible to traverse from one side of a network to another then the system is working. Each block has an associated probability which controls whether that block has failed or not and can therefore no longer be traversed through. The configuration of the RBD does not have to be in terms of the system's operational logic or functional partitioning, however this may help create the RBD

=== Series Reliability Model

A basic series reliability model consists of two or more blocks connected in series with one another. Failure of any one component would result in the failure of the whole system. An example of this system is shown in *@7-series-rbd*

#figure(
  image("images/7-series-RBD.png", height: 5%),
  caption: [Series RBD with constant hazard rates.],
  supplement: [Figure],
  kind: figure,
)<7-series-rbd>

Recall here that a hazard rate $h(x)$ instantaneous probability of failure at time $t$  given the item has survived until $t$. A constant hazard rate therefore means that the instantaneous failure probability never changes. The system reliability for the RBD shown in *@7-series-rbd* is given by *@7-series-rbd-reliability*.

$
  R_1 = exp(-lambda_1 t) quad quad R_2 = exp(-lambda_2 t)
  \
  R_(s y s) = R_1 R_2 = exp(-lambda_1 t) exp(-lambda_2 t) = exp(-(lambda_1 + lambda_2)t)
$<7-series-rbd-reliability>

For an $n$ number of components which are connected in series with one another, the system reliability is shown in *@7-series-rbd-reliability-general*.

$
  R_(s y s) = product_(i=1)^n R_i quad quad "If" lambda = "Const" -> quad R_(s y s) = exp(- (sum_(i=1)^n lambda_i)t)
$<7-series-rbd-reliability-general>

=== Active Redundancy Model

An active redundancy model features multiple parallel pathways with components on each branch. If a single component fails, then the system itself may not fail. An example active redundancy model is shown in *@7-active-redundancy-rbd*.

#figure(
  image("images/7-active-redundancy.png", height: 10%),
  caption: [Active redundancy RBD with constant hazard rates.],
  supplement: [Figure],
  kind: figure,
)<7-active-redundancy-rbd>

The system reliability for a simple two component actively redundant system as shown in *@7-active-redundancy-rbd* is given by the expression shown in *@7-active-redundancy*.

$
  R_(s y s) = R_1 + R_2 - R_1 R_2 = 1 - (1-R_1)(1-R_2)
  \
  R_(s y s) = 1 - (1 - exp(-lambda_1 t))(1 - exp(-lambda_2 t))
$<7-active-redundancy>

For an actively redundant system with $n$ number of branches which are connected in parallel with one another, the general system reliability is shown in *@7-active-redundancy-general*.

$
  R_(s y s) = 1 - product_(i=1)^n (1-R_i)
$<7-active-redundancy-general>

=== m-out-of-n Model

An m-out-of-n model states that at least m number of branches must work out of a total number of n branches for that section of the system to work. The probability of m-out-of-n system with s-independent components, each with equal unit realities is given as *@7-m-n-RBD-general* and shown in *@7-m-n-RBD*.

#figure(
  image("images/7-m-n-RBD.png", height: 20%),
  caption: [Example of an m-out-of-n RBD (2-out-of-3).],
  supplement: [Figure],
  kind: figure,
)<7-m-n-RBD>

$
  R_(s y s) = 1 - sum_(i=0)^(m-1) vec(n, i, delim: "(") R^i (1-R)^(i-1) quad quad "Where:" quad vec(n, i, delim: "(") equiv (n!)/(x!(n-x)!)
$<7-m-n-RBD-general>

=== RBD Decomposition

Decomposition can be used to break complex RBDs into simpler ones, similar to resistors in circuits. An example of complex decomposition utilizing the RBDs covered in previous sections is shown in *@7-RBD-decom*.

#figure(
  image("images/7-decomp.png", height: 30%),
  caption: [Decomposition of a complex RBD into a simpler system.],
  supplement: [Figure],
  kind: figure,
)<7-RBD-decom>

The decomposition process allows for easy identification of sections of the RBD which drive the systems reliability and further redesign of trouble areas to improve their reliability.

=== Common Modes of Failure

Sometimes adding extra redundancy within a system does not increase its reliability as the failure of the system is driven by another section of it. Take the two RBDs shown in *@7-common-fail*.

#figure(
  image("images/7-common-failire.png", width: 100%),
  caption: [Series RBD [Left] composite series and active redundant system [Right]],
  supplement: [Figure],
  kind: figure,
)<7-common-fail>

The calculated system reliability for the LHS RBD is 0.9702 whereas the RHS RBD is 0.9799. There is only an increase of 0.0097 as the dominant failure point $R_(C M)$ has not changed.

#pagebreak()
