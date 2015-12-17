defmodule Evolvr.CLI do
  def main(args) do
    args
      |> parse_args
      |> process
  end

  def process(input) do
    options = input
    IO.puts "Running evolvr bioinformatics program..."
    IO.puts "\tusing these options:"
    IO.inspect options
    IO.puts "input file = "
    IO.inspect  options[:input]
    infile = options[:input]

    data = File.read!(infile)
    IO.inspect data
    cdata = String.replace(data, "\n", "")
    data_list = String.split(cdata, "\r", trim: true)
    IO.inspect data_list

    [seq,k] = data_list
    ik = String.to_integer(k)
    IO.inspect seq

    IO.puts "\tgetting frequent words for k = #{k}..."
    kmers = Evolvr.Bio.frequent_words(seq,ik)
    print(kmers)
  end


  defp print_map(m) do
    #m |> Dict.keys |> Enum.map(fn(x) ->  Atom.to_string(x) |> String.upcase end) |> vertical_print
    m |> Dict.keys |> Enum.map(fn(x) ->  Atom.to_string(x) |> String.upcase end) |> print
  end

  defp print(my_list) do
    IO.puts Enum.join(my_list," ")
  end

  defp vertical_print(my_list) do
    IO.puts Enum.join(my_list,"\n")
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args,
      switches: [n: :integer, url: :string]
    )
    options
  end

end
