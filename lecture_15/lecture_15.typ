#import "../template.typ": *

= Lecture 15

== Maintenance and Inspection

Maintenance can extend the lifetime of a product considerably however there are a few issues to consider:

- How often should such maintenance be carried out?
  - Too often and there is unneeded expenditure, too infrequent and the product could fail.
- How do we keep the system in working order for longer?
- How do we minimize the cost of such maintenance and repairs?

== Mean Time to Failure

The mean time to failure (MTTF) is a measure of the *average time a non repairable system will fail*. Also called the expected time to failure, it is given by the expression shown in *@15-mttf*.

$
  "MTTF" = E[T] = integral_0^infinity t f(t) d t = integral_0^infinity R(t) d t
$<15-mttf>

== Repairable Systems

This is a type of system or component which is *repaired upon failure*. It is assumed that the repaired component or system was as good as it was before the repair. It is also assumed that the failure of the component does not effect the performance of other system even though this may not be necessarily true. The two most important performance metrics for this type of system are:

- *Availability of the System*: For how long is a system able to do what it was designed to.
- *Mean Time Before Failure (MTBF)*

Note that of these two availability of the system is more important as it can be directly equated to money made.

== Expected Number of Failures

The derivation for the expected number of failures within a time $t$ is given by $M(t)$ given in *@15-fundamental-renewal-equation*. This equation is called the *fundamental renewal equation*.

$
  M(t) = F(t) + integral_0^t M(t-x)f(x)d x
$<15-fundamental-renewal-equation>

It is also possible to develop a *renewal density equation* from *@15-fundamental-renewal-equation* which gives the probability that a renewal occurs between $t$ and $t + Delta t$. This equation is shown in

$
  m(t) = f(t) + integral_0^t m(t-x)f(x)d x
$<15-renewal-density-equation>

One issue with *@15-fundamental-renewal-equation*, is that the equation features M on both sides. Though this could be solved computationally, a discrete time approximation is used shown in *@15-discrete-time-approach*.

$
  M(t) = sum_(i=0)^(T - 1) [1 + M(T - i - 1)] integral_i^(i + 1) f(t) d t quad quad "Where" quad M(0) = 0
$<15-discrete-time-approach>

This essentially produces an iterative equation where T is a discrete time. One important result from the derivation of *@15-fundamental-renewal-equation* is that *@15-exponential* is true for an exponential distribution.

$
  "If" quad f(t) = lambda e^(-lambda t) quad cases(
    m(t) = lambda,
    M(t) = lambda t
  )
$<15-exponential>

== Optimum PMRI

A Preventive Maintenance, Replacements and Inspection (PMRI) schedule is important for defining maintenance and
inspection routines. An optimum PRMI will aim to minimize cost, balancing cost due to downtime and maintenance and inspection costs.

=== Cost Minimization: CIRP

A Constant Interval Replacement Policy (CRIP) is the  simplest preventive replacement policy and is where a *component is replaced after a constant interval*. This approach has the following two aspects:

+ A component is replaced on failure
+ A component is replaced at a predetermined interval regardless of age

#figure(
  image("images/15-crip.png", width: 90%),
  caption: [Failiures and interval replacements for a given component using CIRP],
  supplement: [Figure],
  kind: figure,
)<15-cirp>

To optimize based on the the above performance criteria the cost function shown in *@15-crip-eq* is used.

$
  c(t_p) = ("Total Expected Cost "[0,t_p])/("Length of the Interval") = (c_p + c_f M(t_p))/(t_p)
$<15-crip-eq>

Where:

- *$"Total Expected Cost"$*: Cost of preventative replacements ($c_p$) +  Expected cost of failure replacement ($c_f M(t_p)$)
- *$t_p$*: Interval of time.
- *$c_p$*: Single preventative replacement cost.
- *$c_f$*: Failure preventative replacement cost.
- *$M(t_p)$*: Expected number of failures in interval [0,$t_p$]


=== Cost Minimization: Replacement at a Predetermined Age

There could be a case where CIRP will cause a preventative replacement to be installed shortly after a failure replacement.A method to fix this issue is replacement at a predetermined age. The rules for this policy are:

- Components are replaced on failure.
- Components are replaced after a set age.
- Or whichever comes first.

This yields the cost function shown in *@15-rpa*.

$
  c(t_(p a)) = ("Total expected replacement cost per cycle")/("Expected length of cycle") = ... \ ... = (c_p R(t_(p a)) + c_f [1 - R(t_(p a))])/(t_(p a)R(t_(p a)) + [1 - R(t_(p a))] integral_(-infinity)^(t_(p a)) t f(t)d t)
$<15-rpa>

=== Downtime Minimization: CIRP

There are some situations where system availability is more important than the cost of maintenance and inspection. In such cases the downtime should be minimized not the maintenance cost. Using the Constant Interval Replacement Policy (CIRP) but applying it to downtime yields *@15-downtime-crip-eq*.

$
  D_"CIRP"(t_p) = (T_p + T_f M(t_p))/(T_p + t_p)
$<15-downtime-crip-eq>

Where:

- *$T_p$*: Single preventative replacement time.
- *$T_f$*: Failure preventative replacement time.

=== Downtime Minimization: Replacement at a Predetermined Age

As was shown for CIRP, it is also possible to define a function for the downtime given a replacement at a predetermined age policy. This is shown in *@15-downtime-rpa*.

$
  c(t_(p a)) = (T_p R(t_(p a)) + T_f [1 - R(t_(p a))])/((t_(p a) + T_p)R(t_(p a)) + [1 - R(t_(p a))][integral_(-infinity)^(t_(p a)) t f(t)d t) + T_p]
$<15-downtime-rpa>

#pagebreak()
