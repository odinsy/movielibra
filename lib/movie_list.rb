#!/usr/bin/env ruby

class MovieList

  attr_accessor :movies

  def initialize
    @movies = []
  end

  def add_movie(movie)
    @movies.push(movie)
  end

  def longest(movies)
    self.sort_by { |k| k.duration.gsub!(/ min/, '').to_i }.last(5)
  end

  def comedy(movies)
    self.select { |k| k.genre.include? "Comedy" }.sort_by(&:date)
  end

  def directors(movies)
    self.map(&:director).sort_by { |words| words.split(" ").last }.uniq
  end

  def count_not_usa(movies)
    self.reject { |k| k.country == "USA" }.count
  end

  def count_by_director(movies)
    self.group_by(&:director).map { |k, v| [k, v.count] }.sort
  end

  def count_by_actor(movies)
    h = Hash.new(0)
    self.map(&:actors).flatten.inject(h) { |acc, n| acc[n] += 1; acc }.sort_by { |k,v| v }.reverse
  end

  def month_stats(movies)
    f = Hash.new(0)
    self.select { |k| k.date.length > 4 }.map { |k| Date.strptime(k.date, '%Y-%m').mon }.inject(f) { |acc, n| acc[n] += 1 ; acc }.sort
  end

end
