#import "../template.typ": *

= Lecture 9

== Importance of a Component

A component within a system is more or less important based on the influence it has within the system. Components with a high amount of influence on the behavior of the system can be focused on more with less significant components given less focus. From a reliability standpoint the *most important component* is the one that has the *biggest impact on reliability* when removed or changed. Note that purely optimizing for reliability is unrealistic, performance, mass, cost, manufacturing constrains must all also be taken into account when creating a product. Identifying components importance is therefore a key metric in optimizing systems reliability. To assess the importance of a component within a system, the system's reliability is considered when:

- The component is working
- The component is not working

== Importance Notation and Assumptions

For a system built up of $n$ components, a given $i^(t h)$ component can either be working normally (denoted as $X^i = 1$) or it can be broken (denoted as $X_i = 0$). The probability therefore of a component not working is denoted as $P(X_i = 0) = q_i$. The global state of the system is denoted as $phi.alt(bold(X))$ where $phi.alt(bold(X)) = 1$ indicates a fully working system and $phi.alt(bold(X)) = 0$ denotes a broken or inoperative system. Tying together all of this notation gives the expression in *@9-system-state*.

$
  phi.alt(bold(X)) quad "Depends on the states" quad X_i quad "Where" quad X_i in [1,n]
$<9-system-state>

Building on from *@9-system-state*, the system unreliability function can be defined and is shown in *@9-system-unreliability*.

$
  G(bold(q)) = 1 - P[phi.alt(bold(X)) = 1]
$<9-system-unreliability>

Where $bold(q)$ is a function of the failure probability $q_i$ for all components $n$. From this the following two variants of teh unreliability function can be defined:

- $G(0_i,bold(q))$ : System unavailability when the $i^(t h)$ component is *operating normally* (failure probability is zero, $q_i = 0$).

- $G(1_i,bold(q))$ : System unavailability when the $i^(t h)$ component is *inoperative* (failure probability is one, $q_i = 1$).

== Birnbaum's Importance Measure

This is an importance measure based on the system unavailability expressions denoted in the previous section. The expression for Birnbaum's importance measure is given as *@9-birnbaums-importance-measure*.

$
  I_B^i (t) = (partial G(bold(q)(t)))/(partial q_i (t)) = G(1_i,bold(q)) - G(0_i,bold(q))
$<9-birnbaums-importance-measure>

The higher the value of *@9-birnbaums-importance-measure*, the more important it is within the system. It is important to note that for series systems, the component with the lowest reliability will be the most important and for a parallel system the component with the highest reliability will be the most important.

== Criticality Importance Measure

The criticality importance measure is the conditional probability that the system is in a state at time $t$ such that the $i^(t h)$ component is critical and has failed by $t$. The expression for calculating the criticality importance measure is shown in *@9-crit-importance-measure*.

$
  I_(C R)^i (t) = (partial G(bold(q)(t)))/(partial q_i (t)) times (q_i (t))/(G(bold(q)(t))) = ([G(1_i,bold(q)) - G(0_i,bold(q))] times q_i (t))/(G(bold(q)(t)))
$<9-crit-importance-measure>

Note that *@9-crit-importance-measure* includes *@9-birnbaums-importance-measure* within it. Note that for some systems, the critically can be the same for all components even if teh reliability is not the same as each component may be equally critical.

== Upgrade Function

The upgrade function is defined as the fractional reduction in the probability of the system failure when the failure rate of the $i^(t h)$ component is reduced. The expression for the upgrade function is shown in *@9-upgrade-function*, note the upgrade function can only be applied to systems where all components have an exponential reliability.

$
  I_(U F)^i (t) = (lambda_i)/(G(bold(q)(t))) times (partial G(bold(q)(t)))/(partial lambda_i)
$<9-upgrade-function>

Note that utilizing the upgrade function will yield a time varying value for the importance measure $I_(U F)$, which is useful to see how the component importance varies overtime.

#pagebreak()
