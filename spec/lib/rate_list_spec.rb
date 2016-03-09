require 'movie_list'
require 'my_movie_list'

describe "RateList" do
  let!(:movies) { build(:my_movie_list) }
  before :each do
    movies.rate("The General", 7)
  end
  describe "#rate" do
    context "when num is correct" do
      it "changes the rate" do
        expect(movies.find_movie("The General").my_rating).to eq(7)
      end
      it "sets the date" do
        expect(movies.find_movie("The General").view_date).to eq(Date.today)
      end
    end
    context "when num is incorrect" do
      it "doesn't change the rate" do
        expect { movies.rate("The General", 11) }.to raise_error("You can rate movie only from 0 to 10!")
      end
    end
  end
  describe "#recommend" do
    it "rejects watched movies" do
      expect(movies.recommend.map(&:name)).not_to include("The General")
    end
    it "returns not watched movies" do
      expect(movies.recommend.map(&:name)).to include("Anatomy of a Murder", "Акира", "In the Mood for Love")
    end
  end
  describe "#watched" do
    it "returns viewed movies" do
      expect(movies.watched.map(&:name)).to include("The General")
    end
    it "rejects not watched movies" do
      expect(movies.watched.map(&:name)).not_to include("Anatomy of a Murder", "Акира", "In the Mood for Love")
    end
  end
end
