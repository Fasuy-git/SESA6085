#import "../template.typ": *

= Lecture 10

== Competing Risk Models

If a component has multiple s-independent failure modes, then it can be modelled using a competing risk model. This a compound model, series system model or multi-risk model.
Such models can only be used if:

- The failure modes are completely independent (one failure mode does not effect the others).
- The component fails when the first mode is encountered.
- Each mode has it's own distribution (each failure mode can be modelled using a PDF).

For a given component with $n$ failure modes, each failure mode will have a distribution function $F_i (t)$. The component fails when it encounters any one of the failure modes, this means it can be *modelled in a similar way to a series RBD*. The PDF for such a component is shown in *@10-competing-risk-pdf*, using this parameters can then be found.

$
  f(t) = R(t) [sum_(i = 1)^n (f_i (t))/(R_i (t))]
$<10-competing-risk-pdf>

An example of two normal distributions where $X_1 \~ N(mu :15, sigma:5)$ and $X_2 \~ N(mu :20, sigma:1)$ is shown in *@10-competing-risk-pdfs* with the combined PDF generated using *@10-competing-risk-pdf* is shown in *@10-competing-risk-combined-pdf*.

#grid(
  columns: (auto, auto),
  row-gutter: 1cm,
  column-gutter: 1cm,
  [#figure(
    image("images/10-competing-risk-pdfs.png", width: 80%),
    caption: [Two PDFs that represent the failure modes of a component [$X_1 \~ N(mu :15, sigma:5)$ and $X_2 \~ N(mu :20, sigma:1)$].],
    supplement: [Figure],
    kind: figure,
  )<10-competing-risk-pdfs>],
  [#figure(
    image("images/10-competing-risk-combined-pdf.png", width: 80%),
    caption: [Combined component PDF for the PDFs shown in *@10-competing-risk-pdfs*.],
    supplement: [Figure],
    kind: figure,
  )<10-competing-risk-combined-pdf>],
)

== Fault Tree Analysis (FTA)

This is a reliability and safety modelling method similar to RBDs, where a system fault is modelled  by considering the lower level sub-system and component failures which contribute to the failure of that given system. Some common diagrams used in FTA are shown in *@10-common-fta-symbols*

#figure(
  table(
    columns: 3,
    fill: (col, row) => (
      if row == 0 {
        gray
      } else { white }
    ),
    align: center + horizon,
    table.header[*Symbol Name*][*Symbol*][*Description*],
    [Basic Event],
    [#image("images/10-fta-basic-event.png", width: 25%)],
    [A basic fault event that requires no further development (it cannot be broken down further). It is s-independent of other events and effectively acts as a terminal node.],

    [And Gate],
    [#image("images/10-fta-and-gate.png", width: 25%)],
    [Failure (next higher event) will occur if all inputs fail (parallel redundancy).],

    [Or Gate],
    [#image("images/10-fta-or-gate.png", width: 25%)],
    [Failure (next higher event) will occur if any input fail (series reliability).],

    [Combination Event],
    [#image("images/10-fta-combination-event.png", width: 25%)],
    [An event (fault) that results from the combination of basic events (faults) through the input logic gates.],

    [Undeveloped Event],
    [#image("images/fta-undeveloped-event.png", width: 25%)],
    [It is s-dependent upon lower events, but not developed downwards (an abstraction of lower level events).],
  ),
  caption: [Common FTA symbols, their names and their descriptions.],
)<10-common-fta-symbols>

An example of the FTA diagram for the failure of a car engine is shown in *@10-fta-engine-failure*, with the corresponding RBD shown in *@10-rbd-engine-failure*.

#figure(
  image("images/10-rbd-engine-fail.png", width: 80%),
  caption: [RBD for a car engine failure.],
  supplement: [Figure],
  kind: figure,
)<10-rbd-engine-failure>

#figure(
  image("images/10-fta-engine-failiure.png", width: 70%),
  caption: [FTA for a car engine failure.],
  supplement: [Figure],
  kind: figure,
)<10-fta-engine-failure>

#pagebreak()

== FTA Vs RBDs

Whereas a RBD builds up a model concentrating on the success of the system (reliability), FTA builds up a model via a hierarchy of failures (failure probability). RBD will consider the entire system whereas FTA only considers portions of the system that effect a fault. Blocks within FTA can be re-used in other sections of the model, for example the low voltage failures shown in  *@10-fta-engine-failure*.

== Performing a FTA

The first step is to define the top level failure (e.g., failure of an engine). From here lower level faults are considered, as is how they combine to cause the top level failure. These steps are propagated down as far as possible or unit an a already existing FTA/failure data can be substituted in. Remember that the failure probability for an and gate is the product of all of the lower level failures and for an or gate it is the product.

#pagebreak()
