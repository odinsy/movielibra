#!/usr/bin/env ruby

class MyMovieList < MovieList

  def classify(movie)
    case movie.date.to_s.to_i
    when 1900..1944
      Movie::AncientMovie.new(movie)
    when 1945..1967
      Movie::ClassicMovie.new(movie)
    when 1968..1999
      Movie::ModernMovie.new(movie)
    when 2000..Date.today.year
      Movie::NewMovie.new(movie)
    else
      raise "error"
    end
  end

  def watch(name, num)
    movie             = find_movie(name)
    movie.viewed      = true
    movie.my_rating   = num
    movie.date_movie  = Date.today
  end

  def next
    @movies.select { |movie| movie.viewed == false }.sort_by{ |m| -m.rating * rand }.first(5)
  end

  def liked
    @movies.select { |movie| movie.viewed == true }.sort_by{ |m| [-m.my_rating * rand, (Date.today - m.date_movie).to_i * rand] }.first(5)
  end

  def find_movie(name)
    @movies.detect { |movie| movie.name.downcase == name.downcase }
  end

  def each
    @movies.each { |m| m }
  end

end
