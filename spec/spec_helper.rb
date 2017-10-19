
require "rspec"
require "webmock"

require 'simplecov'

require "unmix"

# Include the gem in the namespace so we don't have to write Unmix:: all the time
include Unmix

# require "vcr"

# VCR.configure do |c|
#   c.cassette_library_dir = 'spec/fixtures/cassettes'
#   c.hook_into :webmock
#   c.configure_rspec_metadata!
# end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.before(:all) do
  end
  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
