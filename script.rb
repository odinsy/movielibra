#!/usr/bin/env ruby

Dir["./lib/*.rb"].each {|file| require file }

movies = MovieList.new
movie = Movie.new()
movies.add_movie(movie)
p movies
