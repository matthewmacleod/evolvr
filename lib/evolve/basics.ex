defmodule Evolve.Basics do
  @moduledoc """
  A collection of simple utilities
    * additional list functions
    * print functions
  """


  ### list type functions ###

  @doc"""
  Input: list
  Output: sorted list
  NB n log n algorithm
  """
  def qsort([]), do: []
  def qsort([head|tail]) do
    smaller = fn list -> for x <- list, x <= head, do: x end
    larger = fn list -> for x <- list, x > head, do: x end
    qsort(smaller.(tail)) ++ [head] ++ qsort(larger.(tail))
  end


  ### print functions ###






end


