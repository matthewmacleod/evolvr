defmodule Evolvr.Maths do
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
  import Parallel

  ### basic maths ###

  @doc"""
  Input:  a list of numbers
  Output: a sum
  """
  def sum(list) do
    Enum.reduce(list, fn(x,acc) -> acc + x end)
  end

  @doc"""
  Input:  numerator, denominator
  Output: float
  NB this is a bit of a hack so can pass around in functional style
  """
  def divide(numerator, denominator) do
    numerator / denominator
  end

  # todo add memoization
  @doc"""
    Input: n where n is whole number

    ## Examples

    iex> Evolvr.Maths.factorial(5)
    120

    iex> Evolvr.Maths.factorial(100)
    93326215443944152681699238856266700490715968264381621468592963895217599993229915608941463976156518286253697920827223758251185210916864000000000000000000000000
  """
  def factorial(n), do: factorial(n,1)
  defp factorial(0,acc), do: acc
  defp factorial(n,acc), do: factorial(n-1, acc*n)

  ### linear algebra maths ###

  ## vectors ##

  def dot(v,w) do
    z = Enum.zip(v,w)
    #sum(Enum.map(z, fn({x,y}) -> x * y end))
    # use our pmap
    sum(pmap(z, fn({x,y}) -> x * y end))
  end

  def vector_add(v,w) do
    z = Enum.zip(v,w)
    #Enum.map(z, fn({x,y}) -> x + y end)
    pmap(z, fn({x,y}) -> x + y end)
  end

  def vector_subtract(v,w) do
    z = Enum.zip(v,w)
    #Enum.map(z, fn({x,y}) -> x - y end)
    pmap(z, fn({x,y}) -> x - y end)
  end

  @doc"""
  Input:  list of vectors
  Output: componentwise sum of all vectors
  """
  def vector_sum(vectors) do
    Enum.reduce(vectors, fn(x, acc) -> vector_add(x,acc) end)
  end

  # scale vector
  def scalar_multiply(constant, v) do
    #Enum.map(v, &(&1 * constant))
    pmap(v, &(&1 * constant))
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

  @doc"""
  Input:  vector
  Output: ||v||, aka Euclidean norm
  """
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
  Aside, this is the Euclidean distance,
  Also can use in KNN, maybe consider minkowski and mahalanobis as well
  """
  def distance(v,w) do
    magnitude(vector_subtract(v,w))
  end

  @doc"""
  Input:  two vectors
  Output: taxicab, aka manhattan distance
  The distance between two points measured along axes at right angles,
  In a plane with p1 at (x1, y1) and p2 at (x2, y2), it is |x1 - x2| + |y1 - y2|
  Also known as rectilinear distance, Minkowski's L1 distance, taxi cab metric, or city block distance.
  Hamming distance can be seen as Manhattan distance between bit vectors
  """
  def taxicab_distance(v,w) do
    sum(for {x,y} <- Enum.zip(v,w), do: abs(x - y))
  end

  @doc"""
  Input:  two vectors and p parameter
  Output: distance
  NB p = 1 reduces to taxicab distance, aka manhattan distance, L1 norm
     p = 2 recover Euclidean distance, L2 norm
  """
  def minkowski_distance(v,w,p) do
    df = for {x,y} <- Enum.zip(v,w), do: abs(x - y)
    #a = sum(Enum.map(df, fn(x) -> pow(x,p) end))
    a = sum(pmap(df, fn(x) -> pow(x,p) end))
    pow(a, 1/p)
  end

  @doc"""
  Input:  two vectors and p parameter
  Output: distance
  NB this function takes into consideration a volatility about each dimension,
     via the standard deviation in dimensions, aka normalized Euclidean distance
     also works better with 'squashed data collections',
     eg better identify outliers in these distributions
  """
  def mahalanobis_distance(v,w) do
    x_mean = mean(v)
    y_mean = mean(w)
    n = length(v) # not sure if need n-1
    df = for {x,y} <- Enum.zip(v,w), do: pow(((x - y)/((x-x_mean)*(y-y_mean)*1/n)),2)
    sqrt(df)
  end

  @doc"""
  Input:  two vectors
  Output: 1 if vectors are pointed in same direction
  """
  def cosine_similarity(v,w) do
    dot(v,w) / (magnitude(v) * magnitude(w))
  end

  @doc"""
  Input:  two vectors
  Output: angle between the angles given in degrees
  Aside, could be useful in comparing 'overlap of vectors'
  """
  def angle(v,w) do
    acos(dot(v,w) / (magnitude(v) * magnitude(w))) * 180.0 / pi
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



  ### statistics maths ###

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

  @doc"""
  Input: observation list (y values from measurement) and prediction_list (y predictions)
  Output: R^2 statistic
  NB need to run function over x values to produce prediction list (predicted y values)
  R^2 statistic measures the proportion of variability in Y that can be explained using X
  """
  def r_squared(observation_list, prediction_list) do
    rss = prediction_list |> from_mean |> sum_of_squares
    tss = observation_list |> from_mean |> sum_of_squares
    1.0 - rss / tss
  end

  def variance(list) do
    list |> from_mean |> sum_of_squares |> divide(length(list)-1)
  end

  def standard_deviation(list) do
    sqrt(variance(list))
  end

  def interquartile_range(list) do
    quantile(list,0.75) - quantile(list,0.25)
  end

  @doc"""
  covariance is a measure of how much two random variables change together
  """
  def covariance(x,y) do
    dot(from_mean(x),from_mean(y)) |> divide(length(x)-1)
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

  ### probability maths ###

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
  Input: number (x)
  Output: value in normal cumulative distribution function, eg probability (y)
  NB exp, pow, sqrt, erf are from erlang
     erf(X) = 2/sqrt(pi)*integral from 0 to X of exp(-t*t) dt.
  """
  def normal_cdf(x, mu, sigma) do
    (1 + erf((x - mu) / sqrt(2) / sigma)) / 2
  end

  @doc"""
  Input: number
  Output: value from approximate gamma function
  NB approximating gamma function with Robert H. Windschitl approx.
  has 8 digit accuracy with values larger than 8
  https://en.wikipedia.org/wiki/Stirling%27s_approximation
  https://en.wikipedia.org/wiki/Beta_distribution
  """
  def gamma(z) do
    prefactor = sqrt(2*pi/z)
    ez_inverse = z/exp(1)
    inner = ez_inverse * sqrt( z*sinh(1/z) + 1/(810*pow(z,6)))
    prefactor * pow(inner,z)
  end

  defp beta_factor(alpha, beta) do
    gamma(alpha) * gamma(beta) / gamma(alpha+beta)
  end

  def beta_pdf(x, alpha, beta) do
    cond do
     x <= 0 -> 0
     x >= 1 -> 0
     x > 0 && x < 1 -> pow(x,alpha-1) * pow((1-x),(beta-1)) / beta_factor(alpha, beta)
    end
  end


  def binary_search(p,low_z,low_p,hi_z,hi_p,tolerance, probability_function), do: bin_search(p, low_z, low_p, hi_z, hi_p, tolerance, probability_function, hi_z + low_z / 2, hi_z - low_z)

  defp bin_search(_p, _low_z, _low_p, _hi_z, _hi_p, tolerance, _probability_function, mid_z, current_val) when current_val < tolerance, do: mid_z

  defp bin_search(p, low_z, low_p, hi_z, hi_p, tolerance, probability_function, _mid_z, _current_val) do
    mid_z = (low_z + hi_z) / 2
    mid_p = probability_function.(mid_z,0,1) # todo pass args too?
    cond do
      mid_p < p -> {low_z, low_p} = {mid_z, mid_p}
      mid_p >= p -> {hi_z, hi_p} = {mid_z, mid_p}
    end
    bin_search(p, low_z, low_p, hi_z, hi_p, tolerance, probability_function, mid_z, hi_z - low_z)
  end

  @doc"""
  Input: p (probability, y)
  Output: x
  NB This technique is know as inverse since want to invert the normal_cdf, ie given a probability (y), what is x
  uses a binary search algorithm
  """
  #NB if mu or sigma are not 0 or 1, respectively then rescale
  def inverse_normal_cdf(p,mu,sigma,tolerance) when mu != 0 or sigma != 1, do: mu + sigma * inverse_normal_cdf(p,mu,sigma,tolerance)

  def inverse_normal_cdf(p,_mu,_sigma,tolerance) do
    {low_z, low_p} = {-10.0, 0}
    {hi_z, hi_p} =   { 10.0, 1}
    binary_search(p, low_z, low_p, hi_z, hi_p, tolerance, &normal_cdf/3)
  end



  ### machine learning maths ###

  def create_data_partition(list,percentage) do
    p_index = round(percentage*length(list))
    {_training, _testing} = Enum.split(list, p_index)
  end

  @doc"""
  fraction of correct predictions
  """
  def accuracy(true_positive, false_positive, false_negative, true_negative) do
    correct = true_positive  + true_negative
    total = correct + false_negative + false_positive
    correct / total
  end

  @doc"""
  how accurate positive predictions are
  aka PPV positive predictive value
  """
  def precision(true_positive, false_positive) do
    true_positive / (true_positive + false_positive)
  end

  @doc"""
  what fraction of positives were identified
  aka sensitivity, eg diseased probability
  """
  def recall(true_positive, false_negative) do
    true_positive / (true_positive + false_negative)
  end

  @doc"""
  specificity eg healthy probability
  """
  def specificity(false_positive, true_negative) do
    true_negative / (false_positive + true_negative)
  end

  @doc"""
  This is the F1 score
  """
  def f1_score(true_positive, false_positive, false_negative, _true_negative) do
    prec = precision(true_positive, false_positive)
    rec = recall(true_positive, false_negative)
    2 * prec * rec / (prec + rec)
  end

  ## KNN K nearest neighbors algorithms for classification ##

  @doc"""
  Input: a data list (vector keys and associated values), vector to match, distance function/2
  Output: KNN with K = 1 result, the closest associated key value pair
  eg capture output:  [{nearest_point, value}] = find_nearest(house,[10.0,10.0], &taxicab_distance/2)
  """
  def find_nearest(list, vector, distance_function) do
    Enum.sort_by(list, fn {k,_v} -> distance_function.(k,vector) end)  |> Enum.take(1)
  end

  @doc"""
  Input: a data list (vector keys and associated values), vector to match, distance function/2, k
  Output: KNN with K = k result, the closest associated key value pair
  eg capture output:  [{nearest_point, value}] = find_nearest(house,[10.0,10.0], &taxicab_distance/2)
  """
  def find_nearest_with_k(list, vector, distance_function, k) do
    Enum.sort_by(list, fn {key,_v} -> distance_function.(key,vector) end)  |> Enum.take(k)
  end



end
