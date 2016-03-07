#!/usr/bin/env ruby
# Parse information about movies from themoviedb.org API

require 'json'
require 'csv'
require 'open-uri'
require 'progress_bar'
require './lib/export.rb'

class TmdbFetcher

  include Export

  IMDB_URI  = "http://www.imdb.com/title/"
  MOVIE_URI = "http://api.themoviedb.org/3/movie"
  TOP_RATED = "http://api.themoviedb.org/3/movie/top_rated"

  attr_accessor :list, :ids, :count_page

  @@api_key = nil

  def initialize
    @list = []
    @ids  = []
    @count_page = 12
  end

  def self.key=(api_key)
    @@api_key = api_key
  end

  def self.key
    @@api_key
  end

  def run!
    bar = ProgressBar.new(get_movie_count)
    top_movie_ids.each { |id| parse(id) ; bar.increment! }
  end

  private

  def get_movie_count
    @count_page * 20
  end

  def get_imdb_link(imdb_id)
    TmdbFetcher::IMDB_URI + imdb_id
  end

  def get_director(id)
    page    = "#{MOVIE_URI}/#{id}/credits?api_key=#{@@api_key}"
    json    = open(page).read
    result  = JSON.parse(json, symbolize_names: true)
    if director = result[:crew].find { |key| key[:job] == "Director" }
      director[:name]
    else
      nil
    end
  end

  def get_actors(id, num)
    page    = "#{MOVIE_URI}/#{id}/credits?api_key=#{@@api_key}"
    json    = open(page).read
    result  = JSON.parse(json, symbolize_names: true)
    result[:cast].map { |key| key[:name] }.first(num)
  end

  def top_movie_ids
    1.upto(@count_page) do |num|
      page    = "#{TOP_RATED}?api_key=#{@@api_key}&page=#{num}"
      json    = open(page).read
      result  = JSON.parse(json, symbolize_names: true)
      result[:results].select { |movie| @ids << movie[:id] }
    end
    @ids
  end

  def parse(id)
    mov     = {}
    page    = "#{MOVIE_URI}/#{id}?api_key=#{@@api_key}"
    json    = open(page).read
    result  = JSON.parse(json, symbolize_names: true)
    mov[:link]      = get_imdb_link(result[:imdb_id])
    mov[:name]      = result[:title]
    mov[:year]      = Date.strptime(result[:release_date], '%Y').year
    mov[:country]   = result[:production_countries].map { |key| key[:iso_3166_1] }.first
    mov[:date]      = result[:release_date]
    mov[:genre]     = result[:genres].map { |key| key[:name] }
    mov[:duration]  = result[:runtime]
    mov[:rating]    = result[:vote_average]
    mov[:director]  = get_director(id)
    mov[:actors]    = get_actors(id, 5)
    @list << mov
  end

end
