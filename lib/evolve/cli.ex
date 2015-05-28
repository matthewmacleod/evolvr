defmodule Evolve.CLI do
  def main(args) do
    args
      |> parse_args
      |> process
  end

  def process(input) do
    options = input
    IO.puts "Running evolve bioinformatics program..."
    IO.puts " using these options:"
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
    kmers = Evolve.Bio.get_kmers(seq,ik)
    IO.puts "getting kmers for k = #{k}..."
    print(kmers)
    vertical_print(kmers)
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
