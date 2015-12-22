#!/usr/bin/env ruby

class MyMovieList < MovieList

  def set_viewed(name)
    movie = find_movie(name)
    movie.viewed = true
  end

  def rate(name, num)
    if num > 10 || num < 0
      puts "You can rate film only from 0 to 10!"
      exit
    end
    movie = find_movie(name)
    movie.my_rating = num
  end

  def next
    @movies.select { |movie| movie.viewed == false }.sort_by{ |m| -m.rating * rand }.first(5)
  end

  def find_movie(name)
    @movies.detect { |movie| movie.name.downcase == name.downcase }
  end

end
