#!/usr/bin/env ruby
require "thor"
require 'movie_libra/cli'
require 'movie_libra/imdb/fetcher'
require 'movie_libra/tmdb/fetcher'
require 'movie_libra/export'

module MovieLibra
  class Fetch < Thor
    method_option :csv, type: :string
    method_option :json, type: :string

    desc "imdb", "Fetch the imdb movies. Format can be --json or --csv."
    def imdb
      @fetcher = MovieLibra::Imdb::Fetcher.new
      if options[:csv]
        @fetcher.run!
        @fetcher.save_to_csv
      elsif options[:json]
        @fetcher.run!
        @fetcher.save_to_json
      else
        puts "Incorrect format."
      end
    end

    desc "tmdb", "Fetch the tmdb movies. Format can be --json or --csv."
    def tmdb
      @fetcher = MovieLibra::Tmdb::Fetcher.new
      @fetcher.run!
      if options[:csv]
        @fetcher.save_to_csv
      elsif options[:json]
        @fetcher.save_to_json
      else
        puts "Incorrect format."
      end
    end
  end
end
