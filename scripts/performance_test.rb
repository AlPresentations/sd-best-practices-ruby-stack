require 'net/http'

def llog(msg, ch="#")
    puts ch*40
    puts ch*2 + " #{msg} " + ch*2
    puts ch*40
end


##########################
# get script arguments
##########################
scenario_name = ARGV[2] || "some_test_name"
log_file_name = ARGV[3] || "run.log"
gatling_test = ARGV[4] || 1
attempt = ARGV[5].to_i || 2

puts "run scenario: #{scenario_name}, output: #{log_file_name} ..."

host = 'localhost'
port = 3000
url = "http://#{host}:#{port}/"

##########################
# run web server
##########################
Dir.chdir('/home/rubyk/workspace/EasyWay')

system "rails s -p #{port} > /dev/null 2>&1 &"

##########################
# ping server
##########################
begin
url = URI.parse(url)
req = Net::HTTP::Get.new(url.path)
i = 0
n = 100
interval = 3
cont = true
f = File.open(log_file_name, 'w+')
while i < n && cont do
  begin
    i += 1
    puts f.readlines
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    if res.body.size == 0
      sleep interval
      next
    else
      cont = false
    end
  rescue => e
    if e.is_a?(Errno::ECONNREFUSED) || i < n
      sleep interval
      next
    else
      llog "Another error: #{e}"
      cont = false
    end
  end
end

f.close
rescue => e
    llog e, "E"
end
llog "#{res.body}", "_#{res.body.size}_"

unless res && res.body.size > 0
    raise "Couldn't connect at #{i} attempt"
end
raise "Issue happend" if (res_ = (res.body =~ /We\'ve been notified about this issue and we\'ll take a look at it shortly/)) && (res_ && res_ > 0)


##########################
# run performance tests
##########################
result = ""
str = ""

while attempt > 0 do
attempt -= 1
    IO.popen('/opt/gatling-charts-highcharts-2.0.0-M3a/bin/gatling.sh', "w+") do |io|
	i = 0
	while (result = IO.select([io], [io])) && result[0].empty? do
	    p "#{(i += 1)}: #{result.inspect}"
	    p io.gets
	    sleep 1
	end
	io.puts "#{gatling_test.to_i}\n"
	io.gets
	io.puts "#{scenario_name}\n"
	io.gets
	io.puts "\n"
	while str = io.gets do
	    puts str
	    break if str =~ /\/opt\/gatling-charts-highcharts-2.0.0-M3a\/results\//
	end
	io.puts "exit"
	io.close_write
	result = io.readlines
    end
    puts "Final Result:"
    puts result
end

pid =  `ps aux | grep rails`.match(/rubyk\s+(\d+)\s+.*rails s.*/)[1]
Process.kill(8, pid.to_i)


`firefox #{str.match(/\/.*/)[0]}`