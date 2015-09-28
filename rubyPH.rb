require "net/https"
require "uri"
require 'csv'
require 'json'

uri = URI.parse("https://api.producthunt.com/v1/posts/5699/votes?access_token=85e5f4dd41629c971602bb75d6b07dd640d066aef10d14b6d8f094018daa32e8")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)

CSV.open("ph-and.csv", "w", {:col_sep => ";"}) do |csv|
  JSON.parse(response.body)["votes"].each do |single|
    p "#{single["user"]["id"]} ; #{single["user"]["name"]} ; #{single["user"]["headline"]} ; #{single["user"]["username"]} ; #{single["user"]["website_url"]}"
    csv << [single["user"]["id"], single["user"]["name"], single["user"]["headline"], single["user"]["username"], single["user"]["website_url"] ]
  end
end