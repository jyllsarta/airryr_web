require 'sinatra'
require 'dotenv/load'

get '/' do
  'Hello world!' 
end

post "/#{ENV["WEBHOOK_ENDPOINT"]}" do
  params = JSON.parse(request.body.read)
  "good!"
end