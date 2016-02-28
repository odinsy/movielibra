require 'movie'

describe "Movie" do
  let!(:movie) { build(:movie) }
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
end
