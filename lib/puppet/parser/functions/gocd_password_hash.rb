module Puppet::Parser::Functions
  newfunction(:gocd_password_hash, :type => :rvalue) do |args|
    raise Puppet::ParseError, 'Invalid arguments!' unless args.length == 1
    ("{SHA}" + Base64.encode64(::Digest::SHA1.digest(args[0])).strip)
  end
end
