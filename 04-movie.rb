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
    name:     row[1], 
    link:     row[0], 
    year:     row[2], 
    country:  row[3], 
    date:     row[4],
    genre:    row[5], 
    duration: row[6], 
    rating:   row[7], 
    director: row[8], 
    actors:   row[9].split(",")
  ) 
  movies << movie
end

puts "5 longest movies"
puts movies.sort_by { |k| k.duration.gsub!(/ min/, '').to_i }.last(5)

puts "\nComedy sorted by release date"
puts movies.select { |k| k.genre.include? "Comedy" }.sort_by { |k| k.date }

puts "\nDirector list: "
puts movies.map { |k| k.director }.sort_by { |words| words.split(" ").last }.uniq

puts "\nDisplay count of not USA films"
puts movies.reject { |k| k.country == "USA" }.count

puts "\nDisplay count of films grouped by director"
puts movies.group_by { |k| k.director }.map { |k, v| [k, v.count] }.sort

puts "\nDisplay count of films for every actor"
h = Hash.new(0)
puts movies.map { |k| k.actors }.flatten.inject(h) { |acc, n| acc[n] += 1; acc }.sort_by { |k,v| v }.reverse

puts "\nDisplay statistics for month"
f = Hash.new(0)
puts movies.select { |k| k.date.length > 4 }.map { |k| Date.strptime(k.date, '%Y-%m').mon }.inject(f) { |acc, n| acc[n] += 1 ; acc }.sort

