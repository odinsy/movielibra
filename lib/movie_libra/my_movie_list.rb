#!/usr/bin/env ruby

require 'movie_libra/rate_list.rb'

module MovieLibra
  # MyMovieList class
  # @example
  #   list = MyMovieLibra::MyMovieList.new('data/movies.json')
  class MyMovieList < MovieList
    include RateList

    # Creates a new MyMovieLibra::MovieList object
    # @param [String] path    Path to your CSV or JSON file
    def initialize(path)
      super
      @movies = load_data(path).map { |movie| Movie.create(self, movie) }
    end
  end
end
