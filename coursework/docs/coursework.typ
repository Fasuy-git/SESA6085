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

=== Constructing the Liklehood Equation

As defined in *@how-data-is-censored*, there is both right and left censoring in the set of data. The general form of  the liklehood equation with left and right censoring is shown in *@general-MLE-combined-censoring*.

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
  P(T > 35) = 1 - F(35) = 1 - (1-R_1(35))(1-R_2(35))
  \ = 1 - (1 - [ 1/2(1+"erf"((ln(t) - mu_1)/(sigma_1 sqrt(2))))])(1 - [1/2(1+"erf"((t - mu_2)/(sigma_2 sqrt(2))))])
$<q1b-formulation>

Using the Python code, found in the Zip file at `Q1b\main.py`, the probability can be computed and the result is shown in *@q1b-solution*.

$
  P(T > 35) = 0.2236
$<q1b-solution>


