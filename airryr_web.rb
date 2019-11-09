require "sinatra"
require "dotenv/load"
require_relative "twitterAPI"

get "/" do
  "Hello world!" 
end

post "/#{ENV["WEBHOOK_ENDPOINT"]}" do
  params = JSON.parse(request.body.read, symbolize_names: true)
  msg = "ばかばかっ！値は#{params[:alert][:metricValue]}でステータスは#{params[:alert][:status]}よ！ちゃんと換気しなさい！"
  TwitterAPI.post(msg) if ENV["POST_TO_TWITTER"] == "y"
  msg
end
