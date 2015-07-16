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
  Input: numerator, denominator
  Output: float
  NB this is a bit of a hack so can pass around in functional style
  """
  def divide(numerator, denominator) do
    numerator / denominator
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

  @doc"""
  Input:  matrix (list of lists format)
  Output: [number of rows, number of columns]
  """
  def shape(mat) do
    [length(mat), length(List.first(mat))]
  end

  @doc"""
  Input:  matrix (list of lists format) and ith row (zero indexed)
  Output: [row_i]
  """
  def get_row(mat,i) do
    Enum.at(mat,i)
  end

  @doc"""
  Input:  matrix (list of lists format) and jth column (zero indexed)
  Output: [column_j]
  """
  def get_column(mat,j) do
    for x <- mat, do: Enum.at(x,j) # generator yields rows(x) nicely
  end



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

  @doc"""
  Input:  list of numbers, list percent at which want value
  Output: value percent value (from sorted list)
  NB generalization of median
  """
  def quantile(list,p) do
    p_index = round(p*length(list))
    sorted_list = Enum.sort(list)
    Enum.at(sorted_list, p_index)
  end

  def data_range(list) do
    Enum.max(list) - Enum.min(list)
  end

  @doc"""
    Input: list and element to count
    Output: number of times element occurs in list
  """
  def counts(x,list) do
    Enum.reduce(list, 0, fn(y, acc) -> if x==y, do: acc + 1, else: acc end)
  end

  def mode(list) do
    max_freq = Enum.max_by(list, fn(x) -> counts(x,list) end) |> counts(list)
    Enum.filter(list, fn(x) -> counts(x,list) == max_freq end) |> Enum.uniq
  end

  def from_mean(list) do
    avg = mean(list)
    for x <- list, do: x - avg
  end

  def variance(list) do
    n = length(list)
    list |> from_mean |> sum_of_squares |> divide(n-1)
  end

  def standard_deviation(list) do
    sqrt(variance(list))
  end

  def interquartile_range(list) do
    quantile(list,0.75) - quantile(list,0.25)
  end

  def covariance(x,y) do
    n = length(x)
    dot(from_mean(x),from_mean(y)) |> divide(n-1)
  end

  @doc"""
  Input: two vectors
  Output: correlation
  NB result should lie between -1 (anti-correlated) and 1 (perfect correlation)
  """
  def correlation(x,y) do
    std_dev_x = standard_deviation(x)
    std_dev_y = standard_deviation(y)
    if std_dev_x > 0 && std_dev_y > 0 do
      covariance(x,y) / std_dev_x / std_dev_y
    else
      0
    end
  end

  ### probability math ###

  @doc"""
  Input: number
  Output: value in uniform cumulative distribution function
  """
  def uniform_cdf(x) do
    cond do
       x < 0  -> 0
       x < 1  -> x
       x >= 1 -> 1
    end
  end

  @doc"""
  Input: number
  Output: value in normal probability distribution function
  NB when mu = 0, and sigma = 1, returns standard normal distribution value
     also exp, pow, and sqrt are from erlang
  """
  def normal_pdf(x, mu, sigma) do
    prefactor = 1 / sqrt(2 * pi * sigma)
    prefactor * exp(-1 * pow((x - mu),2) / (2 * pow(sigma,2)))
  end

  @doc"""
  Input: number
  Output: value in normal cumulative distribution function
  NB exp, pow, sqrt, erf are from erlang
     erf(X) = 2/sqrt(pi)*integral from 0 to X of exp(-t*t) dt.
  """
  def normal_cdf(x, mu, sigma) do
    (1 + erf((x - mu) / sqrt(2) / sigma)) / 2
  end


  ### machine learning math ###






end


