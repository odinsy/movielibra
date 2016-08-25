[![Build Status](https://travis-ci.org/odinsy/movie_libra.svg?branch=master)](https://travis-ci.org/odinsy/movie_libra)

# MovieLibra

MovieLibra is a Ruby movie library for the working with the top-rated movies from IMDB and TMDB.

Provides a simple and intuitive interface for:
* parse and create movie lists from IMDB or TMDB,
* save movie list to and load from file,
* rate movies,
* get information about movies (see examples)

## Installation

Clone application from repository:

    $ git clone https://github.com/odinsy/movie_libra.git

And then execute:

    $ bundle

Or install it yourself as:

    $ gem build movie_libra.gemspec
    $ gem install movie_libra

## Usage

### Information

---
For starting work you need to parse movies data from IMDB or TMDB or you can just use an existing movies data from ```data/``` directory.  
Format can be JSON or CSV. Just pass parameter to an argument ```-f``` like ```-f csv``` or ```-f json```.  
Parsed data stores to ```tmp/``` directory.  
For working with TMDB you first need to [sign up](https://www.themoviedb.org/account/signup) to The Movie Database and then request a new api key.  

### CLI

---
```
$ bundle exec bin/libra                                         
Commands:
  libra fetch TYPE FORMAT  # Fetch a new movies. Type can be imdb, tmdb. Formats: json or csv.
  libra help [COMMAND]     # Describe available commands or one specific command
```

```
$ bundle exec bin/libra help fetch
Commands:
  libra fetch help [COMMAND]                      # Describe subcommands or one specific subcommand
  libra fetch imdb -f, --format=FORMAT            # Fetch the imdb movies. Format can be --json or --csv.
  libra fetch tmdb --key=KEY -f, --format=FORMAT  # Fetch the tmdb movies. Pass your API key with --key. Format can be --json or --csv.
```

Examples:

    $ bundle exec bin/libra fetch imdb -f csv

    $ bundle exec bin/libra fetch tmdb -f json --key YOUR-API-KEY

### Console

---

IMDB

```ruby
2.2.4 :001 > fetcher = MovieLibra::Fetcher::Imdb.new
 => MovieLibra::Fetcher::Imdb (0 movies)
2.2.4 :002 > fetcher.run!
Progress: |====================================================================|
 => MovieLibra::Fetcher::Imdb (250 movies)
2.2.4 :003 > fetcher.save_to_json
 => "./tmp/movies.json"
 ```

 TMDB

```ruby
2.2.4 :006 > fetcher = MovieLibra::Fetcher::Tmdb.new("YOUR-API-KEY-HERE")
 => MovieLibra::Fetcher::Tmdb (0 movies)
2.2.4 :007 > fetcher.run!(20)
Progress: |====================================================================|
 => MovieLibra::Fetcher::Tmdb (20 movies)
2.2.4 :008 > fetcher.save_to_csv
 => "./tmp/movies.csv"
 ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/odinsy/movie_libra )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
