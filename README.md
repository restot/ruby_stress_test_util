# ruby_stress_test_util

For testing purposes only 

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
