require 'erb'
require 'optparse'

opt = OptionParser.new

@zookeeper_port = '2181'
opt.on('--zk-port VAL') {|v| @zookeeper_port = v }

@kafka_host = 'localhost'
opt.on('--kafka-host VAL') {|v| @kafka_host = v }

opt.parse!(ARGV)

dc_erb = File.read './docker-compose.yml.erb'

erb = ERB.new dc_erb
dc_yml = erb.result(binding)

File.open('./docker-compose.yml', 'w') do |file|
  file.write dc_yml
end