#!/usr/bin/env ruby
require "thor"
require 'movie_libra/cli'
require 'movie_libra/fetcher/imdb'
require 'movie_libra/fetcher/tmdb'
require 'movie_libra/export'

module MovieLibra
  class Fetch < Thor
    DATA_PATH = File.expand_path("../../../../tmp/", __FILE__)

    method_option :csv, type: :string
    method_option :json, type: :string
    desc "imdb", "Fetch the imdb movies. Format can be --json or --csv."
    def imdb
      fetch(MovieLibra::Imdb::Fetcher.new, options)
    end

    method_option :csv, type: :string
    method_option :json, type: :string
    method_option :key, type: :string, required: true
    desc "tmdb", "Fetch the tmdb movies. Pass your API key with --key. Format can be --json or --csv."
    def tmdb
      fetch(MovieLibra::Tmdb::Fetcher.new(options[:key]), options)
    end

    no_commands do
      def fetch(fetcher, options)
        if options[:csv]
          fetcher.run!
          fetcher.save_to_csv("#{DATA_PATH}/movies.csv")
        elsif options[:json]
          fetcher.run!
          fetcher.save_to_json("#{DATA_PATH}/movies.json")
        else
          puts "Format is not correct or is not passed."
        end
      end
    end

  end
end
