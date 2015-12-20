#!/usr/bin/env ruby

require 'date'

class Movie

  attr_accessor :link, :name, :year, :country, :date, :genre, :duration, :rating, :director, :actors

  def initialize(movie)
    @link, @name, @year, @country, @date, @genre, @duration, @rating, @director, @actors = movie
    @year =     @year.to_i
    @date =     parse_date(@date)
    @genre =    @genre.split(",")
    @duration = @duration.gsub!(/ min/, '').to_i
    @actors =   @actors.split(",")
  end

  def parse_date(date)
    if date.length < 5
      Date.strptime(date, '%Y')
    elsif date.length < 8
      Date.strptime(date, '%Y-%m')
    else
      Date.strptime(date, '%Y-%m-%d')
    end
  end

end
