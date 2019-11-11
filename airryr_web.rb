require "sinatra"
require "dotenv/load"
require_relative "twitterAPI"

get "/" do
  "Hello world!" 
end

post "/#{ENV["WEBHOOK_ENDPOINT"]}" do
  params = JSON.parse(request.body.read, symbolize_names: true)
  # TODO: 文言にランダム性とかアラート要画像とか用意したいね
  msg = "@jyll ばかばかっ！あんたの部屋の二酸化炭素濃度が#{params[:alert][:metricValue]}ppmまで上がってるわよ！ ステータスでいうと#{params[:alert][:status]}なんだから！ちゃんと換気しなさい！"
  TwitterAPI.post(msg) if ENV["POST_TO_TWITTER"] == "y"
  msg
end
