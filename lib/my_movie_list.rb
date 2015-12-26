#!/usr/bin/env ruby

class MyMovieList < MovieList

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
        raise "error"
      end
    end
  end

  def rate(name, num)
    movie             = find_movie(name)
    movie.viewed      = true
    movie.my_rating   = num
    movie.date_movie  = Date.today
  end

  def next
    @movies.select { |movie| movie.viewed == false }.sort_by{ |m| [-m.rating * rand, m.class::WEIGHT * rand] }.first(5).each { |m| puts m.description }
  end

  def watched
    @movies.select { |movie| movie.viewed == true }.sort_by{ |m| [-m.my_rating * rand, (Date.today - m.date_movie).to_i * rand] }.first(5).each { |m| puts m.description }
  end

  def find_movie(name)
    @movies.detect { |movie| movie.name.downcase == name.downcase }
  end

  def each
    @movies.each { |m| m }
  end

end
