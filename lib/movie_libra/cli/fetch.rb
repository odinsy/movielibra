#!/usr/bin/env ruby
require "thor"
require 'movie_libra/imdb/fetcher'
require 'movie_libra/tmdb/fetcher'

module MovieLibra
  module CLI
    class Fetch < Thor
      desc "imdb", "Fetch the imdb movies."
      def imdb
        @fetcher = MovieLibra::Imdb::Fetcher.new
        @fetcher.run!
      end

      desc "tmdb", "Fetch the tmdb movies."
      def tmdb
        @fetcher = MovieLibra::Tmdb::Fetcher.new
        @fetcher.run!
      end
    end
  end
end
