Evolve
======

Introduction
--------------

The evolve project goal is to create a massively parallel machine learning package which utilizes
* various general machine learning techniques
* and applies them to solve bioinformatic problems


Running Code
--------------
* to build:

           mix escript.build

* to run:

           ./evolve --input=input

Running Tests
--------------
type:

           mix test


Code
--------------
see lib directory, eg

    lib/evolve/maths.ex

TODO
--------------
* maths library
  * transpose
  * matrix multiplication
  * inverse
  * linear solver, Ax=b
* machine learning library
  * linear model
  * lasso
  * ridge regression
  * KNN
  * k-means
  * HMM
* utilities -plotting interface eg to R
* basic bioinformatic techniques
* concurrency

Documentation
--------------
Equations for project are located in

        doc/evolve_equations.tex

Instructions for compling are inside tex file.

To generate project documentation with:

           mix docs

to run doc tests:




