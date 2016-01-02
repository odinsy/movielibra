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

@movies = MovieList.new(path)
#@movies = MyMovieList.new(path)
#@movie = @movies.find_movie("12 Angry Men")

=begin
@movies.longest(10)
p @movies.select_by_genre("Comedy")
p @movies.directors
p @movies.skip_country("USA")
p @movies.count_by_director
p @movies.count_by_actor
p @movies.month_stats

@movie.rate(Date.today, 10)
puts "\nNot seen movies:"
@movies.next
puts "\nWatched movies:"
@movies.watched
=end

#@movies.print { |movie| "#{movie.year}: #{movie.name}" }
#@movies.sorted_by { |movie| [movie.genre, movie.year] }
@movies.add_sort_algo(:genres_years) { |movie| [movie.genre, movie.year] }
puts @movies.algos
#@movies.sorted_by { |movie| [movie.genre, movie.year] }
@movies.sorted_by(:genres_years)
