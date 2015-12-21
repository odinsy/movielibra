#!/usr/bin/env ruby

Dir["./lib/*.rb"].each {|file| require file }

if ARGV.empty?
  puts "There are no arguments!"
  exit
end

path = ARGV.shift

unless File.exist?(path)
  puts "File not found: #{path}"
  exit
end

movies = MovieList.new(path)

p movies.longest(10)
p movies.select_by_genre("Comedy")
p movies.directors
p movies.skip_country("USA")
p movies.count_by_director
p movies.count_by_actor
p movies.month_stats
