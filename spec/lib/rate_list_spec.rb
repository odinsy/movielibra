require 'movie_list'
require 'my_movie_list'

describe "rate_list" do
  let!(:movies) { build(:my_movie_list) }
  before :each do
    movies.rate("The Godfather", 7)
  end
  describe "#rate" do
    context "when num is correct" do
      it "changes the rate" do
        expect(movies.find_movie("The Godfather").my_rating).to eq(7)
      end
      it "sets the date" do
        expect(movies.find_movie("The Godfather").view_date).to eq(Date.today)
      end
    end
    context "when num is incorrect" do
      it "doesn't change the rate" do
        expect { movies.rate("The Godfather", 11) }.to raise_error("You can rate movie only from 0 to 10!")
      end
    end
  end
  describe "#recommend" do
    it "rejects watched movies" do
      expect(movies.recommend.map(&:name)).not_to include("The Godfather")
    end
    it "returns not watched movies" do
      expect(movies.recommend.map(&:name)).to include("The Godfather: Part II", "The Dark Knight", "The Shawshank Redemption")
    end
  end
  describe "#watched" do
    it "returns viewed movies" do
      expect(movies.watched.map(&:name)).to include("The Godfather")
    end
    it "rejects not watched movies" do
      expect(movies.watched.map(&:name)).not_to include("The Godfather: Part II", "The Dark Knight", "The Shawshank Redemption")
    end
  end
end
