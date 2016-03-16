#!/usr/bin/env ruby
require "thor"
require 'movie_libra/cli'
require 'movie_libra/imdb/fetcher'
require 'movie_libra/tmdb/fetcher'
require 'movie_libra/export'

module MovieLibra
  class Fetch < Thor
    DATA_PATH = File.expand_path("../../../../tmp/", __FILE__)

    method_option :csv, type: :string
    method_option :json, type: :string

    desc "imdb", "Fetch the imdb movies. Format can be --json or --csv."
    def imdb
      @fetcher = MovieLibra::Imdb::Fetcher.new
      if options[:csv]
        @fetcher.run!
        @fetcher.save_to_csv("#{DATA_PATH}/movies.csv")
      elsif options[:json]
        @fetcher.run!
        @fetcher.save_to_json("#{DATA_PATH}/movies.json")
      else
        puts "Format is not correct or is not passed."
      end
    end

    desc "tmdb", "Fetch the tmdb movies. Format can be --json or --csv."
    def tmdb
      if options[:csv]
        @fetcher = MovieLibra::Tmdb::Fetcher.new
        @fetcher.run!
        @fetcher.save_to_csv("#{DATA_PATH}/movies.csv")
      elsif options[:json]
        @fetcher = MovieLibra::Tmdb::Fetcher.new
        @fetcher.run!
        @fetcher.save_to_json("#{DATA_PATH}/movies.json")
      else
        puts "Format is not correct or is not passed."
      end
    end
  end
end
