#!/usr/bin/env ruby

require './lib/rate_list.rb'

class MyMovieList < MovieList

  include RateList

  def initialize(path)
    @movies = CSV.foreach(path, col_sep: "|").map { |movie| Movie.new(self, movie) }
  end

  def find_movie(name)
    @movies.detect { |movie| movie.name.downcase == name.downcase }
  end

end
