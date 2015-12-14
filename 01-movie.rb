#!/usr/bin/env ruby
good_films = ["Matrix", "Star Wars"]
bad_films = ["Titanic", "Scream"]
film = ARGV.shift

if good_films.any? { |x| x.downcase == film.downcase }
  puts "#{film} is a good movie"
elsif bad_films.map(&:downcase).include?(film.downcase)
  puts "#{film} is a bad movie"
else
  puts "Haven't seen #{film} yet"
end
