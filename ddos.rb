require 'open-uri'
require 'useragents'
count = 0
#url = 'http://coxel.ws.pho.to/wp-admin/admin-ajax.php?action=send_photo&image_url=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2Fc%2Fc2%2FFlag_of_the_Schutzstaffel.svg%2F1200px-Flag_of_the_Schutzstaffel.svg.png'
url = 'http://stalnoy.org'
proxy = []
File.readlines('./http_proxy.txt').each_with_index do |line, index|
break if index == 100
proxy.append(line.strip)

end


threads = Array.new(proxy.count) do |i|
  Thread.new(i) do
	Thread.current.report_on_exception = false
    puts "Request #{i + 1} "
    
    p = open(url, 'User-Agent' => UserAgents.rand(), proxy: URI.parse("http://#{proxy[i].strip}")){ |f|  puts "Request #{i + 1} " + proxy[i].strip + " " + f.status.to_s;count += 1 }
  end
end


threads.each do |thread|

  if !thread.nil?
begin
  puts thread.value.join("\n")
rescue NoMethodError
rescue Exception => e
  puts e# not enough lifeboats ;)
end
  end
end

puts "count=#{count}"

