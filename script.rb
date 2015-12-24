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

=begin
@movies.longest(10)
p @movies.select_by_genre("Comedy")
p @movies.directors
p @movies.skip_country("USA")
p @movies.count_by_director
p @movies.count_by_actor
p @movies.month_stats
=end

@movie = @movies.find_movie("12 Angry Men")
puts @movies.watch(@movie.name, rand(10))
puts @movie.watch(10)
@movies.each { |m| puts m.watch(rand(10)) }

#@movies.beautify
p @movies.next
p @movies.liked
@movies.sorting(@movie)
