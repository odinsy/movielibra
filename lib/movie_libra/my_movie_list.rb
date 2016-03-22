#!/usr/bin/env ruby

require 'movie_libra/rate_list.rb'

module MovieLibra
  # MyMovieList class
  # @example
  #   list = MyMovieLibra::MovieList.load_json('data/movies.json')
  #   list = MyMovieLibra::MovieList.load_csv('data/movies.csv')
  class MyMovieList < MovieList
    include RateList

    # Creates a new MyMovieLibra::MovieList object
    # @param [Array] data   Array of the movie hashes
    def initialize(data)
      data    = [] unless data.is_a?(Array)
      @movies = data.map { |movie| Movie.create(self, movie) }
    end

    # Finds movie by name
    # @return [MovieLibra::Movie] movie information
    # @example
    #   list.find_movie("The Shawshank Redemption")
    def find_movie(name)
      @movies.detect { |movie| movie.name.casecmp(name.downcase).zero? }
    end
  end
end
