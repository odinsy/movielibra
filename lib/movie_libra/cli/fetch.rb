#!/usr/bin/env ruby
require "thor"
require 'movie_libra/cli'
require 'movie_libra/fetcher/imdb'
require 'movie_libra/fetcher/tmdb'
require 'movie_libra/export'

module MovieLibra
  class Fetch < Thor
    # DATA_PATH = File.expand_path("../../../../tmp/", __FILE__)

    method_option :format, type: :string, aliases: "-f", required: true
    desc "imdb", "Fetch the imdb movies. Format can be --json or --csv."
    def imdb
      fetch(MovieLibra::Fetcher::Imdb.new, options)
    end

    method_option :format, type: :string, aliases: "-f", required: true
    method_option :key, type: :string, required: true
    desc "tmdb", "Fetch the tmdb movies. Pass your API key with --key. Format can be --json or --csv."
    def tmdb
      fetch(MovieLibra::Fetcher::Tmdb.new(options[:key]), options)
    end

    no_commands do
      def fetch(fetcher, options)
        if options[:format] == "csv"
          fetcher.run!
          fetcher.save_to_csv
        elsif options[:format] == "json"
          fetcher.run!
          fetcher.save_to_json
        else
          puts "Format is not correct or is not passed."
        end
      end
    end

  end
end
