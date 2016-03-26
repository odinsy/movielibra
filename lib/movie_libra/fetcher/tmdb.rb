#!/usr/bin/env ruby
# Parse information about movies from themoviedb.org API

require 'json'
require 'csv'
require 'open-uri'
require 'ruby-progressbar'
require 'uri'
require 'net/http'
require 'movie_libra/export.rb'

module MovieLibra
  module Tmdb
    class Fetcher

      include Export

      IMDB_URI    = "http://www.imdb.com/title/"
      TMDB_URI    = "http://api.themoviedb.org/3/movie"
      DEFAULT_COUNT = 250

      attr_accessor :list, :ids, :key

      def initialize(api_key = nil)
        @key  = api_key
        @list = []
        @ids  = []
      end
      # Just tests your TMDB API key
      def test_api_key(key = @key)
        response_code = Net::HTTP.get_response(URI("#{TMDB_URI}/550?api_key=#{key}")).code
        raise ArgumentError, "Incorrect API key #{key}. Response code: #{response_code}." unless response_code == "200"
      end
      # Runs parser of top TMDB movies from API http://api.themoviedb.org/3
      def run!(movie_count = DEFAULT_COUNT)
        test_api_key
        movie_count = movie_count.to_i
        raise ArgumentError, "You can't set movie_count less than 1!" unless movie_count >= 1
        bar         = ProgressBar.create(total: movie_count)
        page_count  = (movie_count / 20.0).ceil
        top_movie_ids(page_count).first(movie_count).each { |id| parse(id) && bar.increment }
        self
      end

      def inspect
        "#{self.class} (#{@list.count} movies)"
      end

      private
      # Gets top movie IDs
      def top_movie_ids(page_count)
        1.upto(page_count) do |num|
          movies = get("top_rated", num)
          movies[:results].select { |movie| @ids << movie[:id] }
        end
        @ids
      end
      # Parse information about movies
      def parse(id)
        movie   = get("#{id}")
        credits = get("#{id}/credits")
        @list << {
          link:     get_imdb_link(movie[:imdb_id]),
          name:     movie[:title],
          year:     Date.strptime(movie[:release_date], '%Y').year,
          country:  movie[:production_countries].map { |key| key[:iso_3166_1] }.first,
          date:     movie[:release_date],
          genre:    movie[:genres].map { |key| key[:name] },
          duration: movie[:runtime],
          rating:   movie[:vote_average],
          director: get_director(credits),
          actors:   get_actors(credits, 5)
        }
      end
      # Parses the passed page with your API key
      def get(path, page = nil)
        path = page.nil? ? "#{TMDB_URI}/#{path}?api_key=#{@key}" : "#{TMDB_URI}/#{path}?api_key=#{@key}&page=#{page}"
        begin
          JSON.parse(open(path).read, symbolize_names: true)
        rescue OpenURI::HTTPError => e
          puts "Passed path is incorrect, status code: #{e.io.status[0]}"
        rescue JSON::ParserError => e
          puts e.message
        end
      end
      # Gets full link by imdb_id
      def get_imdb_link(imdb_id)
        IMDB_URI + imdb_id
      end
      # Gets director of the movie to JSON
      def get_director(json)
        if director = json[:crew].find { |key| key[:job] == "Director" }
          director[:name]
        else
          nil
        end
      end
      # Gets count actors of the movie to JSON
      def get_actors(json, count)
        json[:cast].map { |key| key[:name] }.first(count)
      end

    end
  end
end
