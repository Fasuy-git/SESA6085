#import "../template.typ": *

= Lecture 5

== Censored Data

Often data sets are not presented in a whole manner, instead data is presented in a censored or incomplete manner. There are three main ways data can be presented *right censored*, *left censored* and *interval censored*.

=== Right Censored Data

Also known as *type 1* censored data and occurs when the failure condition of components exceeds the observation time. An example of right censored data is shown in *@5-right-censored-table* for 10 servos over the span of 72 hours.

#figure(
  table(
    columns: 2,
    fill: (col, row) => (
      if row == 0 {
        gray
      } else if row == 9 { yellow.transparentize(40%) } else { white }
    ),
    align: center + horizon,
    table.header[*Component Number*][*Component Failure Time (Hrs)*],
    [Servo \#1], [30],
    [Servo \#2], [32.5],
    [Servo \#3], [40],
    [Servo \#4], [41.0],
    [Servo \#5], [43.0],
    [Servo \#6], [50.6],
    [Servo \#7], [57.2],
    [Servo \#8], [67],
    [Servo \#9 and Servo \#10], [>72],
  ),
  caption: [Right censored data example, failure times of 10 servos over 72 hours.],
)<5-right-censored-table>

Note that in *@5-right-censored-table*, the failure time of servos 9 and 10 is unknown as they did not fail within the observation time.

=== Left Censored Data

Left censored data is where components fail after teh start of a test but before the start of observation. Another example with 10 servos over a 10 hour span is shown in *@5-left-censored-table*.

#figure(
  table(
    columns: 2,
    fill: (col, row) => (
      if row == 0 {
        gray
      } else if row == 1 { yellow.transparentize(40%) } else { white }
    ),
    align: center + horizon,
    table.header[*Component Number*][*Component Failure Time (Hrs)*],
    [Servo \#1 and Servo \#2], [< 24],
    [Servo \#3], [31],
    [Servo \#4], [35],
    [Servo \#5], [43.7],
    [Servo \#6], [50.3],
    [Servo \#7], [56.1],
    [Servo \#8], [65.8],
    [Servo \#9], [70.3],
    [Servo \#10], [80.1],
  ),
  caption: [Left censored data example, failure times of 10 servos over 72 hours.],
)<5-left-censored-table>

Note that in *@5-left-censored-table* the exact failure times of servos 1 and 2 are unknown as they were before the observation time.

=== Interval Censored Data

Interval censored data is where the exact failure time ius unknown, just the interval within which the failure occurred. With this type of censoring there is an associated upper and lower bound for each interval, an example of this is shown in *@5-interval-censored-data*.

#figure(
  table(
    columns: 2,
    fill: (col, row) => (
      if row == 0 {
        gray
      } else { if col == 0 { yellow.transparentize(40%) } }
    ),
    align: center + horizon,
    table.header[*Time Interval (Hrs)*][*Number of Observed Failures*],
    [0-10], [0],
    [11-20], [5],
    [21-30], [4],
    [31-40], [6],
    [41-50], [10],
    [51-60], [2],
  ),
  caption: [ Interval censored data example, failure times of 10 servos over 72 hours.],
)<5-interval-censored-data>

== Censored Data Notation

To develop equations and expressions to include censored data within the statistical models, the following notations will be used:

- *$U$* : Uncensored data subset.
- *$C$* : Censored data subset.
  - *$C_R$* : Right censored data subset.
  - *$C_L$* : Left censored data subset.
  - *$C_I$* : Interval censored data subset.

== Likelihood for Right Censored Data

For a right censored set of data, despite the exact failure time of components beyond the observation time is unknown, the probability of them failing can be calculated. The probability that a component fails above a certain time $T_R$
is shown in *@5-right-censored-plot* and given by *@5-right-censored-prob*.

#grid(
  columns: 2,
  [#figure(
      image("images/5-right-censored-data.png", width: 50%),
      caption: [PDF where the probability of failure of a component over a time $T_R$ is shaded.],
      supplement: [Figure],
      kind: figure,
    )<5-right-censored-plot>
  ],
  [\ \ $
    P(t > T_R) = 1 - integral_(0)^(T_R) f(t) d t = R(T_R)
  $<5-right-censored-prob>],
)

Note that in *@5-right-censored-prob* the probability that a components fails after the cutoff time $T_R$ is given by the *reliability function*. This mathematical representation for the right censored data can then be used to rewrite the likelihood expression, this is shown in *@5-right-censored-MLE*.

$
  L(bold(theta)) = product_(i = 1)^n f(t_i:bold(theta)) quad -> quad L(bold(theta)) = {product_(i in U) f(t_i:bold(theta))} {product_(i in C_R) R(T_R:bold(theta))}
$<5-right-censored-MLE>


== Likelihood for Left Censored Data

Though, the exact failure time of the components before the start of the observation time is unknown, the probability of them failing in this timeframe can be calculated. The probability that a component fails before $T_L$
is shown in *@5-left-censored-plot* and given by *@5-left-censored-prob*.

#grid(
  columns: 2,
  [#figure(
      image("images/5-left-censored-data.png", width: 50%),
      caption: [PDF where the probability of failure of a component under a time $T_L$ is shaded.],
      supplement: [Figure],
      kind: figure,
    )<5-left-censored-plot>
  ],
  [\ \ $
    P(t > T_R) = integral_(0)^(T_L) f(t) d t
  $<5-left-censored-prob>],
)

The mathematical expression shown in *@5-left-censored-prob* can be used within the likelihood expression shown in *@5-left-censored-MLE*

$
  L(bold(theta)) = product_(i = 1)^n f(t_i:bold(theta)) quad -> quad L(bold(theta)) = {product_(i in U) f(t_i:bold(theta))} {product_(i in C_L) F(T_L:bold(theta))}
$<5-left-censored-MLE>

== Likelihood for Interval Censored Data

Although the exact failure time of a component within the interval is unknown, the probability that a component does fail within that time span can be calculated.The probability that a component fails in the interval $T_1_(L B) -> T_1_(U B)$ is shown in *@5-interval-censored-plot* and given by *@5-interval-censored-prob*.

#grid(
  columns: (0.4fr, 0.6fr),
  [#figure(
      image("images/5-interval-censored-data.png", width: 50%),
      caption: [PDF where the probability of failure of a component within the interval $T_1_(L B) -> T_1_(U B)$ is shaded.],
      supplement: [Figure],
      kind: figure,
    )<5-interval-censored-plot>
  ],
  [\ \ $
    P(T_I_(L B) < t < T_I_(U B)) = integral_(0)^(T_I_(U B)) f(t) d t - integral_(0)^(T_I_(L B)) f(t) d t
  $<5-interval-censored-prob>],
)

The mathematical expression shown in *@5-interval-censored-prob* can be used within the likelihood expression shown in *@5-interval-censored-MLE*, note that more intervals can be added by multiplying the on to the end.

$
  L(bold(theta)) = product_(i = 1)^n f(t_i:bold(theta)) quad -> quad L(bold(theta)) = {product_(i in U) f(t_i:bold(theta))} {product_(i in C_I) F(T_I_(U B):bold(theta)) - F(T_I_(L B):bold(theta))}
$<5-interval-censored-MLE>

== Likelihood With Multiple Types of Censoring

Multiple types of censoring are shown in *@5-MLE-combined-censoring*. Note, it is still possible to use MLE to find optimum parameters, use the Fisher matrix to find the confidence intervals and form a censored joint distribution function.

$
  L(bold(theta)) =
  {product_(i in U) f(t_i:bold(theta))}
  {product_(i in C_L) F(T_L:bold(theta))}
  {product_(i in C_I) F(T_I_(U B):bold(theta)) - F(T_I_(L B):bold(theta))}
  {product_(i in C_R) R(T_R:bold(theta))}
$<5-MLE-combined-censoring>

#pagebreak()
