#!/usr/bin/env ruby

require 'date'

class Movie

  attr_accessor :link, :name, :year, :country, :date, :genre, :duration, :rating, :director, :actors, :my_rating, :viewed, :date_movie

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
    @date_movie = nil
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
    Date.strptime(date, fmt).strftime("%Y-%m-%d")
  end

  def watch(num)
    if num > 10 || num < 0
      puts "You can rate film only from 0 to 10!"
      exit
    end
    @viewed = true
    @date_movie = Date.today.strftime("%Y-%m-%d")
    @my_rating = num.to_i
  end

  def humanize
    "Movie: #{@name}, #{@year}, #{@rating}, #{@my_rating}, #{@country}, #{@date}, #{@genre}, #{@duration}, #{@director}, #{@actors}, #{@date_movie}, #{@viewed}"
  end

end
