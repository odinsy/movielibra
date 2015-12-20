#!/usr/bin/env ruby

class Movie

  attr_accessor :link, :name, :year, :country, :date, :genre, :duration, :rating, :director, :actors

  def initialize(&block)
    instance_eval(&block)
  end

end
