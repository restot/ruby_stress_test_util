# ruby_stress_test_util

For testing purposes only 

Usage 

    #> log.txt;ruby ./em-dev.rb N | tee -a log.txt

N - number of connections <= lines in 'http_proxy.txt'

Statistic 

    watch -n 1 ./stats.sh

Build gem

    cd ./useragents-rb/
    gem build *.gemspec
    gem install *.gem
