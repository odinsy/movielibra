#!/usr/bin/env ruby

class MyMovieList < MovieList

  def watch(name, num)
    movie             = find_movie(name)
    movie.viewed      = true
    movie.date_movie  = Date.today.strftime("%Y-%m-%d")
    movie.my_rating   = num
  end

  def next
    @movies.select { |movie| movie.viewed == false }.sort_by{ |m| -m.rating * rand }.first(5)
  end

  def liked
    @movies.select { |movie| movie.viewed == true }.sort_by{ |m| p [-m.my_rating * rand, (Date.today - m.date_movie).to_i * rand] }.first(5)
  end

  def find_movie(name)
    @movies.detect { |movie| movie.name.downcase == name.downcase }
  end

  def each
    @movies.each { |m| m }
  end

end
