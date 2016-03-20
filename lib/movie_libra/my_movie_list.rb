#!/usr/bin/env ruby

require 'movie_libra/rate_list.rb'

module MovieLibra
  class MyMovieList < MovieList
    include RateList

    def initialize(data)
      data    = [] unless data.is_a?(Array)
      @movies = data.map { |movie| Movie.create(self, movie) }
    end

    def find_movie(name)
      @movies.detect { |movie| movie.name.casecmp(name.downcase).zero? }
    end
  end
end
