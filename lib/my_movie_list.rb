#!/usr/bin/env ruby

require './lib/rate_list.rb'

class MyMovieList < MovieList

  include RateList

  def initialize(path)
    @movies = CSV.foreach(path, col_sep: "|").map do |movie|
      case movie[4].to_s.to_i
      when 1900..1944
        Movie::AncientMovie.new(self, movie)
      when 1945..1967
        Movie::ClassicMovie.new(self, movie)
      when 1968..1999
        Movie::ModernMovie.new(self, movie)
      when 2000..Date.today.year
        Movie::NewMovie.new(self, movie)
      else
        raise ArgumentError, "Unexpected movie year: #{movie[4]}"
      end
    end
  end

  def find_movie(name)
    @movies.detect { |movie| movie.name.downcase == name.downcase }
  end

end
