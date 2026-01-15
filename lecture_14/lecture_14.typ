#import "../template.typ": *

= Lecture 14

== Overview of Concurrent/Collaborative Design


Component design is a multi-disciplinary effort involving the collaboration of multiple teams. This is propagated all the way up to the system level. *Communication between these subsystems introduced uncertainty*. Furthermore, each sub-system design speed may be different further complicating the design process.

== Design Decomposition

Typically the design of a system is decomposed into subsystems, allowing the exploitation of specific expertise, reduce the number of controlled design variables and reduce the scope of design analysis models. For example someone good at structures can be in charge of that sub-system. This means they only have to complete FEA simulations and look at design variables relating to the structure.

== Interfaces

However, sub systems can be tightly coupled, have conflicting requirements and contribute differently to system performance. To combat this extensive collaboration and communication is nessicary. Typically coordination is done through *interfaces*, which is where one design variable is shared between components or sub-systems (e.g mass flow rate between valve and tank).

Interfaces are typically agreed at the outset of the design process in a system-level conceptual/preliminary design. These then act as constraints for the sub-system designers. However there are some issues with this methods, these are:

- Imposed constraints may be sometimes impossible to satisfy.
- Sub-system may pass constraints but fail to work at system level due to:
  - Poor modelling assumptions (e.g., deflection of wingtip in isolation of the wing).
  - Interface constraint was too coarse.
  - Effect of one sub-system on another was ignored (more of a problem for highly coupled systems).

To combat these issues, constrains are often either *field functions* using knowledge from Chief engineers or can be *bounds* (e.g., $plus.minus 4$mm displacement). If there are many bounds from many interfaces typically each bound is taken to be a *PDF and then this becomes a robust design problem*.

== Robust Design within Concurrent Design

The issue of using robust design within concurrent design is that it is typically very expensive, therefore it is difficult to evaluate the performance of a given design. Multidisciplinary Design Analysis & Optimization
(MDAO) tries to create a mathematical framework to solve this but is often inflexible to design changes as it uses and assumes a fixed set of design variables. It is important to note that this is an area of study.

#pagebreak()
