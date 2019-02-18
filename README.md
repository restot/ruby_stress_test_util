# ruby stress test util

For testing purposes only 

Connect to URL from different ip adresses and random user agents at onece.

Also support https, socks4 and socks5 proxies. 

Usage 

    > log.txt;ruby ./em-dev.rb N URL | tee -a log.txt

N - number of connections <= lines in 'http_proxy.txt'

URL - http://domain.com/

Statistic 

    watch -n 1 ./stats.sh

Build gem

    cd ./useragents-rb/
    gem build *.gemspec
    gem install *.gem
    
Requirments: 
* Ruby 2.5.0
    * gem 'rubygems'
    * gem 'eventmachine'
    * gem 'em-http'
    * gem 'useragents'
