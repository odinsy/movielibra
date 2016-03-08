require 'movie'

describe "Movie" do

  let(:movie) { build(:movie) }
  let(:movie_list) { build(:movie_list) }
  let(:attributes) { {link: "http://www.imdb.com/title/tt0017925/", name: "The General", year: "1926", country: "USA", date: "1929", genre: ["Action","Adventure","Comedy","Drama","War"], duration: "67", rating: "8.3", director: "Clyde BruckmanBuster Keaton", actors: ["Buster Keaton", "Marion Mack", "Glen Cavender"]} }

  describe ".create" do
    it "creates a movie with class Movie::AncientMovie" do
      expect(Movie.create(movie_list, attributes.merge(year: '1920'))).to be_a(Movie::AncientMovie)
    end
    it "creates a movie with class Movie::ClassicMovie" do
      expect(Movie.create(movie_list, attributes.merge(year: '1959'))).to be_a(Movie::ClassicMovie)
    end
    it "creates a movie with class Movie::ModernMovie" do
      expect(Movie.create(movie_list, attributes.merge(year: '1998'))).to be_a(Movie::ModernMovie)
    end
    it "creates a movie with class Movie::NewMovie" do
      expect(Movie.create(movie_list, attributes.merge(year: '2005'))).to be_a(Movie::NewMovie)
    end
  end

  describe ".weight" do
    it "changes the weight of the class Movie" do
      Movie.weight 0.1
      expect(Movie.const_get(:WEIGHT)).to eq(0.1)
    end
    it "doesn't change weight of the subclass Movie::AncientMovie" do
      expect(Movie::AncientMovie.const_get(:WEIGHT)).to eq(0.3)
    end
    it "doesn't change weight of the subclass Movie::ClassicMovie" do
      expect(Movie::ClassicMovie.const_get(:WEIGHT)).to eq(0.5)
    end
    it "doesn't change weight of the subclass Movie::ModernMovie" do
      expect(Movie::ModernMovie.const_get(:WEIGHT)).to eq(0.7)
    end
    it "doesn't change weight of the subclass Movie::NewMovie" do
      expect(Movie::NewMovie.const_get(:WEIGHT)).to eq(1.0)
    end
  end

  describe ".print_format" do
    let(:classic_movie) { build(:classic_movie) }
    it "sets a print format for a movie description" do
      Movie::ClassicMovie.print_format "%{name} — so old movie (%{year} year)"
      expect(classic_movie.description).to eq("Anatomy of a Murder — so old movie (1959 year)")
    end
  end

  describe ".filter" do
    it "stores filter for Movie subclass" do
      Movie::ClassicMovie.filter { (1945..1967).cover?(year) }
      expect(Movie.filters).to include(Movie::ClassicMovie)
    end
    it "has Proc for the value of Movie subclass" do
      Movie::ClassicMovie.filter { (1945..1967).cover?(year) }
      expect(Movie.filters[Movie::ClassicMovie]).to be_a(Proc)
    end
  end

  describe "#to_h" do
    it "converts to hash" do
      expect(movie.to_h).to be_a(Hash)
    end
  end

  describe "#has_genres?" do
    it "returns true if a movie has genres" do
      expect(movie.has_genres?("Crime", "Drama")).to be_truthy
    end
    it "returns true if a movie has genres" do
      @movie = Movie.create(movie_list, attributes.merge(genres: ['Crime', 'Drama']))
      expect(@movie.has_genres?("Crime")).to be_falsey
    end
    it "returns false if a movie has not genres" do
      expect(movie.has_genres?("Comedy", "Action")).to be_falsey
    end
  end

  describe "#has_genre?" do
    it "returns true if a movie has genre" do
      expect(movie.has_genre?("Crime")).to be_truthy
    end
    it "returns false if a movie has not genre" do
      expect(movie.has_genre?("Comedy")).to be_falsey
    end
  end

  describe "#viewed?" do
    it "returns false when a movie was not viewed" do
      expect(movie.viewed?).to be_falsey
    end
    it "returns true when a movie was viewed" do
      movie.rate(Date.today, 7)
      expect(movie.viewed?).to be_truthy
    end
  end

  describe "#parse_date" do
    it "parse a date with format '%Y' when date.length eq 0..4" do
      @movie = Movie.new(attributes.merge(date: '1926'))
      expect(@movie.date.to_s).to eq("1926-01-01")
    end
    it "parse a date with format '%Y-%m' when date.length eq 5..7" do
      @movie = Movie.new(attributes.merge(date: '1926-10'))
      expect(@movie.date.to_s).to eq("1926-10-01")
    end
    it "parse a date with format '%Y-%m-%d' when date.length is more than 7" do
      @movie = Movie.new(attributes.merge(date: '1926-10-10'))
      expect(@movie.date.to_s).to eq("1926-10-10")
    end
  end
end
