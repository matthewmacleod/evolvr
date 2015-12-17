defmodule Evolvr.Basics do
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

  def compress(list), do: compress(list,[])
  defp compress([],result), do: Enum.reverse(result)

  defp compress([a,a|tail], result) do
    compress([{a,2}|tail], result)
  end

  defp compress([{a,n}, a | tail], result) do
   compress([{a,n+1}|tail], result)
  end

  defp compress([a | tail], result) do
    compress(tail, [a | result])
  end


  ### print functions ###






end


