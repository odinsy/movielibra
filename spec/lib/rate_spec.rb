require 'movie'

describe "Rate" do
  let!(:movie) { build(:movie) }
  context "when num is correct" do
    before :each do
      movie.rate(Date.today, 7)
    end
    it "changes the rate" do
      expect(movie.my_rating).to eq(7)
    end
    it "sets the date" do
      expect(movie.view_date).to eq(Date.today)
    end
  end
  context "when num is incorrect" do
    it "doesn't change the rate" do
      expect { movie.rate(Date.today, 11) }.to raise_error("You can rate movie only from 0 to 10!")
    end
  end
end
