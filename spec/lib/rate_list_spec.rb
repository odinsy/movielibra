require 'movie_list'
require 'my_movie_list'

describe "rate_list" do
  let!(:movies) { build(:my_movie_list) }
  context "when num is correct" do
    before :each do
      movies.rate("The Godfather", 7)
    end
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
