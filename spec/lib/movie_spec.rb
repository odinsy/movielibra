require 'movie'

describe "Movie" do
  let!(:movie) { build(:movie) }
  describe "#to_h" do
    it "converts to hash" do
      expect(movie.to_h.class).to eq(Hash)
    end
  end
end
