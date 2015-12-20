#!/usr/bin/env ruby

require 'csv'
require './lib/movie.rb'

class MovieList

  attr_accessor :movies

  def initialize(path)
    @movies = CSV.foreach(path, col_sep: "|").map { |movie| Movie.new(movie) }
  end

  def longest(num)
    @movies.sort_by(&:duration).last(num)
  end

  def sort_by_genre(genre)
    @movies.select { |k| k.genre.include? genre }.sort_by(&:date)
  end

  def directors
    @movies.map(&:director).sort_by { |words| words.split(" ").last }.uniq
  end

  def count_by_country(country)
    @movies.reject { |k| k.country == country }.count
  end

  def count_by_director
    @movies.group_by(&:director).map { |k, v| [k, v.count] }.sort_by { |k,v| v }.reverse
  end

  def count_by_actor
    h = Hash.new(0)
    @movies.map(&:actors).flatten.inject(h) { |acc, n| acc[n] += 1; acc }.sort_by { |k,v| v }.reverse
  end

  def month_stats
    f = Hash.new(0)
    @movies.map { |k| k.date.mon }.inject(f) { |acc, n| acc[n] += 1 ; acc }.sort
  end

end
