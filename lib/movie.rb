#!/usr/bin/env ruby

require 'date'

class Movie

  attr_accessor :link, :name, :year, :country, :date, :genre, :duration, :rating, :director, :actors

  def initialize(movie)
    @name =     movie[1]
    @link =     movie[0]
    @year =     movie[2].to_i
    @country =  movie[3]
    @date =     if movie[4].length < 5
                  Date.strptime(movie[4], '%Y')
                elsif movie[4].length < 8
                  Date.strptime(movie[4], '%Y-%m')
                else
                  Date.strptime(movie[4], '%Y-%m-%d')
                end
    @genre =    movie[5].split(",")
    @duration = movie[6].gsub!(/ min/, '').to_i
    @rating =   movie[7]
    @director = movie[8]
    @actors =   movie[9].split(",")
  end
#
end
