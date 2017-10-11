RSpec.describe Unmix::LinkChecker do

  it "mixed_content_link? returns true if a link is http" do
    link = "http://example.com/image.png"
    expect(Unmix::LinkChecker.mixed_content_link?(link)).to be true
  end

  it "mixed_content_link? returns false if a link is relative" do
    link = "/image.png"
    expect(Unmix::LinkChecker.mixed_content_link?(link)).to be false
  end

  it "mixed_content_link? returns false if a link is https" do
    link = "https://example.com/image.png"
    expect(Unmix::LinkChecker.mixed_content_link?(link)).to be false
  end
end
