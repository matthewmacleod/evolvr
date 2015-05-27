defmodule Evolve.Bio do
  @moduledoc """
  A collection of bioinformatics algorithms.
  """

  defp get_all_kmers("", _k) do
    []
  end

  defp get_all_kmers(seq, k) do
    ht = String.split_at(seq, k)
    head = elem(ht, 0)
    htt = String.split_at(seq, 1)
    tail = elem(htt, 1)
    [ head | get_all_kmers(tail, k) ]
  end

  @doc"""
  Returns a list of kmers.
  """
  def get_kmers(seq, k) do
    ks = get_all_kmers(seq, k)
    Enum.filter(ks, fn(x) -> String.length(x) == k end)
  end

  defp count_pattern([], _pattern, total) do
    total
  end

  defp count_pattern(kmers, pattern, total) do
    [head | tail] = kmers
    if head == pattern do
      count_pattern(tail, pattern, total+1)
    else
      count_pattern(tail, pattern, total)
    end
  end


  @doc"""
  Returns number of times a pattern occurs in one sequence,
  including overlapping occurences.
  """
  def pattern_count(seq, pattern) do
    k = String.length(pattern)
    kmers = get_kmers(seq, k)
    count_pattern(kmers, pattern, 0)
  end


  @doc"""
  Returns a list of the most frequent words (kmers) in a sequence.
  """
  def frequent_words(seq, k) do
    seq
  end

end


