#!/usr/bin/env ruby

require './lib/rate_list.rb'

class MyMovieList < MovieList

  include RateList

  def initialize(data)
    data    = [] unless data.is_a?(Array)
    @movies = data.map { |movie| Movie.create(self, movie) }
  end

  def find_movie(name)
    @movies.detect { |movie| movie.name.downcase == name.downcase }
  end

end
