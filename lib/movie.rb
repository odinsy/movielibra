#!/usr/bin/env ruby

require 'date'
require './lib/rate.rb'

class Movie

  include Rate
  attr_accessor :link, :name, :year, :country, :date, :genre, :duration, :rating, :director, :actors, :my_rating, :view_date

  def initialize(list, attributes)
    @link, @name, @year, @country, @date, @genre, @duration, @rating, @director, @actors = attributes
    @list       = list
    @year       = @year.to_i
    @date       = parse_date(@date)
    @genre      = @genre.split(",")
    @duration   = @duration.gsub!(/ min/, '').to_i
    @rating     = @rating.to_f.round(1)
    @actors     = @actors.split(",")
    @my_rating  = 0
    @view_date  = nil
  end

  class AncientMovie < Movie
    WEIGHT = 30

    def description
      "#{@name} — so old movie (#{@year} year)"
    end
  end

  class ClassicMovie < Movie
    WEIGHT = 50

    def description
      "#{@name} — the classic movie. The director is #{@director}. Maybe you wanna see his other movies? \n#{@list.by_director(@director)}"
    end
  end

  class ModernMovie < Movie
    WEIGHT = 70

    def description
      "#{@name} — modern movie. Starring: #{@actors}"
    end
  end

  class NewMovie < Movie
    WEIGHT = 100

    def description
      "#{@name} — novelty!"
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

  # Check the film for viewing
  def viewed?
    !@view_date.nil?
  end

  # Human readable output
  def inspect
    "\nName: #{@name}, year: #{@year}, rating: #{@rating}, my_rating: #{@my_rating}, country: #{@country}, date: #{@date}, genre: #{@genre}, duration: #{@duration}, director: #{@director}, actors: #{@actors}, view_date: #{@view_date}"
  end

end
