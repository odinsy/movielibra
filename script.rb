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

p @movie = @movies.find_movie("12 Angry Men")
p @movies.watch(@movie.name, rand(10))
#p @movie
#p @movies.beautify
p @movies.each { |m| m.watch(rand(10)) }
#@movies.map { |m| set_viewed(m.name) }
#p @movie
#@movies.beautify
#p @movies.next
#@movies.liked
