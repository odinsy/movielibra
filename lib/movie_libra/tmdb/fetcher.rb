#!/usr/bin/env ruby
# Parse information about movies from themoviedb.org API

require 'json'
require 'csv'
require 'open-uri'
require 'progress_bar'
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

      attr_accessor :list, :ids

      @@api_key = nil

      def initialize
        @list = []
        @ids  = []
      end

      def self.key=(api_key)
        response_code = test_api_key(api_key)
        raise ArgumentError, "Incorrect API key #{api_key}. Response code: #{response_code}." unless response_code == "200"
        @@api_key = api_key
      end

      def self.key
        @@api_key
      end

      def run!(movie_count=DEFAULT_COUNT)
        movie_count = movie_count.to_i
        raise ArgumentError, "You can't set movie_count less than 1!" unless movie_count >= 1
        bar         = ProgressBar.new(movie_count)
        page_count  = (movie_count / 20.0).ceil
        top_movie_ids(page_count).first(movie_count).each { |id| parse(id) ; bar.increment! }
      end

      private

      def self.test_api_key(key)
        Net::HTTP.get_response(URI("#{Fetcher::TMDB_URI}/550?api_key=#{key}")).code
      end

      def top_movie_ids(page_count)
        1.upto(page_count) do |num|
          movies = get("top_rated", num)
          movies[:results].select { |movie| @ids << movie[:id] }
        end
        @ids
      end

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

      def get(path, page=nil)
        path = page.nil? ? "#{TMDB_URI}/#{path}?api_key=#{@@api_key}" : "#{TMDB_URI}/#{path}?api_key=#{@@api_key}&page=#{page}"
        begin
          JSON.parse(open(path).read, symbolize_names: true)
        rescue OpenURI::HTTPError => e
          puts "Passed path is incorrect, status code: #{e.io.status[0]}"
        rescue JSON::ParserError => e
          puts e.message
        end
      end

      def get_imdb_link(imdb_id)
        Fetcher::IMDB_URI + imdb_id
      end

      def get_director(json)
        if director = json[:crew].find { |key| key[:job] == "Director" }
          director[:name]
        else
          nil
        end
      end

      def get_actors(json, count)
        json[:cast].map { |key| key[:name] }.first(count)
      end

    end

  end
end
