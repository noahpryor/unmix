RSpec.describe Unmix do
  it "has a version number" do
    expect(Unmix::VERSION).not_to be nil
  end

  context "finds and references to" do
    it "javascript files" do
      content = '<script src="http://googlesamples.github.io/web-fundamentals/samples/discovery-and-distribution/avoid-mixed-content/simple-example.js"></script>'
    #  Unmix.fix(content)
    end
    it "stylesheets"
    it "iframes"
    it "images"
    it "videos"
    it "audio"
    it ""
  end
end
