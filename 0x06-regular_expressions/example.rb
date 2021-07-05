#!/usr/bin/env ruby
"""
sylvain@ubuntu$ ./example.rb 127.0.0.2
127.0.0.2
sylvain@ubuntu$ ./example.rb 127.0.0.1
127.0.0.1
sylvain@ubuntu$ ./example.rb 127.0.0.a
"""
puts ARGV[0].scan(/127.0.0.[0-9]/).join