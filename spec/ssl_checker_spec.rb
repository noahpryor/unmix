RSpec.describe SslChecker do


  it "identifies self signed certs" do
    url = "https://self-signed.badssl.com/"
    valid_certificate = SslChecker.valid_cert?(url).first

    expect(valid_certificate).to eq(false)
  end

  it "identifies valid certs" do
    url = "https://badssl.com/"

    valid_certificate = SslChecker.valid_cert?(url).first

    expect(valid_certificate).to eq(true)
  end

end
