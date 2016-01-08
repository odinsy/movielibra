#!/usr/bin/env ruby

require 'date'
require './lib/rate.rb'
require 'ostruct'

class Movie

  include Rate
  attr_accessor :link, :name, :year, :country, :date, :genre, :duration, :rating, :director, :actors, :my_rating, :view_date

  @@filters = {}

  class << self
    attr_accessor :filters
  end

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

  def self.create(list, attrs)
    @movie = OpenStruct.new(year: attrs[2].to_i)
    cls = @@filters.detect { |cls, filter| @movie.instance_eval(&filter) }
    cls[0].new(list, attrs)
  end

  def self.filter(&block)
    @@filters.store(self, block)
  end

  class AncientMovie < Movie
    WEIGHT  = 30
    filter { (1900..1944).cover?(year) }

    def description
      "#{@name} — so old movie (#{@year} year)"
    end
  end

  class ClassicMovie < Movie
    WEIGHT  = 50
    filter { (1945..1967).cover?(year) }

    def description
      "#{@name} — the classic movie. The director is #{@director}. Maybe you wanna see his other movies? \n#{@list.by_director(@director)}"
    end
  end

  class ModernMovie < Movie
    WEIGHT  = 70
    filter { (1968..1999).cover?(year) }

    def description
      "#{@name} — modern movie. Starring: #{@actors}"
    end
  end

  class NewMovie < Movie
    WEIGHT  = 100
    filter { (2000..Date.today.year).cover?(year) }

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

  # Check the movie for viewing
  def viewed?
    !@view_date.nil?
  end

  # Check that movies has genre
  def has_genre?(*genres)
    #@genre.any? { |genre| genres.include?(genre) }
    (@genre - genres).empty?
  end

  # Human readable output
  def inspect
    "\nName: #{@name}, year: #{@year}, rating: #{@rating}, my_rating: #{@my_rating}, country: #{@country}, date: #{@date}, genre: #{@genre}, duration: #{@duration}, director: #{@director}, actors: #{@actors}, view_date: #{@view_date}"
  end

end
