require 'movie'

describe "Movie" do
  let(:movie) { build(:movie) }
  let(:movie_list) { build(:movie_list) }

  describe ".create" do
    it "creates a movie with class Movie::ClassicMovie" do
      classic = {link: "http://www.imdb.com/title/tt0052561/", name: "Anatomy of a Murder", year: "1959", country: "USA", date: "1959-09", genre: ["Crime","Drama","Mystery","Thriller"], duration: "160", rating: "8.1", director: "Otto Preminger", actors: ["James Stewart", "Lee Remick", "Ben Gazzara"]}
      expect(Movie.create(movie_list, classic).class).to eq(Movie::ClassicMovie)
    end
    it "creates a movie with class Movie::AncientMovie" do
      ancient = {link: "http://www.imdb.com/title/tt0017925/", name: "The General", year: "1926", country: "USA", date: "1929", genre: ["Action","Adventure","Comedy","Drama","War"], duration: "67", rating: "8.3", director: "Clyde BruckmanBuster Keaton", actors: ["Buster Keaton", "Marion Mack", "Glen Cavender"]}
      expect(Movie.create(movie_list, ancient).class).to eq(Movie::AncientMovie)
    end
    it "creates a movie with class Movie::ModernMovie" do
      modern = {link: "http://www.imdb.com/title/tt0094625/", name: "Акира", year: "1988", country: "Japan", date: "1988-07-16", genre: ["Animation","Action","Sci-Fi"], duration: "124", rating: "8.1", director: "Katsuhiro Ôtomo", actors: ["Nozomu Sasaki","Mami Koyama","Mitsuo Iwata"]}
      expect(Movie.create(movie_list, modern).class).to eq(Movie::ModernMovie)
    end
    it "creates a movie with class Movie::NewMovie" do
      newmovie = {link: "http://www.imdb.com/title/tt0118694/", name: "In the Mood for Love", year: "2000", country: "Hong Kong", date: "2001-03-09", genre: ["Drama","Romance"], duration: "98", rating: "8.1", director: "Kar-wai Wong", actors: ["Tony Chiu Wai Leung","Maggie Cheung","Ping Lam Siu"]}
      expect(Movie.create(movie_list, newmovie).class).to eq(Movie::NewMovie)
    end
  end

  describe ".weight" do
    it "changes the weight of the class Movie" do
      Movie.weight 1.0
      expect(Object.const_get("Movie::WEIGHT")).to eq(1.0)
    end
    it "changes the weight of the class Movie::ClassicMovie" do
      Movie::ClassicMovie.weight 0.2
      expect(Object.const_get("Movie::ClassicMovie::WEIGHT")).to eq(0.2)
    end
    it "changes the weight of the class Movie::AncientMovie" do
      Movie::AncientMovie.weight 0.4
      expect(Object.const_get("Movie::AncientMovie::WEIGHT")).to eq(0.4)
    end
    it "changes the weight of the class Movie::ModernMovie" do
      Movie::ModernMovie.weight 0.6
      expect(Object.const_get("Movie::ModernMovie::WEIGHT")).to eq(0.6)
    end
    it "changes the weight of the class Movie::NewMovie" do
      Movie::NewMovie.weight 0.8
      expect(Object.const_get("Movie::NewMovie::WEIGHT")).to eq(0.8)
    end
  end

  describe ".print_format" do
    let(:classic_movie) { build(:classic_movie) }
    let(:ancient_movie) { build(:ancient_movie) }
    let(:modern_movie) { build(:modern_movie) }
    let(:new_movie) { build(:new_movie) }
    it "sets the print format for the classic movie description" do
      Movie::ClassicMovie.print_format "%{name} — so old movie (%{year} year)"
      expect(classic_movie.description).to eq("Anatomy of a Murder — so old movie (1959 year)")
    end
    it "sets the print format for the ancient movie description" do
      Movie::AncientMovie.print_format "%{name} — the classic movie."
      expect(ancient_movie.description).to eq("The General — the classic movie.")
    end
    it "sets the print format for the modern movie description" do
      Movie::ModernMovie.print_format "%{name} — modern movie."
      expect(modern_movie.description).to eq("Акира — modern movie.")
    end
    it "sets the print format for the ancient new description" do
      Movie::NewMovie.print_format "%{name} — novelty!"
      expect(new_movie.description).to eq("In the Mood for Love — novelty!")
    end
  end

  describe ".filter" do
    it "stores the filter" do
      Movie::ClassicMovie.filter { (1945..1967).cover?(year) }
      expect(Movie.filters ).to include { (1945..1967).cover?(year) }
    end
  end

  describe "#to_h" do
    it "converts to hash" do
      expect(movie.to_h.class).to eq(Hash)
    end
  end

  describe "#has_genres?" do
    it "returns true if a movie has genres" do
      expect(movie.has_genres?("Crime", "Drama")).to be_truthy
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
      expect(movie.parse_date("1994").to_s).to eq("1994-01-01")
    end
    it "parse a date with format '%Y-%m' when date.length eq 5..7" do
      expect(movie.parse_date("1994-10").to_s).to eq("1994-10-01")
    end
    it "parse a date with format '%Y-%m-%d' when date.length is more than 7" do
      expect(movie.parse_date("1994-10-14").to_s).to eq("1994-10-14")
    end
  end
end
