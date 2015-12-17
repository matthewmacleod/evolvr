Evolvr
======

Introduction
--------------

The evolvr project goal is to create a machine learning package which utilizes
* various general machine learning techniques
* explores concurrency


Running Code
--------------
* to build:

           mix escript.build

* to run:

           ./evolvr --input=input

* to run interactively,

         iex

Load libraries

         iex(1)> c("parallel.ex")

         iex(2)> c("maths.ex")

Now can use functions

         Evolvr.Maths.factorial(5)

         Evolvr.Maths.factorial(1000)




Running Tests
--------------
type:

           mix test

this will run both unit tests and doctests.

Code
--------------
see lib directory, eg

      lib/evolvr/maths.ex


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

License
--------------

see file:

    license.txt

Documentation
--------------
Equations for project are located in

        doc/evolvr_equations.tex

Instructions for compling are inside tex file.

To generate project documentation with:

           mix docs


Notebook
--------------
as root:

    dnf install npm

as normal user:

    virtualenv -p /usr/bin/python3 notes

    cd notes

    source ./bin/activate

    git clone https://github.com/jupyter/notebook.git

    cd notebook

    ../bin/pip install --pre -e .

    ../bin/pip install jupyter-console

    git clone https://github.com/pprzetacznik/IElixir.git

    cd IElixir

    mix deps.get

    mix test

    MIX_ENV=prod mix compile

    mkdir -p ~/.ipython/kernels/ielixir

    ./install_script.sh

     jupyter notebook resources/example.ipynb




