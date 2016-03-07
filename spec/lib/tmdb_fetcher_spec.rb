require 'tmdb_fetcher'

describe "TmdbFetcher" do

  let!(:fetcher) { build(:tmdb_fetcher) }
  let!(:correct_id) { 40662 }
  let!(:incorrect_id) { 1000000000000 }
  let!(:credits) { fetcher.send(:get, "#{correct_id}/credits") }

  it "gets my API key" do
    get "https://api.themoviedb.org/3/movie/550?api_key=#{TmdbFetcher.key}"
    expect_status 200
  end

  describe ".top_movie_ids" do
    let(:top_movie_ids) { fetcher.send(:top_movie_ids) }
    it "returns an array" do
      expect(top_movie_ids).to be_a(Array)
    end
    it "returns not empty array" do
      expect(top_movie_ids).not_to be_empty
    end
    it "returns not nil" do
      expect(top_movie_ids).not_to be_nil
    end
    it "returns not nil values" do
      expect(top_movie_ids.include?(nil)).to be_falsey
    end
  end

  describe ".parse" do
    it "returns an array" do
      expect(fetcher.send(:parse, correct_id)).to be_a(Array)
    end
    it "returns not empty array" do
      expect(fetcher.send(:parse, correct_id)).not_to be_empty
    end
    it "returns not nil" do
      expect(fetcher.send(:parse, correct_id)).not_to be_nil
    end
    it "returns not nil values" do
      expect(fetcher.send(:parse, correct_id).include?(nil)).to be_falsey
    end
    it "correctly parses information of the movie" do
      movie = [
        { link: "http://www.imdb.com/title/tt1569923",
          name: "Batman: Under the Red Hood",
          year: 2010,
          country: "US",
          date: "2010-07-27",
          genre: ["Adventure", "Animation", "Action", "Science Fiction", "Mystery"],
          duration: 75,
          rating: 7.5,
          director: "Brandon Vietti",
          actors: ["Bruce Greenwood", "Jensen Ackles", "Neil Patrick Harris", "Jason Isaacs", "John DiMaggio"]
        }
      ]
      expect(fetcher.send(:parse, correct_id)).to eq(movie)
    end
  end

  describe ".get_imdb_link" do
    it "makes IMDB link" do
      imdb_id = "tt1569923"
      expect(fetcher.send(:get_imdb_link, imdb_id)).to eq("http://www.imdb.com/title/tt1569923")
    end
  end

  describe ".get" do
    it "parses JSON when passed only correct path" do
      expect(fetcher.send(:get, correct_id)).to be_a(Hash)
    end
    it "parses JSON when passed path and page numer" do
      expect(fetcher.send(:get, "top_rated", 1)).to be_a(Hash)
    end
    # it "throw an exception when path is incorrect" do
    #   expect { fetcher.send(:get, "blabla") }.to raise_error("The passed path is incorrect, status code: 404")
    # end
  end

  describe ".get_director" do
    it "returns the director of the movie" do
      expect(fetcher.send(:get_director, credits)).to eq("Brandon Vietti")
    end
  end

  describe ".get_actors" do
    it "returns an array of the movie actors" do
      expect(fetcher.send(:get_actors, credits, 5)).to contain_exactly("Bruce Greenwood", "Jensen Ackles", "John DiMaggio", "Neil Patrick Harris", "Jason Isaacs")
    end
  end

  describe ".page_count" do
    it "returns page count" do
      TmdbFetcher.movie_count 190
      expect(fetcher.send(:page_count)).to eq(10)
    end
  end

end
