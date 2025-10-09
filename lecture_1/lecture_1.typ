#import "../template.typ": *

= Lecture 1

== Probability Fundamentals, Rules and Notation

The most basic definition of the probability for a general event $A$ occurring *is the ratio of the number of favorable outcomes $n$ to the total number of equally likely possible outcomes $N$*, this is shown in a mathematical representation in *@1-basic-probability-definition*.

$
  P(A) = n/N
$<1-basic-probability-definition>

Where:
- *$P(A)$*: The probability of outcome $A$.
- *$N$*: Total number of equally likely possible outcomes in the sample space.
- *$n$*: Number of favorable outcomes (ways in which event  $A$ occurs)

Note that *@1-basic-probability-definition* is only for events of equal probability, for example rolling a dice. Instead if *N is the number of experiments* then *@1-basic-probability-definition-experiments* applies, implying that the larger the number of experiments the closer to *@1-basic-probability-definition* the probability becomes.

$
  P(A) = lim_(N -> infinity) (n/N)
$<1-basic-probability-definition-experiments>

This module uses the following notation for the probability of combined events, these are:

- *$P(A)$*: Probability of event *$A$* occurring.
- *$P(A B)$*: Probability of events *$A$ and $B$* occurring.
- *$P(A + B)$*: Probability of events *$A$ or $B$* occurring.
- *$P(A|B)$*: Probability of event *$A$* given event *$B$* has already occurred.
- *$P(overline(A))$*: Probability of event *$A$* *not* occurring (note that $P(A)=1-P(overline(A))$).

=== Statical Independence

If two events are *statistically independent* (s-independent) from one another (meaning that the probability of one event occurring is completely separate from another event happening or not happening), then *@1-s-independent* is true.

#set math.cases(reverse: true)
$
  cases(
    P(A|B) = P(A|overline(B)) = P(A),
    P(B|A) = P(B|overline(A)) = P(B)
  ) "s-independent"
$<1-s-independent>

Furthermore, the joint probability of two s-independent events can be represented in the forms shown in *@1-adjoint-s-independent* with the further expressions derived from subbing in *@1-s-independent*, *@1-adjoint-s-independent* is also known as the *product or series rule*.

$
  cases(P(A B) = P(A)P(B),) "s-independent"
$<1-adjoint-s-independent>

=== Statistical Dependence

If two events are instead *statistically dependent* (s-dependent) from one another (the probability of on event happening or not happening *does* have an effect of the probability of another event), then the adjoint probability of these two events is shown in *@1-adjoint-s-dependent*

$
  cases(
    P(A B) = P(A)P(B|A),
    P(A B) = P(A|B)P(B),
  ) "s-dependent" \
  cases(P(B|A) = P(A B) / P(A)) "s-dependent and "P(A) eq.not 0
$<1-adjoint-s-dependent>

== Probability Fundamentals, Rules and Notation Cont.

Generally speaking the probability of one event *or* another event occurring , whether they are s-dependant or s-independent is given by equation *@1-or-probability*.

$
  P(A + B) = P(A) + P(B) - P(A B) \
  cases(P(A + B) = P(A) + P(B) - P(A)P(B)) "s-independent"
$<1-or-probability>

Note that the $P(A B)$ in *@1-or-probability* must be subtracted as it is counted twice in the first two terms.
