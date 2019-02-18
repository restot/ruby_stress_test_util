
require 'useragents'
count = 0

#url = 'http://coxel.ws.pho.to/wp-admin/admin-ajax.php?action=send_photo&image_url=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2Fc%2Fc2%2FFlag_of_the_Schutzstaffel.svg%2F1200px-Flag_of_the_Schutzstaffel.svg.png'
url = 'http://stalnoy.org'
proxy = []
File.readlines('./http_proxy.txt').each_with_index do |line, index|
break if index == 100
proxy.append(line.strip)
end

thread_limit = 10
threads = []
start = Time.now

proxy.each_with_index do |link, index|
	threads << Thread.start do
		Thread.current.report_on_exception = false
		puts "Request #{index + 1} "
                response = exec("curl -o /dev/null -s -w '%{http_code}\n' #{url} --proxy #{link}")
		print "Request #{index + 1} " + link + " " + response + "\n"
		count += 1
		#p = open(url, 'User-Agent' => UserAgents.rand(), proxy: URI.parse("http://#{link}")) do |f|  
		#print "Request #{index + 1} " + link + " " + f.status.to_s + "\n"		
		#t.exit 
		#end

	end
end
  
begin
threads.each{|t| t.join}
rescue NoMethodError
rescue Exception => e
  puts e
end
finish = Time.now

diff = finish - start

puts "count=#{count}"
puts "Time spent: #{diff}"

