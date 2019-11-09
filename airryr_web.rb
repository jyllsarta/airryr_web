require 'sinatra'
require 'dotenv/load'

get '/' do
  'Hello world!' 
end

post "/#{ENV["WEBHOOK_ENDPOINT"]}" do
  params = JSON.parse(request.body.read, symbolize_names: true)
  "ばかばかっ！値は#{params[:alert][:metricValue]}でステータスは#{params[:alert][:status]}よ！ちゃんと換気しなさい！"
end