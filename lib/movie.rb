#!/usr/bin/env ruby

require 'date'

class Movie

  attr_accessor :link, :name, :year, :country, :date, :genre, :duration, :rating, :director, :actors, :my_rating, :viewed, :date_movie

  def initialize(parent, attributes)
    @link, @name, @year, @country, @date, @genre, @duration, @rating, @director, @actors = attributes
    @parent     = parent
    @year       = @year.to_i
    @date       = parse_date(@date)
    @genre      = @genre.split(",")
    @duration   = @duration.gsub!(/ min/, '').to_i
    @rating     = @rating.to_f.round(1)
    @actors     = @actors.split(",")
    @my_rating  = 0
    @viewed   = false
    @date_movie = nil
  end

  class AncientMovie < Movie
    WEIGHT = 30

    def description
      "#@name — so old movie (#@year year)"
    end
  end

  class ClassicMovie < Movie
    WEIGHT = 50

    def description
      "#@name — the classic movie. The director is #@director. Maybe you wanna to see his other movies? \n#{@parent.by_director(@director)}"
    end
  end

  class ModernMovie < Movie
    WEIGHT = 70

    def description
      "#@name — modern movie. Starring: #@actors"
    end
  end

  class NewMovie < Movie
    WEIGHT = 100

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
    puts "\nName: #@name, year: #@year, rating: #@rating, my_rating: #@my_rating, country: #@country, date: #@date, genre: #@genre, duration: #@duration, director: #@director, actors: #@actors, date_movie: #@date_movie, viewed: #@viewed"
  end

end
