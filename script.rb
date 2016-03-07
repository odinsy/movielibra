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

# imdb_fetcher = IMDBFetcher.new
# imdb_fetcher.run!
# imdb_fetcher.save_to_json("movies.json")
# imdb_fetcher.save_to_csv("movies.csv")

TmdbFetcher.key = "dd165b18174b238eb2af5a0c3552f2f3"
TmdbFetcher.movie_count 30
tmdb_fetcher = TmdbFetcher.new
tmdb_fetcher.run!
tmdb_fetcher.save_to_json("movies.json")
tmdb_fetcher.save_to_csv("movies.csv")

#@movies = MovieList.load_csv(path)
# @movies = MovieList.load_json(path)

# @movies = MyMovieList.load_csv(path)
# @movies = MyMovieList.load_json(path)
# p @movies
# p @movies
# @movies.rate("12 Angry Men", 7)
# @movie = @movies.find_movie("12 Angry Men")
# p @movies.watched
# Movie::AncientMovie.filter { (1900..1944).cover?(year) }
# p Movie.filters
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
@movies.recommend
puts "\nWatched movies:"
@movies.watched

# Check that movies has genre
#p @movie.has_genres?("Crime", "Drama")

# Print and algorithms
@movies.print { |movie| "#{movie.year}: #{movie.name}" }
@movies.add_sort_algo(:genres_years) { |movie| [movie.genre, movie.year] }
puts @movies.algos
p @movies.sorted_by { |movie| [movie.genre, movie.year] }.first(5)
p @movies.sorted_by(:genres_years).first(5)

# Filters
@movies.add_filter(:genres) { |movie, *genres| movie.has_genres?(*genres) }
@movies.add_filter(:rating_greater) { |movie, rating| movie.rating > rating }
@movies.add_filter(:years) { |movie, from, to| (from..to).include?(movie.year) }
p @movies.filters
p @movies.filter(
    genres: ['Comedy', 'Drama'],
    years: [2005, 2010],
    rating_greater: 8
)
=end

# Metaprogramming
#p Object.const_get("Movie::AncientMovie::WEIGHT")
#@movies.print { |movie| "#{movie.year}: #{movie.name}, #{movie.description}" }
#p @movies.recommend.reject(&:drama?)
#p @movies.recommend.select(&:comedy?)
#p @movies.recommend.reject(&:wtf)
