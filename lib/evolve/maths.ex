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
  NB this can give fractional powers as well,
     eg square roots
  """
  def power(a,b) do
    pow(a,b)
  end


  ### linear algebra math ###

  ## vectors ##

  def dot(v,w) do
    sum(for {x,y} <- Enum.zip(v,w), do: x * y)
  end

  def vector_add(v,w) do
    for {x,y} <- Enum.zip(v,w), do: x + y
  end

  def vector_subtract(v,w) do
    for {x,y} <- Enum.zip(v,w), do: x - y
  end

  @doc"""
  Input:  list of vectors
  Output: componentwise sum of all vectors
  """
  def vector_sum(vectors) do
    Enum.reduce(vectors, fn(x, acc) -> acc = vector_add(x,acc) end)
  end

  # scale vector
  def scalar_multiply(c, v) do
    Enum.map(v, &(&1 * c))
  end

  @doc"""
  Input:  list of vectors
  Output: componentwise mean all vectors
  NB vectors must be same length, todo add assertion
  """
  def vector_mean(vectors) do
    n = length(vectors)
    scalar_multiply(1/n, vector_sum(vectors))
  end

  def sum_of_squares(v) do
    dot(v,v)
  end

  def magnitude(v) do
    sqrt(sum_of_squares(v))
  end

  def squared_distance(v,w) do
    sum_of_squares(vector_subtract(v,w))
  end

  @doc"""
  Input:  two vectors
  Output: distance between vectors (ie distance between points)
  NB vectors must be same length, todo add assertion
  """
  def distance(v,w) do
    magnitude(vector_subtract(v,w))
  end

  ## matrices ##


  ### statistics math ###

  def mean(list) do
    sum(list) / length(list)
  end


  @doc"""
  Input:  list of numbers
  Output: median
  NB this might be faster if dont sort at beginning,
     ie use quickselect algorithm
  """
  def median(list) do
    n = length(list)
    sorted_list = Enum.sort(list)
    if rem(n,2) == 0 do # even case
      middle_minus_one = div(n,2)-1 # use div since fetch wants an integer
      middle_plus_one = div(n,2)
      prev = Enum.fetch(sorted_list, middle_minus_one) |> elem(1)
      next = Enum.fetch(sorted_list, middle_plus_one) |> elem(1)
      (prev+next)/2.0 # avg the center values
    else # odd case
      middle = div((n-1),2)
      Enum.fetch(sorted_list, middle) |> elem(1)
    end
  end

  def data_range(list) do
    Enum.max(list) - Enum.min(list)
  end

  def mode(list) do
  end

  def quantile() do
  end

  def interquartile_range(list) do
  end

  def from_mean() do
  end

  def variance() do
  end

  def standard_deviation(list) do
  end

  def correlation(x,y) do
  end

  ### probability math ###




  ### machine learning math ###






end


