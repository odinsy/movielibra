#!/usr/bin/env ruby
# Parse information about movies from IMDb TOP250

require 'json'
require 'csv'
require 'mechanize'
require 'progress_bar'

class Parser

  IMDB_URL = "http://www.imdb.com/chart/top"

  def self.save_to_json(filename)
    movies = parse
    File.open(filename, "w+") { |f| f.puts movies.to_json }
  end

  def self.save_to_csv(filename)
    movies = parse
    CSV.open(filename, "w+", col_sep: "|") do |file|
      movies.each do |m|
        file << m.values.map { |v| v.kind_of?(Array) ? v.join(',') : v }
      end
    end
  end

  private

  def self.parse
    agent = Mechanize.new
    page  = agent.get(IMDB_URL)
    count = page.links_with(css: "td.titleColumn a").count
    bar   = ProgressBar.new(count)
    list  = page.links_with(css: "td.titleColumn a").map do |link|
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
      mov
    end
  end

end
