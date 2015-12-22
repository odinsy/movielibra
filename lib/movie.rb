#!/usr/bin/env ruby

require 'date'

class Movie

  attr_accessor :link, :name, :year, :country, :date, :genre, :duration, :rating, :director, :actors, :my_rating, :viewed

  def initialize(movie)
    @link, @name, @year, @country, @date, @genre, @duration, @rating, @director, @actors = movie
    @year       = @year.to_i
    @date       = parse_date(@date)
    @genre      = @genre.split(",")
    @duration   = @duration.gsub!(/ min/, '').to_i
    @rating     = @rating.to_f.round(1)
    @actors     = @actors.split(",")
    @my_rating  = 0
    @viewed     = false
  end

  # Parse the date
  def parse_date(date)
    fmt = case date.length
    when 0..4
      '%Y'
    when 5..7
      '%Y-%m'
    else
      '%Y-%m-%d'
    end
    Date.strptime(date, fmt)
  end

  def humanize
    "Movie: #{@name}, #{@year}, #{@country}, #{@date}, #{@genre}, #{@duration}, #{@rating}, #{@director}, #{@actors}"
  end

end
