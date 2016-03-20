require 'movie_libra/movie_list'

describe "MovieList" do

  let!(:movies) { build(:movie_list) }

  describe "#add_sort_algo" do
    it "stores algorithms" do
      movies.add_sort_algo(:genres_years) { |movie| [movie.genre, movie.year] }
      expect(movies.algos).to include(:genres_years)
    end
    it "has Proc for the value of stored algorithm" do
      movies.add_sort_algo(:genres_years) { |movie| [movie.genre, movie.year] }
      expect(movies.algos[:genres_years]).to be_a(Proc)
    end
  end

  describe "#print" do
    specify { expect { movies.print { |movie| "#{movie.name}" } }.to output("The General\nAnatomy of a Murder\nАкира\nIn the Mood for Love\n").to_stdout  }
  end

  describe "#sorted_by" do
    it "sorts when was passed a block" do
      expect(movies.sorted_by { |movie| movie.year }.map(&:year)).to eq([1926, 1959, 1988, 2000])
    end
    it "sorts when was passed a name of the algorithm" do
      movies.add_sort_algo(:years) { |movie| movie.year }
      expect(movies.sorted_by(:years).map(&:year)).to eq([1926, 1959, 1988, 2000])
    end
    it "throw an exception when was passed an unknown algorithm" do
      expect { movies.sorted_by(:algo) }.to raise_error("Unknown algorithm algo")
    end
  end

  describe "#add_filter" do
    it "stores filters" do
      movies.add_filter(:genres) { |movie, *genres| movie.genres?(*genres) }
      expect(movies.filters).to include(:genres)
    end
    it "has Proc for the value of stored filters" do
      movies.add_filter(:genres) { |movie, *genres| movie.genres?(*genres) }
      expect(movies.filters[:genres]).to be_a(Proc)
    end
  end

  describe "#filter" do
    it "filters movies by the existing filter" do
      movies.add_filter(:genres) { |movie, *genres| movie.genres?(*genres) }
      expect(movies.filter(genres: ["Drama","Romance"]).map(&:name)).to eq(["In the Mood for Love"])
    end
    it "throw an exception when was passed an unknown filter" do
      expect { movies.filter(test: "test") }.to raise_error("Unknown filter test")
    end
  end

  describe "#longest" do
    it "returns an array of the N longest movies " do
      expect(movies.longest(2).map(&:name)).to match_array(["Anatomy of a Murder", "Акира"])
    end
  end

  describe "#select_by_genre" do
    it "returns an array of the movies by genre" do
      expect(movies.select_by_genre("Comedy").map(&:name)).to match_array("The General")
    end
  end

  describe "#directors" do
    it "returns an array of the directors sorted by second name" do
      expect(movies.directors).to eq(["Clyde BruckmanBuster Keaton", "Otto Preminger", "Kar-wai Wong", "Katsuhiro Ôtomo"])
    end
  end

  describe "#skip_country" do
    it "returns a count of the movies without skipped country" do
      expect(movies.skip_country("Japan")).to eq(3)
    end
  end

  describe "#count_by_director" do
    it "returns a count of movies by each director" do
      expect(movies.count_by_director).to eq({"Kar-wai Wong"=>1, "Katsuhiro Ôtomo"=>1, "Otto Preminger"=>1, "Clyde BruckmanBuster Keaton"=>1})
    end
  end

  describe "#by_director" do
    it "returns an array of the movies by director" do
      expect(movies.by_director("Kar-wai Wong")).to eq(["In the Mood for Love"])
    end
  end

  describe "#count_by_actor" do
    it "returns a count of the movies by each actor" do
      expect(movies.count_by_actor).to match_array([["Maggie Cheung", 1], ["Ping Lam Siu", 1], ["Tony Chiu Wai Leung", 1], ["Mitsuo Iwata", 1], ["Mami Koyama", 1], ["Nozomu Sasaki", 1], ["Ben Gazzara", 1], ["Lee Remick", 1], ["James Stewart", 1], ["Glen Cavender", 1], ["Marion Mack", 1], ["Buster Keaton", 1]])
    end
  end

  describe "#month_stats" do
    it "returns the statistics of movies shot each month (first value - number of month, second - count)" do
      expect(movies.month_stats).to match_array([[1, 1], [3, 1], [7, 1], [9, 1]])
    end
  end

  describe ".parse_json" do
    it "returns an array" do
      expect(MovieLibra::MovieList.parse_json("spec/factories/movies.json")).to be_a(Array)
    end
    it "parses JSON to array of hashes" do
      expect(MovieLibra::MovieList.parse_json("spec/factories/movies.json").first).to eq({:link=>"http://www.imdb.com/title/tt0111161/", :name=>"The Shawshank Redemption", :year=>"1994", :country=>"USA", :date=>"1994-10-14", :genre=>["Crime", "Drama"], :duration=>"142", :rating=>"9.3", :director=>"Frank Darabont", :actors=>["Tim Robbins", "Morgan Freeman", "Bob Gunton"]})
    end
    it "throw an exception when file does not exist" do
      expect { MovieLibra::MovieList.parse_json("111.json") }.to raise_error("File not found: 111.json")
    end
  end

  describe ".parse_csv" do
    it "parses CSV" do
      expect(MovieLibra::MovieList.parse_csv("spec/factories/movies.csv").first).to eq([[:link, "http://www.imdb.com/title/tt0468569/"], [:name, "The Dark Knight"], [:year, "2008"], [:country, "USA"], [:date, "2008-07-18"], [:genre, "Action,Crime,Drama"], [:duration, "152"], [:rating, "9.0"], [:director, "Christopher Nolan"], [:actors, "Christian Bale,Heath Ledger,Aaron Eckhart"]])
    end
    it "throw an exception when file does not exist" do
      expect { MovieLibra::MovieList.parse_csv("111.csv") }.to raise_error("File not found: 111.csv")
    end
  end

  describe ".load_json" do
    it "creates an object of class MovieList" do
      expect(MovieLibra::MovieList.load_json("spec/factories/movies.json")).to be_a(MovieLibra::MovieList)
    end
  end

  describe ".load_csv" do
    it "creates an object of class MovieList" do
      expect(MovieLibra::MovieList.load_csv("spec/factories/movies.csv")).to be_a(MovieLibra::MovieList)
    end
  end

end
