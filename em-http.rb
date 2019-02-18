require 'rubygems'
require 'eventmachine'
require 'em-http'
require 'pp'

$stdout.sync = true

class KeyboardHandler < EM::Connection
  include EM::Protocols::LineText2

  def post_init
    print "> "
  end

  def receive_line(line)
    line.chomp!
    line.gsub!(/^\s+/, '')

    case(line)
    when /^get (.*)$/ then
      site = $1.chomp
      http = EM::HttpRequest.new(site).get
      http.callback do
        puts ""
        pp http.response_header.status
        pp http.response_header
        print "> "
      end
      http.errback do
        print "\n> Error retrieving #{site}"
        print "> "
      end
      print "> "

    when /^exit$/ then
      EM.stop

    when /^help$/ then
      puts "get URL[,URL]*   - gets a URL"
      puts "exit      - exits the app"
      puts "help      - this help"
      print "> "
    end
  end
end

EM::run {
  EM.open_keyboard(KeyboardHandler)
}
puts "Finished"