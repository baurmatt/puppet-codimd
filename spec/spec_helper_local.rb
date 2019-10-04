RSpec.configure do |c|
  c.before :each do
    # set to strictest setting for testing
    # by default Puppet runs at warning level
    #Puppet.settings[:strict] = :warning

    # Stub assert_private function from stdlib to not fail within this test
    Puppet::Parser::Functions.newfunction(:assert_private) { |_| }
  end
end
