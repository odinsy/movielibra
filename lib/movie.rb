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

  class AncientMovie < Movie
    weight = 30

    def description
      "#@name — so old movie (#@date year)"
    end
  end

  class ClassicMovie < Movie
    weight = 50

    def description
      "#@name — the classic movie. The director is #@director. Maybe you wanna to see his other movies? "
    end
  end

  class ModernMovie < Movie
    weight = 70

    def description
      "#@name — modern movie. Starring #@actors"
    end
  end

  class NewMovie < Movie
    weight = 100

    def description
      "#@name — novelty!"
    end
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

  # Make viewed and rate movie
  def watch(num)
    unless (0..10).include?(num)
      raise ArgumentError, "You can rate film only from 0 to 10!"
    end
    @viewed     = true
    @date_movie = Date.today
    @my_rating  = num.to_i
  end

  def humane
    "Movie: #@name, #@year, #@rating, #@my_rating, #@country, #@date, #@genre, #@duration, #@director, #@actors, #@date_movie, #@viewed"
  end

end
