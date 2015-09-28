# Get all url from images in PH activity in .csv - done
# Parse IDs - done
# Call APIs for each ID and get twitter handle

require "net/https"
require "uri"
require 'csv'
require 'json'

phCSV = CSV.foreach('allIDs-twitter.csv') do |row|
	id = row[0]
	uri = URI.parse("http://api.augur.io/v2/user?key=ikxxvks77804a1n8a37dn0pt088q00qf&twitter_handle=#{id}")
	Net::HTTP.start(uri.host, uri.port, use_ssl: false) do |http|
  	request = Net::HTTP::Get.new uri
  	response = http.request request
		parseResponse = JSON.parse(response.body)
		p parseResponse['PRIVATE']['email'] if !parseResponse['PRIVATE'].nil?
		sleep 3
	end
end
