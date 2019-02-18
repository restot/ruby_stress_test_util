require 'rubygems'
require 'eventmachine'
require 'em-http'
require 'useragents'


# EventMachine.run {
#   http = EventMachine::HttpRequest.new('http://stalnoy.org/').get :query => {'keyname' => 'value'}
#
#   http.errback { p 'Uh oh'; EM.stop }
#   http.callback {
#     pp http.response_header.status
#     # pp http.response_header
#     # p http.response
#
#     EventMachine.stop
#   }
# }

proxy = []
if ARGV.empty?
  offset = 10 
else
  url = ARGV[1].to_s
  offset = ARGV[0].to_i
end
File.readlines('./http_proxy.txt').each_with_index do |line, index|
break if index == offset
proxy.append(line.strip)
end

start = Time.now
EventMachine.run do
  multi = EventMachine::MultiRequest.new
proxy.each do |link|
  creds = link.split(':')
  multi.add link, EventMachine::HttpRequest.new(url,:proxy => {:host => creds[0] ,:port => creds[1].to_i }).get(:head => { 'user-agent' => UserAgents.rand().strip })
  # puts link + " " + multi.responses[:callback][link.to_s].response_header.status.to_s
end

  # multi.add :yahoo, EventMachine::HttpRequest.new(url).get({:head => {'User-Agent' => UserAgents.rand()}})

  multi.callback do
     multi.responses[:callback].each { |resp| puts resp[0] + " code: " + resp[1].response_header.status.to_s }
     multi.responses[:errback].each { |resp| puts resp[0] + " code: " + resp[1].response_header.status.to_s }
    finish = Time.now
    puts "status=done"
    diff = finish - start
    puts "Time spent: #{diff}"
    EventMachine.stop
  end
end
