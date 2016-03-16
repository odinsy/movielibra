#!/usr/bin/env ruby

module Export
  # Export array with movie hashes to JSON
  def save_to_json(filename="./data/movies.json")
    File.open(filename, "w+") { |f| f.puts @list.to_json }
  end
  # Export array with movie hashes to CSV
  def save_to_csv(filename="./data/movies.csv")
    CSV.open(filename, "w+", col_sep: "|") do |file|
      file << @list.first.keys
      @list.each do |m|
        file << m.values.map { |v| v.kind_of?(Array) ? v.join(',') : v }
      end
    end
  end

end
