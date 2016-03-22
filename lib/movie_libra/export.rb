#!/usr/bin/env ruby

# Module which provides a possibility for save an object to JSON or CSV.
module MovieLibra
  module Export
    # Exports array with movie hashes to JSON
    # @return [String]  the filename
    def save_to_json(filename = './data/movies.json')
      File.open(filename, 'w+') { |f| f.puts list.to_json }
      filename
    end

    # Exports array with movie hashes to CSV
    # @return [String]  the filename
    def save_to_csv(filename = './data/movies.csv')
      CSV.open(filename, 'w+', col_sep: '|') do |file|
        file << list.first.keys
        list.each do |m|
          file << m.values.map { |v| v.is_a?(Array) ? v.join(',') : v }
        end
      end
      filename
    end
  end
end
