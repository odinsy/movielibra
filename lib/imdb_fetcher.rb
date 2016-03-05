#!/usr/bin/env ruby
# Parse information about movies from IMDb TOP250

require 'json'
require 'csv'
require 'mechanize'
require 'progress_bar'
require 'pmap'

class IMDBFetcher

  IMDB_URL = "http://www.imdb.com/chart/top"

  attr_accessor :list

  def initialize
    @list = []
  end

  def save_to_json(filename)
    File.open(filename, "w+") { |f| f.puts @list.to_json }
  end

  def save_to_csv(filename)
    CSV.open(filename, "w+", col_sep: "|") do |file|
      file << @list.first.keys
      @list.each do |m|
        file << m.values.map { |v| v.kind_of?(Array) ? v.join(',') : v }
      end
    end
  end

  def run!
    bar = ProgressBar.new(get_movie_count)
    get_movie_links.peach(4) { |link| parse(link) ; bar.increment! }
  end

  private

  def shorten_link(link)
    link.split("/")[0..4].join("/")
  end

  def get_movie_links
    agent = Mechanize.new
    page  = agent.get(IMDB_URL)
    page.links_with(css: "td.titleColumn a").map { |link| shorten_link(page.uri.merge(link.href).to_s) }
  end

  def get_movie_count
    agent = Mechanize.new
    page  = agent.get(IMDB_URL)
    count = page.links_with(css: "td.titleColumn a").count
  end

  def parse(link)
    agent           = Mechanize.new
    page            = agent.get(link)
    mov             = {}
    mov[:link]      = page.canonical_uri.to_s
    mov[:name]      = page.search(".title_wrapper h1[itemprop='name']").text.gsub(/ \(\d+\)/,"").strip
    mov[:year]      = page.search(".title_wrapper h1 span#titleYear a").text
    mov[:country]   = page.links_with(href: %r{/country/}).map(&:text).first
    mov[:date]      = page.search("//*[@class='titleBar']//meta[@itemprop='datePublished']/@content").map(&:value).first
    mov[:genre]     = page.search(".see-more.inline.canwrap[itemprop='genre'] a").text.split("\s").map(&:strip)
    mov[:duration]  = page.search(".title_wrapper .subtext time/@datetime").first.value.gsub(/[^\d]/, '')
    mov[:rating]    = page.search(".imdbRating .ratingValue strong span").text
    mov[:director]  = page.search(".credit_summary_item span[itemprop='director'] a").text
    mov[:actors]    = page.search(".credit_summary_item span[itemprop='actors'] a").map { |actor| actor.text.strip }
    @list << mov
  end

end

# fetcher = IMDBFetcher.new
# fetcher.run!
# fetcher.save_to_json("movies.json")
# fetcher.save_to_csv("movies.csv")
