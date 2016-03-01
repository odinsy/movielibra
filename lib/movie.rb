#!/usr/bin/env ruby

require 'date'
require './lib/rate.rb'
require 'ostruct'

class Movie

  WEIGHT = 0

  include Rate
  attr_accessor :list, :link, :name, :year, :country, :date, :genre, :duration, :rating, :director, :actors, :my_rating, :view_date

  @@filters = {}

  class << self
    attr_accessor :filters
  end

  def initialize(list=nil, attributes)
    @list       = list
    @link       = attributes[:link]
    @name       = attributes[:name]
    @year       = attributes[:year].to_i
    @country    = attributes[:country]
    @date       = parse_date(attributes[:date])
    @genre      = attributes[:genre].split(",")
    @duration   = attributes[:duration].to_i
    @rating     = attributes[:rating].to_f.round(1)
    @director   = attributes[:director]
    @actors     = attributes[:actors].split(",")
    @my_rating  = 0
    @view_date  = nil
  end

  def method_missing(method_sym, *arguments, &block)
    method = method_sym.to_s.chomp("?").capitalize
    if method_sym.to_s.match(/\w+\?$/)
      has_genre?(method)
    else
      super
    end
  end

  def self.create(list, args)
    p args
    p args["year"]
    p year    = args[:year].to_i
    @movie  = OpenStruct.new(year: year)
    cls     = @@filters.detect { |cls, filter| @movie.instance_eval(&filter) }.first
    cls.new(list, args)
  end

  def self.filter(&block)
    @@filters.store(self, block)
  end

  def self.print_format(format_str)
    define_method(:description) do
      format_str % self.to_h
    end
  end

  def self.weight(arg)
    const_set("WEIGHT", arg)
  end

  class AncientMovie < Movie
    filter { (1900..1944).cover?(year) }
    print_format "%{name} — so old movie (%{year} year)"
    weight 0.3
  end

  class ClassicMovie < Movie
    filter { (1945..1967).cover?(year) }
    print_format "%{name} — the classic movie. The director is %{director}. Maybe you wanna see his other movies? \n%{dir_movie}"
    weight 0.5
  end

  class ModernMovie < Movie
    filter { (1968..1999).cover?(year) }
    print_format "%{name} — modern movie. Starring: %{actors}"
    weight 0.7
  end

  class NewMovie < Movie
    filter { (2000..Date.today.year).cover?(year) }
    print_format "%{name} — novelty!"
    weight 1.0
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

  def has_genre?(genre)
    @genre.include?(genre)
  end

  # Check that movies has genre
  def has_genres?(*genres)
    (@genre - genres).empty?
  end

  # Human readable output
  def inspect
    "\n#{self.class}, name: #{@name}, year: #{@year}, rating: #{@rating}, my_rating: #{@my_rating}, country: #{@country}, date: #{@date}, genre: #{@genre}, duration: #{@duration}, director: #{@director}, actors: #{@actors}, view_date: #{@view_date}"
  end

  def to_h
    {
      dir_movie:  @list.by_director(@director),
      list:       @list,
      name:       @name,
      year:       @year,
      rating:     @rating,
      my_rating:  @my_rating,
      country:    @country,
      date:       @date,
      genre:      @genre,
      duration:   @duration,
      director:   @director,
      actors:     @actors,
      view_date:  @view_date
    }
  end

end
