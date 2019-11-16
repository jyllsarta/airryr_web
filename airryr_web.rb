require "sinatra"
require "dotenv/load"
require_relative "twitterAPI"

def stale_alert?(alert_opened_at)
  Time.at(alert_opened_at) + ENV["IGNORE_ALERT_OPENED_AT_SECONDS"].to_i < Time.now
end

get "/" do
  "Hello world!" 
end

post "/#{ENV["WEBHOOK_ENDPOINT"]}" do
  params = JSON.parse(request.body.read, symbolize_names: true)
  # TODO: 文言にランダム性とかアラート用画像とか用意したいね
  case params[:alert][:status]
  when "ok"
    msg = "@jyll 換気終わったみたいね！えらいわ！"
  when "warning"
    msg = "@jyll 二酸化炭素濃度が#{params[:alert][:metricValue]}ppmまで上がってるから、そろそろ換気しなさいっ！ ステータスでいうと#{params[:alert][:status]}くらいよ！"
  when "critical"
    msg = "@jyll ばかばかっ！あんたの部屋の二酸化炭素濃度が#{params[:alert][:metricValue]}ppmまで上がってるわよ！ ステータスでいうと#{params[:alert][:status]}なんだから！ちゃんと換気しなさい！"
  end

  # warn -> crit -> warn という時系列で発報された場合の2度目のwarnは無視させたいため、
  # IGNORE_ALERT_OPENED_AT_SECONDS 以上古いWarnのアラートは無視する
  return if stale_alert?(params[:alert][:openedAt]) && params[:alert][:status] == "warning"
  TwitterAPI.post(msg) if ENV["POST_TO_TWITTER"] == "y"
  msg
end
