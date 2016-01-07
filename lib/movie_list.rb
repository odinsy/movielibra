#!/usr/bin/env ruby

require 'csv'
require './lib/movie.rb'

class MovieList

  attr_accessor :movies, :algos, :filters

  def initialize(path)
    @movies   = CSV.foreach(path, col_sep: "|").map { |movie| Movie.create(self, movie) }
    @algos    = {}
    @filters  = {}
  end

  def print
    @movies.map { |i| puts yield(i) } if block_given?
  end

  def add_sort_algo(algo, &block)
    @algos.store(algo, block)
  end

  def sorted_by(algo=nil, &block)
    if @algos.include?(algo)
      algo = @algos[algo]
      @movies.sort_by(&algo)
    elsif block
      @movies.sort_by(&block)
    else
      raise ArgumentError, "Unknown algorithm #{algo}"
    end
  end

  def add_filter(filter, &block)
    @filters.store(filter, block)
  end

  def filter(attrs)
    attrs.inject(@movies) do |result, (title, value)|
      filter = @filters[title]
      raise ArgumentError, "Unknown filter #{title}" unless filter
      result.select { |movie| filter.call(movie, *value) }
    end
  end

  # Display the longest movies
  def longest(num)
    @movies.sort_by(&:duration).last(num)
  end

  # Display movies selected by genre
  def select_by_genre(genre)
    @movies.select { |k| k.genre.include? genre }.sort_by(&:date)
  end

  # Display all directors sorted by second name
  def directors
    @movies.map(&:director).sort_by { |words| words.split(" ").last }.uniq
  end

  # Display the count of movies without skipped country
  def skip_country(country)
    @movies.reject { |k| k.country == country }.count
  end

  # Display the count of movies by each director
  def count_by_director
    @movies.group_by(&:director).map { |k, v| [k, v.count] }.sort_by { |k,v| v }.reverse
  end

  # Display the movies by director
  def by_director(director)
    @movies.select { |m| m.director == director }.map(&:name)
  end

  # Display the count of movies by each actor
  def count_by_actor
    h = Hash.new(0)
    @movies.map(&:actors).flatten.inject(h) { |acc, n| acc[n] += 1; acc }.sort_by { |k,v| v }.reverse
  end

  # Display the statistics of movies shot each month
  def month_stats
    f = Hash.new(0)
    @movies.map { |k| k.date.mon }.inject(f) { |acc, n| acc[n] += 1 ; acc }.sort
  end

  # Beauty output
  def beauty
    @movies.map { |m| m.humane }
  end

end
