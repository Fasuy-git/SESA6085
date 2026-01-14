#import "../template.typ": *

= Lecture 12

== Reliability within Deign Engineering

If there are any design changes that need to be made to a product, the earlier this design change is done the cheaper its cost will be. Often design change cost grows exponentially with the later design changes, showing the importance of baking reliability within the design. The effect the development stage has on the cost of change is shown in *@12-cost-of-change*.

#figure(
  image("images/12-cost-of-change.png", width: 50%),
  caption: [Graph of cost of change against development stage.],
  supplement: [Figure],
  kind: figure,
)<12-cost-of-change>

Design for Reliability (DfR) is similar in some aspects to design for six sigma, which is a design approach aimed at reducing manufacturing variability. In reality DfR encompasses six sigma whilst also being influenced by it.

== Design for Reliability

DfR is made up of the following six development stages, these six stages are shown in *@12-dfr* and explained in the following sections.

#figure(
  image("images/12-dfr-stages.png", width: 50%),
  caption: [Stages in DfR],
  supplement: [Figure],
  kind: figure,
)<12-dfr>

=== Identify

Typically the first step of any design process is to create a set of system requirements, and from that a set of sub-system requirements. Identification in DfR translates *system and subsystem requirements into reliability requirements*. For example a car should last 200,000 miles, from this the reliability of an engine block under a certain stress level is determined and so on, with each set of reliability requirements being sent off to each design team. In this stage the reliability team also looks at:

- *System Usage Profiles*: A statistical and operational description of usage conditions often derived from legacy data e.g., flight profile for a single aisle aircraft would use A320 and B737 data.

- *Benchmarking Data*: How does the product compare with other like products currently on the market. Also helps set targets for the user and for the marketing department.

The identification stage also includes looking at differences from legacy products to help judge program risk, identification of new tech that requires reliability analysis and future testing and validation cost prediction.

=== Design

In this stage, specific activities associated with design are defined, as well as gaining an idea of the system's layout and components. Due to this formal reliability analysis techniques such as RBDs, FTAs, FMECA and HAZPOS can be used. Typically reviews are done throughout the design process in order to highlight any issues as soon as possible in the process.

=== Analyze

In this stage, physics based simulations are done to analyze potential causes of failure. The results of these simulations can be related to sub-system or system reliability. Typically, there is an iterative process between design and analysis, often aided through automation. This has a heavy focus in modern development.

=== Verify

At this stage a physical prototype has been developed and so test can be performed. These are done at the component or subsystem level (never really system as its very expensive). Some forms of tests are:

- *Accelerated lifetime tests*: Put the system or subsystem through rapid endurance test which model the lifetime exposure a product will see.

- *Failure and degradation tests*.

- *Performance or Environmental tests*: typically the environmental conditions a component or subsystem, will see are unknown and so the component is tested over a large environmental band.

Data from verification test can be used to influence future designs. Changes can still be made at this level despite teh increased cost as this is still at the component level.

=== Validate

At this stage, system level test are carried out to ensure that all reliability metric have been met. If not then some small changes can still be made to sub-systems.

=== Control

This stage aims to control the variability in manufacturing and reduce variability. Six sigma can be used here in order to drive down variation. In reality data from this stage is used the identification stage of the next product (system usage profile etc).

#pagebreak()
