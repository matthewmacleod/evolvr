defmodule Evolve.Maths do
  @moduledoc """
  A collection of simple mathematics
    * basic math
    * linear algebra
    * statistics
    * probability
    * machine learning
  todo perhaps break this up into more modules later
  """


  # nb erlang import, has pi,log,log2,log10,exp,pow,...etc
  import :math

  ### basic math ###

  @doc"""
  Input:  a list of numbers
  Output: a sum
  """
  def sum(list) do
    Enum.reduce(list, fn(x,acc) -> acc + x end)
  end

  @doc"""
  Input:  two numbers: a,b
  Output: a^b = float
  """
  def power(a,b) do
    pow(a,b)
  end


  ### linear algebra math ###




  ### statistics math ###

  def mean(list) do
    sum(list) / length(list)
  end


  def median(list) do
    n = length(list)
    sorted_list = Enum.sort(list)
    if rem(n,2) == 0 do # even case
      middle_minus_one = div(n,2)-1
      middle_plus_one = div(n,2)
      prev = Enum.fetch(sorted_list, middle_minus_one) |> elem(1)
      next = Enum.fetch(sorted_list, middle_plus_one) |> elem(1)
      (prev+next)/2.0 # avg the center values
    else # odd case
      middle = div((n-1),2)
      Enum.fetch(sorted_list, middle) |> elem(1)
    end
  end


  ### probability math ###




  ### machine learning math ###






end


