require "sinatra"
require "dotenv/load"
require_relative "twitterAPI"
require "yaml"

messages = YAML.load_file("messages.yml")

def stale_alert?(alert_opened_at)
  Time.at(alert_opened_at) + ENV["IGNORE_ALERT_OPENED_AT_SECONDS"].to_i < Time.now
end

get "/" do
  "Hello world!" 
end

post "/#{ENV["WEBHOOK_ENDPOINT"]}" do
  params = JSON.parse(request.body.read, symbolize_names: true)
  status = params[:alert][:status]
  msg = messages[status].sample % params[:alert][:metricValue]

  # warn -> crit -> warn という時系列で発報された場合の2度目のwarnは無視させたいため、
  # IGNORE_ALERT_OPENED_AT_SECONDS 以上古いWarnのアラートは無視する
  return if stale_alert?(params[:alert][:openedAt]) && status == "warning"
  TwitterAPI.post(msg) if ENV["POST_TO_TWITTER"] == "y"
  msg
end
