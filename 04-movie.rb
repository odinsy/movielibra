#!/usr/bin/env ruby

require 'csv'
require 'ostruct'
require 'date'

if ARGV.empty? 
  puts "There are no arguments!"
  exit
end

path = ARGV.shift

unless File.exist?(path)
  puts "File not found: #{path}"
  exit
end

movies = []

CSV.foreach(path, col_sep: "|") do |row|
  movie = OpenStruct.new(
    name: row[1], 
    link: row[0], 
    year: row[2], 
    country: row[3], 
    date: row[4],
    genre: row[5], 
    duration: row[6], 
    rating: row[7], 
    director: row[8], 
    actors: row[9].split(",")
  ) 
  movies << movie
end
h = Hash.new(0)
puts movies.select { |k| k.date.length > 4 }.map { |k| Date.strptime(k.date, '%Y-%m').mon }.inject(h) { |acc, n| acc[n] += 1 ; acc }.sort


