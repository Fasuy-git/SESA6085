#import "../template.typ": *

= Lecture 16

== Nested Uncertainties

So far the module has only covered uncertainties at the system or component level and primarily linked to performance or operation. In reality there are uncertainties at all level's of a system's development, as shown in *@16-nested-uncertainties*.

#figure(
  image("images/16-nested-uncertainties.png", width: 50%),
  caption: [Image showing how uncertainties can build up to the company level.],
  supplement: [Figure],
  kind: figure,
)<16-nested-uncertainties>

== Project Uncertainty Management

Before defining what project uncertainty management is, the following key terms are defined:

- *Uncertainty*: Lack of certainty.
- *Risk*: Possible *unfavorable* outcomes due to uncertainty.
- *Opportunity*: Possible *favorable* outcomes due to uncertainty.

Project uncertainty management is *a process whereby uncertainties are captured, the sources and impacts of the uncertainty are understood and then the understanding of the uncertainty can be used to make decisions in order to reduce risk or exploit opportunity.* This applied to the following interlinked areas:

- *Project management*: Creating of specific assets
- *Operations management*: Managing for business as usual
- *Corporate management*: Changes to corporate strategy & ensuring appropriate governance

== Types of Project Uncertainty

Similar to design uncertainty, there are groups which uncertainties can be placed in, these are:

- *Ambiguity uncertainty*: Lack of complete/perfect knowledge. This type can be reduced/resolved over time e.g more understanding of spec from customer.

- *Inherent variability*: Always happens but the degree is variable e.g. inflation.

- *Event uncertainty*: Events that may or may not happen e.g a natural disaster.

- *Systemic uncertainty*: Dependencies and complex relationships (feedback or feed-forward) e.g. link between material price and labour.

== PUMPS

Performance Uncertainty Management Processes (PUMPS) is an effective decision making tool with minimum cost. It is a framework which models uncertainties and their impacts to help make decision and identify opportunities. It embeds aspects such as stochastic processes, decision branches, sensitivity diagrams, ownership and documentation. PUMPS has more benefit if done early on but can be done at any stage of the development cycle. *PUMPS consists of 7 stages* which each have the following *5 common tasks*:

- *Document*: record text, tables, diagrams etc.
- *Verify*: ensure that all providers of information agree and highlight where this is not possible.
- *Assess*: evaluate the analysis to date and ensure it is fit for purpose (if not then the loop is repeated).
- *Report*: release documentation and present findings to stakeholders.
- *Fit for purpose iteration control*:  ask, "are the current deliverables at this stage of PUMPS fit for purpose?".

Another aspect that PUMPs utilizes at each stage is the *seven Ws*, these are:

- *W*\ho.
- *W*\hy.
- *W*\hat.
- *W*\hichway: How will plans in each stage deliver.
- *W*\herewithal: What resources are needed.
- *W*\When.
- *W*\Where.

The seven stages of PUMPS which each use the common 5 tasks and the seven Ws are summarized below:

+ *Define* the project:
  - Collect as much info as possible on the project, what deliverables are required and ensuring everyone understand the project.

+ *Focus* the process:
  - Achieves “clarity efficiency” i.e. a cost-effective use of uncertainty management resources. Defines allocation of efforts to quantify uncertainty for areas which have the most impact.

+ *Identify* sources and responses:
  - Locate areas of uncertainty which impact that phase of project outcome as well as all of the responses to that uncertainty.

+ *Structure* all uncertainty:
  - Qualitative analysis to understand importance & interactions of uncertainties to refine and create new responses, basically look at uncertainty links and generate new responses.

+ *Clarify* ownership:
  - Ensures all uncertainty sources and responses has an owner. This can feed into supply chain, legal and agreements.

+ *Quantify* some uncertainty:
  - Provide probability estimates of uncertainty associated with sources and responses. These estimates can be associated with cost, duration etc,.

+ *Evaluate* all implications:
  - Understand the implications of uncertainties by combining PDFs and making informed decision.

== Quantification Phase

The quantification stage involves two methods of analysis to quantify source and response uncertainties, these are:

- *1st pass*: Sizing of sources of uncertainty in probabilistic terms.
- *Later passes*: Refining earlier quantification of uncertainty.

Typically multiple passes to quantify uncertainty are required. It is important to be clarity efficient here and ensure that time is spent investigating the major sources of uncertainty with the most impact. Some examples of qualification use use non-numeric, subjective approaches to define risk. One example of this is Probability-Impact Grid (PIG) shown in *@16-pig*.

#figure(
  image("images/16-pig.png", width: 70%),
  caption: [Image showing an example of a Probability-Impact Grid (PIG).],
  supplement: [Figure],
  kind: figure,
)<16-pig>

Issues with PIGs are that they fall short of minimum level of clarity as its too simple of a characterization of risk, too qualitative (terms may mean different things to different people) and the method is attractive due to its simplicity, discouraging a more useful quantification of risk. It is also hard to define the impacts due to qualitative risk, e.g, financial impact due to a risk.

PUMPs aims to produce a probabilistic definition of uncertainty, reducing ambiguity and allowing for quantification of impacts. This however requires data in order to do so. Quantification contains the following steps for each source of uncertainty as well as for each probabilistic response:


+ Ordering of uncertainty sources in terms of Importance.

+ Clarifying associated conditions for these uncertainties e.g. this will only happen if…
+ Data or elicitation is used to size the uncertainty e.g. produce a PDF.
+ Refine sizing e.g., alternative PDF definitions, management of elicitation, clarification of relationships between objective data and subjective probabilities.
+ Repeat steps 2-4 for each uncertainty in the list updating priorities if necessary are more information comes to light.

== Elicitation

Sometimes (particularly in management) there is insufficient data in order to fit a curve and create a PDF. In this case elicitation can be utilized. A simple elicitation strategy would be:

+ *Pessimistic Outcome*: Ask  to define pessimistic end of outcome (10% or 90% exceed).
+ *Optimistic Outcome*: Ask  to define optimistic end of outcome (90% or 10% exceed).
+ *Intermediate Outcome*: Define intermediate outcomes (50% exceed, 25% exceed etc)

This method will generate a rectangular distribution. Other PDFs can be fitted but care must be taken to determine if the PDF is appropriate. Furthermore, elicitation victims should never be asked distribution parameters e.g., what is teh standard deviation of rainfall. Typically this method will generate rectangular or triangular distributions. Note that another method would be asking people for the CDF and then using monte-carlo analysis to generate the PDF.

== Evaluation Phase

As was mentioned previously, this is the last stage of teh PUMPs process and features the following 5 stages:

+ Defining an appropriate starting point based on source dependencies.
+ Specifying dependence between sources.
+ Combining sources using mathematical operators.
+ Presenting the results of the model.
+ Diagnosing the implications of these results.

Typically there are many different uncertainty sources as well as many separate PDF definitions. This is where computational methods such as Monte Carlo analyses can be use to combine PDFs and generate objective outputs. In reality, the sources of uncertainties are similar to fault trees so this process is effectively a FTA.

== Portraying Effects and Sensitivity Diagrams

A key output of PUMP is the portrayal of the effects of uncertainties, this can be done through figures and diagrams but is most commonly through sensitivity diagrams, an example of a sensitivity diagram is shown in *@16-sensitivity-diagram*.

#figure(
  image("images/16-sensitivity-diagram.png", width: 70%),
  caption: [Example plot of a sensitivity diagram.],
  supplement: [Figure],
  kind: figure,
)<16-sensitivity-diagram>

*@16-sensitivity-diagram* simply shows that enacting response C will increase the probability that the task is completed before the desired completion date.

#pagebreak()
