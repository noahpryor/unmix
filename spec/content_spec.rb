RSpec.describe Content do

  it "fixes all kinds of mixed content", vcr: true do
    html = File.read("spec/fixtures/mixed_content_examples/all.html")

    content = Content.new(html)
    expect(content.mixed_content.count).to eq(7)

    result  = content.find_and_fix_mixed_content
    expect(result).to include("https://")
    expect(content.mixed_content.count).to eq(0)


  end

  it "doesn't fix content with invalid certificates", vcr: true do
    html = File.read("spec/fixtures/mixed_content_examples/bad-ssl.html")

    content = Content.new(html)
    expect(content.mixed_content.count).to eq(1)

    result  = content.find_and_fix_mixed_content

    expect(content.mixed_content.count).to eq(1)
  end


end
