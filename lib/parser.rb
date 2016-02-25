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
      @list.each do |m|
        file << m.values.map { |v| v.kind_of?(Array) ? v.join(',') : v }
      end
    end
  end

  def run!
    agent = Mechanize.new
    page  = agent.get(IMDB_URL)
    count = page.links_with(css: "td.titleColumn a").count
    bar   = ProgressBar.new(count)
    page.links_with(css: "td.titleColumn a").peach(5) do |link|
      mov             = {}
      review          = link.click
      mov[:link]      = review.canonical_uri.to_s
      mov[:name]      = review.search(".title_wrapper h1[itemprop='name']").text.gsub(/ \(\d+\)/,"").strip
      mov[:year]      = review.search(".title_wrapper h1 span#titleYear a").text
      mov[:country]   = review.links_with(href: %r{/country/}).map(&:text).first
      mov[:date]      = review.search("//*[@class='titleBar']//meta[@itemprop='datePublished']/@content").map(&:value).first
      mov[:genre]     = review.search(".see-more.inline.canwrap[itemprop='genre'] a").text.split("\s").map(&:strip)
      mov[:duration]  = review.search(".title_wrapper .subtext time/@datetime").first.value.gsub(/[^\d]/, '')
      mov[:rating]    = review.search(".imdbRating .ratingValue strong span").text
      mov[:director]  = review.search(".credit_summary_item span[itemprop='director'] a").text
      mov[:actors]    = review.search(".credit_summary_item span[itemprop='actors'] a").map { |actor| actor.text.strip }
      bar.increment!
      @list << mov
    end
  end

end

# fetcher = IMDBFetcher.new
# fetcher.run!
# fetcher.save_to_json("movies.json")
# fetcher.save_to_csv("movies.csv")
