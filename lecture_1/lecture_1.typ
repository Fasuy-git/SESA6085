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

