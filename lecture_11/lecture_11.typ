#import "../template.typ": *

= Lecture 11

== Load Sharing Systems

Load sharing systems consist of $n$ components where if one component fails, the other components take up the remaining load (failure of a landing leg for a spacecraft, other legs must support the lander). The following notation is utilized for load sharing systems:

- $L$: Load per component.
- $F(L)$: Failure distribution for a given component and load per component.
- $G_n (L)$: Failure of a system consisting of $n$ components at a given load per component.

The model used to model such systems is called Daniel's model and was originally developed for the textiles industry. The generalized expression for the failure of a load sharing system is given in *@11-daniels-model*.

$
  G_n (L) = sum_(r = 1)^n vec(n, r, delim: "(") (-1)^(r+1) F^r (L) G_(n-r) ((n L)/(n - r))
$<11-daniels-model>

Where $n$ is the number of components and $r$ is the number of failed components. Note that $vec(n, r, delim: "(")$ is the binomial coefficient and the equation itself is recursive. Consider a simple system where there is only one component, the probability of the system failing is given by *@11-single-shared-system*.

$
  G_1 (L) = F(L)
$<11-single-shared-system>

If instead of one component, the system is composed of two components, the expression is more complex, the derived expression is shown in *@11-double-shared-system*.

$
  G_2 (L) = sum_(r = 1)^2 vec(2, r, delim: "(") (-1)^(r+1) F^r (L) G_(2-r) ((2 L)/(2 - r))
  \
  = vec(2, 1, delim: "(") (-1)^2 F^1 (L) G_1 (2L) vec(2, 2, delim: "(") (-1)^3 F^2 (L) G_0
  \
  G_0 = 1 quad G_1(2L) = vec(1, 1, delim: "(") (-1)^2 F^1 (2L) G_0 = F(2L)
  \
  therefore
  G_2 (L) = 2F(L) F(2L) - F^2(L)
$<11-double-shared-system>

Note that for *@11-daniels-model*, as the number of components go above 40, the numerical stability of the equation falls apart, there exist further numerical models which improve on this.

#pagebreak()
