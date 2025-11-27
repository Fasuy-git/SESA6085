#import "template.typ": *

= Extracting Data From `Q1_Data.xlsx`

// Define student ID to look for
#let student_id = 32750552

// Use spreet to extract the data out of the excel spreadsheet
#let excel_data_from_bytes = spreet.decode(read("../Q1_Data.xlsx", encoding: none)).at("Data")

// Define the identifiers for the table
#let identifiers = (
  "Student No.",
  $T_R$,
  $C_R$,
  $T_L$,
  $C_L$,
  ..range(1, 121).map(n => $t_(#n)$),
)

// Initialize extract data which will be populated through the for loop
#let extracted_data = ()

// For loop to sift through excel data, find student id and save data in extracted data
#for (count, row) in excel_data_from_bytes.enumerate() {
  let row_data = excel_data_from_bytes.at(count)
  let student_id_in_column_0 = row_data.at(0)
  if student_id_in_column_0 == student_id {
    extracted_data = (
      extracted_data
        + row_data
          .enumerate()
          .map(
            ((sub_count, piece)) => (identifiers.at(sub_count), piece),
          )
    )
  }
}

#figure(
  table(
    columns: 3,
    inset: 5pt,
    fill: (col, row) => if row == 0 { gray } else { white },
    align: center + horizon,
    table.header[*Quantity Name*][*Symbol*][*Value*],

    [Right Censored Time], extracted_data.at(1).at(0), [#extracted_data.at(1).at(1)],
    [Amount of Right Censored Time], extracted_data.at(2).at(0), [#extracted_data.at(2).at(1)],
    [Left Censored Time], extracted_data.at(3).at(0), [#extracted_data.at(3).at(1)],
    [Amount of Left Censored Time], extracted_data.at(4).at(0), [#extracted_data.at(4).at(1)],
  ),
  caption: [Censoring applied to data in excel based on the student id (#student_id)],
) <how-data-is-censored>


#figure(
  table(
    columns: 12,
    inset: 8pt,
    align: left,
    ..extracted_data
      .slice(5)
      .map(pair => {
        let v = pair.at(1)
        [#calc.round(v, digits: 2)]
      })
  ),
  caption: [Failure times for all 120 components.],
) <all-failure-times>

= Question 1

== Use the data provided to estimate the parameters of this model [4 marks]

=== Defining the Component PDF

As there are two distributions modelling two possible failure modes of the component, a *competing risk model* can be used to represent the overall PDF, this is shown in *@1a-competing-risk-model*.

$
  f(t) = f_1(t) R_2 (t) + f_2 (t) R_1 (t)
$<1a-competing-risk-model>

In *@1a-competing-risk-model*, $f_1(t)$ represents the first failure mode, which is a *log-normal distribution*. The second failure mode $f_2(t)$ is represented by a *normal distribution*. These are both shown in *@1a-pdfs*.

$
  f_1(t) =
  1/(t sigma_1 sqrt(2pi)) exp(-1/2((ln(t)-mu_1)/sigma_1)^2)
  quad quad
  f_2(t) =
  1/(sigma_2 sqrt(2pi)) exp(-1/2((t-mu_2)/sigma_2)^2)
$<1a-pdfs>

There does not exist a *closed form solution* to the CDFs for the PDFs shown in *@1a-pdfs*, however the error function can be used to write the equations in an analytical form, still allowing for parameter estimation using MLE. The error function is shown in *@1a-err-func*.

$
  "erf"(x) = 2/sqrt(pi) integral_(0)^x e^(-t)^2 d t
$<1a-err-func>

Utilizing *@1a-err-func*, the CDFs as well as the reliabilities for the PDFs defined in *@1a-pdfs* can be evaluated, yielding to *@1a-cdfs-reliability*.

$
  F_1 (t) =
  integral_(-infinity)^(t)f_1(t)d t
  = 1/2(1+"erf"((ln(t) - mu_1)/(sigma_1 sqrt(2))))
  \
  R_1(t) = 1 - F_1(t) = 1/2(1 - "erf"((ln(t) - mu_1)/(sigma_1 sqrt(2))))
  \
  F_2 (t) =
  integral_(-infinity)^(t)f_2(t)d t
  = 1/2(1+"erf"((t - mu_2)/(sigma_2 sqrt(2))))
  \
  R_2(t) = 1 - F_2(t) = 1/2(1 - "erf"((t - mu_2)/(sigma_2 sqrt(2))))
$<1a-cdfs-reliability>

Substituting *@1a-cdfs-reliability* into *@1a-competing-risk-model* yield the full form of the PDF encompassing both failure modes, this is shown in *@1a-full-pdf*.

$
  f(t) = [1/(t sigma_1 sqrt(2pi)) exp(-1/2((ln(t)-mu_1)/sigma_1)^2)][1/2(1 - "erf"((t - mu_2)/(sigma_2 sqrt(2))))] ...
  \
  ... + [1/(sigma_2 sqrt(2pi)) exp(-1/2((t-mu_2)/sigma_2)^2)][1/2(1 - "erf"((ln(t) - mu_1)/(sigma_1 sqrt(2))))]
$<1a-full-pdf>

=== Constructing the Likelihood Function

As defined in *@how-data-is-censored*, there is both right and left censoring in the set of data. The general form of  the likelihood equation with left and right censoring is shown in *@general-MLE-combined-censoring*.

$
  L(bold(theta)) =
  {product_(i in U) f(t_i:bold(theta))}
  {product_(i in C_L) F(T_L:bold(theta))}
  {product_(i in C_R) R(T_R:bold(theta))}
$<general-MLE-combined-censoring>

For a competing risk model, the reliability and CDF is given by the product of the reliabilities and CDFs of the failure modes, these equations are shown in *@1a-component-cdf-reliability*.

$
  R(t) = R_1(t) R_2 (t) = [1/2(1 - "erf"((ln(t) - mu_1)/(sigma_1 sqrt(2))))][ 1/2(1 - "erf"((t - mu_2)/(sigma_2 sqrt(2))))]
  \
  F(t) = 1 - R_1(t) R_2 (t) = 1 - [1/2(1 - "erf"((ln(t) - mu_1)/(sigma_1 sqrt(2))))][ 1/2(1 - "erf"((t - mu_2)/(sigma_2 sqrt(2))))]
  \
$<1a-component-cdf-reliability>

The final thing to define before constructing the likelihood equation is define the parameters to obtain ($bold(theta)$ within *@general-MLE-combined-censoring*), this is shown in *@MLE-param*.

$
  bold(theta) = mu_1, sigma_1, mu_2, sigma_2
$<MLE-param>

Substituting in *@MLE-param*, *@1a-component-cdf-reliability* and *@1a-full-pdf* into *@general-MLE-combined-censoring* yields *@1a-likelihood*.

$
  L(mu_1, sigma_1, mu_2, sigma_2) =
  {
    product_(i=1)^n_U [1/(t_i sigma_1 sqrt(2pi)) exp(-1/2((ln(t_i)-mu_1)/sigma_1)^2)][1/2(1 - "erf"((t_i - mu_2)/(sigma_2 sqrt(2))))] ...
    \
    ... + [1/(sigma_2 sqrt(2pi)) exp(-1/2((t_i-mu_2)/sigma_2)^2)][1/2(1 - "erf"((ln(t_i) - mu_1)/(sigma_1 sqrt(2))))]
  }
  ... \ ...
  {
    product_(i=1)^n_C_L 1 - [1/2(1 - "erf"((ln(T_L) - mu_1)/(sigma_1 sqrt(2))))][ 1/2(1 - "erf"((T_L - mu_2)/(sigma_2 sqrt(2))))]
  }
  ... \ ...
  {
    product_(i=1)^n_C_R [1/2(1 - "erf"((ln(T_R) - mu_1)/(sigma_1 sqrt(2))))][ 1/2(1 - "erf"((T_R - mu_2)/(sigma_2 sqrt(2))))]
  }
$<1a-likelihood>

=== Determining the Log Likelihood

Taking natural logs of *@general-MLE-combined-censoring* and then rearranging yields the equation shown in *@general-MLE-logs*.

$
  l(bold(theta)) = ln(L(bold(theta))) =
  sum_(i=1)^n_U ln(f(t_i:bold(theta))) +
  sum_(i=1)^n_C_L ln(F(T_L:bold(theta))) +
  sum_(i=1)^n_C_R ln(R(T_R:bold(theta)))
$<general-MLE-logs>

Applying *@general-MLE-logs* to *@1a-likelihood* yields *@1a-log-likelihood*.

$
  l(mu_1, sigma_1, mu_2, sigma_2) =
  \
  sum_(i=1)^n_U ln(
    [1/(t_i sigma_1 sqrt(2pi)) exp(-1/2((ln(t_i)-mu_1)/sigma_1)^2)][1/2(1 - "erf"((t_i - mu_2)/(sigma_2 sqrt(2))))] ...
    \
    ... + [1/(sigma_2 sqrt(2pi)) exp(-1/2((t_i-mu_2)/sigma_2)^2)][1/2(1 - "erf"((ln(t_i) - mu_1)/(sigma_1 sqrt(2))))]
  ) + \
  sum_(i=1)^n_C_L ln(1 - [1/2(1 - "erf"((ln(T_L) - mu_1)/(sigma_1 sqrt(2))))][ 1/2(1 - "erf"((T_L - mu_2)/(sigma_2 sqrt(2))))]) + \
  sum_(i=1)^n_C_R ln([1/2(1 - "erf"((ln(T_R) - mu_1)/(sigma_1 sqrt(2))))][ 1/2(1 - "erf"((T_R - mu_2)/(sigma_2 sqrt(2))))])
$<1a-log-likelihood>

=== Obtaining Parameter Using Python Code

The equation shown in *@1a-log-likelihood* is too complex to be solved by taking derivatives w.r.t each MLE parameter and then setting those equations to zero. Instead a brute force method is used to estimate the values of $accent(theta, hat) = accent(mu, hat)_1,accent(sigma, hat)_1,accent(mu, hat)_2,accent(sigma, hat)_2$. The Python code utilized for this analysis is included in the Zip file at `Q1a\main.py`. Using this code, the parameters generated are shown in *@q1a-solution*

$
  "Log Normal Dist Param" = cases(mu_1 = 2.6543, sigma_1 = 2.3610) quad
  "Normal Dist Param" = cases(mu_2 = 36.5430, sigma_2 = 4.4290)
$<q1a-solution>

== Calculate the probability that the system will fail after 35 hours. [1 mark]

=== Defining the Formulation of the Probability

Utilizing the parameters calculated in Q1a, the probability that a component will fail after 35 hours is given by the expression shown in *@q1b-formulation*.

$
  P(T > 35) = 1 - F(35) = R_1(35)R_2(35)
  \ = [1/2(1 - "erf"((ln(t) - mu_1)/(sigma_1 sqrt(2))))][1/2(1 - "erf"((t - mu_2)/(sigma_2 sqrt(2))))]
$<q1b-formulation>

Using the Python code, found in the Zip file at `Q1b\main.py`, the probability can be computed and the result is shown in *@q1b-solution*.

$
  P(T > 35) = 0.2236
$<q1b-solution>

#pagebreak()

= Question 2
== How many potential routes are there for data to pass from G1 to G2? List these routes. [2 marks]

For *Figure 1* in the coursework, the total number of paths the data can take, as well as the specific paths are detailed in *@q2a-solution*.

$
  "Number of paths :" 7
  \
  G 1 -> S 3 -> S 6 -> G 2 \
  G 1 -> S 3 -> S 5 -> G 2 \
  G 1 -> S 2 -> S 5 -> G 2 \
  G 1 -> S 2 -> S 6 -> G 2 \
  G 1 -> S 2 -> S 4 -> G 2 \
  G 1 -> S 1 -> S 5 -> G 2 \
  G 1 -> S 1 -> S 4 -> G 2
$<q2a-solution>

#pagebreak()

== Use the RBD presented in Figure 2 and the PDF parameters in Table 1 to calculate the reliability (to 4 d.p.) of a single satellite after 20 years [5 marks]

=== General Block Reliability

Every block in the RBD shown in *Figure 2* utilizes a Weibull distribution to model the behavior of the component, the PDF, CDF and reliability for a Weibull distribution are shown in *@q2b-weibull*

$
  f(t) =
  beta / eta^beta t^(beta-1) exp(-(t/eta)^beta) quad quad
  F(t) = 1 - exp(-(t/eta)^beta) \
  R(t) = 1 - F(t) = exp(-(t/eta)^beta)
$<q2b-weibull>


As system is modelled using a series reliability model, the total reliability will therefore be the product of the reliability of each component of the system, this is shown in *@q2b-system-reliability*.

$
  R_(s y s) = product_(i=1)^n R_i = R_("Gyro")^*R_("Battery")^*R_("Computer")R_("Control Pro")R_("Electrical Dist")R_("Telem")R_("Solar Array")^*R_("Thruster")
$<q2b-system-reliability>


=== Active Redundant Systems

The Gyro and Battery are modelled in *Figure 2* as 1-out-of-3 and 1-out-of-2 systems respectively. This means they are effectively active redundant systems with multiple branches. Assuming the Weibull parameters in *Table 1* of the coursework describe the behavior of one branch, the block reliabilities of these two sub-systems is given by *@q2b-active-redundant-reliability*.

$
  R_(s y s) = 1 - product_(i=1)^n (1-R_i) quad -> quad R_("Gyro")^* = 1 - (1 - R_("Gyro"))^3 quad
  R_("Battery")^* = 1 - (1 - R_("Battery"))^2
$<q2b-active-redundant-reliability>

=== m-out-of-n Reliability

The Solar array subsystem is modelled as a 3-out-of-4 system. Applying the general equation for an m-out-of-n system to the solar panel subsystem yields *@q2b-m-n-reliability*.

$
  R_(s y s) = 1 - sum_(i=0)^(m-1) vec(n, i, delim: "(") R^i (1-R)^(n-i) quad quad "Where:" quad vec(n, i, delim: "(") equiv (n!)/(i!(n-i)!)
  \
  R_("Solar Array")^*= 1 - ([vec(4, 0, delim: "(") R^0 (1-R)^(4-0)]+[vec(4, 1, delim: "(") R^1 (1-R)^(4-1)]+[vec(4, 2, delim: "(") R^2 (1-R)^(4-2)])
  \
  = 1 - ((1-R_("Solar Array"))^4 + 4R_("Solar Array")(1-R_("Solar Array"))^3 + 6R_("Solar Array")^2(1-R_("Solar Array"))^2)
$<q2b-m-n-reliability>

=== Obtaining a Solution

The reliability of the system was computed in Python (find at `Q2b\main.py`) by taking *@q2b-system-reliability* and substituting in *@q2b-system-reliability* and *@q2b-m-n-reliability*, the calculated reliability of the system after 20 years is shown in

$
  R_(s y s) (T=20) = 0.6902 quad quad ("to 4 d.p")
$<q2b-solution>

== As a designer what satellite sub-systems would you target for improvement and why? [3 marks]

=== Identifying Lowest Subsystem Reliability

As the RBD in *Figure 2* models the satellite subsystems as a series system, increasing the reliability of the sub-system with the lowest reliability will yield the greatest improvement in system reliability. Altering the code from the previous question (new code is at `Q2c\main.py`) to display the system reliabilities yields the following *@q2c-subsystem-reliability*.

#figure(
  table(
    columns: 2,
    fill: (col, row) => if row == 0 { gray } else { white },
    align: center + horizon,
    table.header[*Subsystem Name*][*Reliability $R(T=20)$*],

    [Gyro Subsystem], [1.0000],
    [Battery Subsystem], [0.9937],
    [Control Processor], [0.9850],
    [Solar Array], [0.9722],
    [Computer], [0.9655],
    [Telemetry Tracking & Command], [0.9538],
    [Electrical Distribution], [0.8942],
    [Thruster], [0.8602],
  ),
  caption: [Subsystem reliability sorted from most to least reliable (rounded to 4.d.p).],
)<q2c-subsystem-reliability>

As can be seen from the table the thruster, electrical distribution and telemetry systems have the lowest reliability, therefore to increase the reliability of these systems (by increasing the redundancy through implementing some sort of redundancy) will increase the system's reliability. Alternatively, the gyro and battery subsystems have very high reliabilities, if there were mass or cost constraints then decreasing the reliability of these components will have less of an impact on the whole system.

=== Computing Birnbaum's Importance Measure

Birnbaum's importance measure is a method to quantify the importance a given subsystem and is calculated using *@birnbaums-importance-measure*.

$
  I_B^i (t) = (partial G(bold(q)(t)))/(partial q_i (t)) = G(1_i,bold(q)) - G(0_i,bold(q))
$<birnbaums-importance-measure>

Where $G(1_i,bold(q))$ is the system's unavailability when the $i^(t h)$ component is *operating normally* and $G(0_i,bold(q))$ is the system's unavailability when the $i^(t h)$ component is *inoperative*. Computing these measures for the system yields *@importance-metrics*.

#figure(
  table(
    columns: 2,
    fill: (col, row) => if row == 0 { gray } else { white },
    align: center + horizon,
    table.header[*Component Name*][*Importance Measure*],

    [Gyro Subsystem], [0.6902],
    [Battery Subsystem], [0.6946],
    [Computer], [0.7149],
    [Control Processor], [0.7007],
    [Electrical Distribution], [0.7719],
    [Telemetry Tracking & Command], [0.7237],
    [Solar Array], [0.6933],
    [Thruster], [0.8024],
  ),
  caption: [Component importance measures at $T = 20$, rounded to 4 d.p.],
)<importance-metrics>

Similar to *@q2c-subsystem-reliability*, the components with the highest importance metrics are those with the lowest reliabilities.

#pagebreak()

== Employ a Monte Carlo simulation with 500 iterations to calculate the probability that at 20 years it will still be possible to transmit a signal from G1 to G2. [10 marks]

The reliability of a satellite after 20 years was previously calculated ($R_(s y s) (T=20) = 0.6902$). In order to estimate the probability that a signal will still be transmitted after 20 years through the network, the following analysis is used:

- Calculate the reliability of one satellite after 20 years (already computed).
- Define the possible paths a signal can take between the two ground stations (already calculated).
- Using a random number generator see if a given satellite is active or inactive by seeing if the generated number is above or below the reliability
- See if there are any viable paths for the signal to traverse.
- Add up all of the successful trials and calculate a probability of success.

After performing the Monte-Carlo analysis with 500 trials, the probability that a signal will be able
to be sent from G1 $->$ G2 is shown in

$
  P("Signal" G 1 -> G 2 "at" 20 "years") = 0.936
$<q2d-solution>
