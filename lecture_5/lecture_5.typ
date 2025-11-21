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
