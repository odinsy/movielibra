#!/usr/bin/env ruby

if ARGV.empty?
  puts "There are no arguments!"
  exit
end

path = ARGV.shift

if File.exist?(path)
  movies = File.open(path)
else
  puts "File not found: #{path}"
  exit
end

arr = []

movies.map.each do |movie|
  movie.chomp!
  link, name, year, country, date, genre, duration, rating, director, actors = movie.split("|")
  actors = actors.split(",")
  arr << {name: name, link: link, year: year, country: country, date: date, genre: genre, duration: duration, rating: rating, director: director, actors: actors}
end   

puts "5 longest movies"
puts arr.sort_by { |k| k[:duration].gsub!(/ min/, '').to_i }.last(5)

puts "\nComedy sorted by release date"
puts arr.select { |k| k[:genre].include? "Comedy" }.sort_by { |k| k[:date] }

puts "\nDirector list: "
puts arr.map { |k| k[:director] }.sort.uniq

puts "\nDisplay count of not USA films"
puts arr.reject { |k| k[:country] == "USA" }.count

puts "\nDisplay count of films grouped by director"
puts arr.group_by { |k| k[:director] }.map { |k, v| [k, v.count] }.sort

puts "\nDisplay count of films for every actor"
h = Hash.new(0)
puts arr.map { |k| k[:actors] }.flatten.inject(h) { |acc, n| acc[n] += 1; acc }.sort_by { |k,v| v }.reverse



