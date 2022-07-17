# The source code for chapter 3 of my thesis "Aritificial Understanding"

## Installation instructions

You need to have installed Haskell and Clingo (version 4.5 or above).

1. To install Haskell:
    * go to https://www.haskell.org/downloads/

2. To install Clingo (version 4.5 or above):
    * go to https://potassco.org/clingo/

## Compilation instructions

Once you have Haskell and Clingo installed, just run (from the root directory):
   * `cd code`
   * `cabal update`
   * `cabal configure`
   * `cabal new-build`
   * `cabal install`
   * `cd ..`

## Examples

Once the system is installed (see above), you are ready to try some examples developed for the original Apperception Engine by Richard Evans:

To run these examples, **make sure you are in the root directory called apperception**.

A single sensor oscillating between on and off:
   * `~/.cabal/bin/mysolve misc predict_1.lp`

Two sensors, one oscillates between on and off, while the other has the same reading throughout:
   * `~/.cabal/bin/mysolve misc predict_2.lp`

Exogenous action:
   * `~/.cabal/bin/mysolve misc exog_1.lp`

Searching through templates of increasing complexity, looking for a unified interpretation:
   * `~/.cabal/bin/mysolve eca-general predict_eca_245_b3.lp`

## More Complex Examples

See https://github.com/RichardEvans/apperception for a list of more complex examples for the original system.

Now to make use of existential quantification in the head of judgements you can try the following examples:

A simple counting sequence:
   * `~/.cabal/bin/mysolve cj heating_2.lp`


A simple example in which conjunction of atoms in the head is helpful:
   * `~/.cabal/bin/mysolve cj conjunction_1.lp`


The final example of chapter 3 (this takes about 2 hours) :
   * `~/.cabal/bin/mysolve cj heating_1.lp`

In general, mysolve can be run with any file in the data directory. All examples added by me are in the data/causal_judgement folder.

## Understanding the output of the solve process

When solve is run, it produces...
* the theory *θ = (φ, I, R, C)* composed of...
    * the initial conditions (*I*)
    * the rules (*R*)
    * the constraints (*C*)
* the trace (*τ(θ)*)
* statistics: the cost of the interpretation *θ*
* accuracy: whether or not all the predicted sensor readings match the hidden readings

To generate a latex-readable description of the output:
 * set `flag_output_latex = True` in Interpretation.hs
 * recompile: `scripts/compile_solve.sh`
 * run again


## Data generation

The data is already provided in the `data/` folder.

But if you want to regenerate it:
* `scripts/compile_all.sh`
* `cd code`
* `./eca all`
* `./sw all`
* `./music all`
* `./rhythm all`
