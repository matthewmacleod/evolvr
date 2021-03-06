defmodule Evolvr.Bio do
  @moduledoc """
  A collection of bioinformatics algorithms.
  """

  @doc"""
  Returns a list of kmers.
  """
  def get_kmers(seq, k) do
    ks = get_all_kmers(seq, k)
    Enum.filter(ks, fn(x) -> String.length(x) == k end)
  end

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
  Returns number of times a pattern occurs in one sequence,
  including overlapping occurences.
  """
  def pattern_count(seq, pattern) do
    k = String.length(pattern)
    kmers = get_kmers(seq, k)
    count_pattern(kmers, pattern, 0)
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
  Returns a list of the most frequent words (kmers) in a sequence.
  """
  def frequent_words(seq, k) do
    frequent_words_map(seq, k, %{})
    |> most_frequent(k)
    |> to_string_list
  end

  defp clean_map(map,k) do
    map |> Enum.filter(fn(x) -> elem(x,0) |> Atom.to_string |> String.length == k end)
  end

  defp most_frequent(map,k) do
    map = clean_map(map,k) # this is temp, since now head_kmer runs too many times
    #max_freq = Enum.max(map) |> elem(1)
    max_freq = Enum.max_by(map, fn(x) -> elem(x,1) end) |> elem(1)
    map |> Enum.filter(fn(x) -> elem(x,1) == max_freq end)
  end

  defp to_string_list(map) do
    map |> Dict.keys |> Enum.map(fn(x) -> Atom.to_string(x) |> String.upcase end)
  end

  defp get_head_kmer(seq, k) do
    seq |> String.slice(0..k-1) |> String.downcase |> String.to_atom
  end

  defp frequent_words_map("", _k, map) do
    map
  end

  defp frequent_words_map(seq, k, map) do
    tail = String.split_at(seq,1) |> elem(1)
    kmer = get_head_kmer(seq, k)
    if Map.has_key?(map, kmer) do
      new_value = map[kmer] + 1
      map = put_in(map[kmer], new_value)
    else
      map = Dict.put_new(map, kmer, 1)
    end
    frequent_words_map(tail, k, map)
  end



end


