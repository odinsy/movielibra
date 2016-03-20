[![Build Status](https://travis-ci.org/odinsy/imdb-data-parser.svg?branch=master)](https://travis-ci.org/odinsy/imdb-data-parser)

# MovieLibra

MovieLibra is a Ruby movie library for the working with the top rated movies from IMDB and TMDB.

Provides a simple and intuitive interface for:
* parse and create movie lists from IMDB or TMDB,
* save movie list to and load from file,
* rate movies,
* get information about movies (see examples)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'movie_libra'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install movie_libra

## Usage

---

### TODO:
---
- [ ] Write documentation for the class MovieLibra::Movie
- [x] Write documentation for the class MovieLibra::MovieList
- [ ] Write documentation for the class MovieLibra::MyMovieList
- [ ] Write documentation for the module MovieLibra::Rate
- [ ] Write documentation for the module MovieLibra::RateList
- [ ] Write documentation for the module MovieLibra::Export
- [ ] Write documentation for the class MovieLibra::Imdb::Fetcher
- [ ] Write documentation for the class MovieLibra::Tmdb::Fetcher
- [ ] Refactor with rubocops
- [ ] Add more examples to README
---

First of all you need to parse movies data from IMDB or TMDB. There are 3 ways to do it:

### CLI
---
Format can be JSON or CSV. Just pass argument like ```--csv``` or ```-json```. Parsed data stores to ```tmp/``` directory.  
One caveat for TMDB - you first need to [sign up](https://www.themoviedb.org/account/signup) to The Movie Database and then request a new api key.  

IMDB

    $ bundle exec bin/libra fetch imdb --csv

TMDB

    $ bundle exec bin/libra fetch tmdb --json --key YOUR-API-KEY

Or you can just use an existing movies data from ```data/``` directory.

### Console
---
IMDB

```ruby
2.2.4 :005 > fetcher = MovieLibra::Imdb::Fetcher.new
=> MovieLibra::Imdb::Fetcher (0 movies)
2.2.4 :006 > fetcher.run!
[#############################################################################################################################################################] [250/250] [100.00%] [00:52] [00:00] [  4.72/s]
=> MovieLibra::Imdb::Fetcher (250 movies)
2.2.4 :007 > fetcher.save_to_json
=> "./data/movies.json"
 ```

 TMDB

```ruby
2.2.4 :002 > fetcher = MovieLibra::Tmdb::Fetcher.new("dd165b18174b238eb2af5a0c3552f2f3")
=> MovieLibra::Tmdb::Fetcher (0 movies)
2.2.4 :003 > fetcher.run!(5)
[###################################################################################################################################################################] [5/5] [100.00%] [00:16] [00:00] [0.30/s]
=> MovieLibra::Tmdb::Fetcher (5 movies)
2.2.4 :004 > fetcher.save_to_csv
=> "./data/movies.csv"
 ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/odinsy/movie_libra. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
