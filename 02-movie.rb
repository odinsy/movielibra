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

hash = Hash.new {|key, value| key[value]={}} 

movies.readlines.each do |movie|
  movie.chomp!
  link, name, year, country, date, genre, duration, rating, director, actors = movie.split("|")
  hash[name] = { link: link, year: year, country: country, date: date, genre: genre, duration: duration, rating: rating, director: director, actors: actors }
end   

hash.each do |key, value|
  if key.include? "Time"
    puts key
    puts "*" * (value[:rating].to_f.modulo(8).round(1) * 10)
  end
end 
