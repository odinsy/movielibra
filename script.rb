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

@movies = MyMovieList.new(path)
@movie = @movies.find_movie("12 Angry Men")

=begin
@movies.longest(10)
p @movies.select_by_genre("Comedy")
p @movies.directors
p @movies.skip_country("USA")
p @movies.count_by_director
p @movies.count_by_actor
p @movies.month_stats
=end

@movie.rate(10)
puts "\nNot seen movies:"
@movies.next
puts "\nWatched movies:"
@movies.watched
