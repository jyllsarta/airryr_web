require_relative 'base'

class AirryrWeb < Sinatra::Application

  def initialize
    super
    @messages = YAML.load_file("messages.yml")
  end

  def stale_alert?(alert_opened_at)
    Time.at(alert_opened_at) + ENV["IGNORE_ALERT_OPENED_AT_SECONDS"].to_i < Time.now
  end

  get "/" do
    "Hello world!"
  end

  post "/#{ENV["WEBHOOK_ENDPOINT"]}" do
    alert = Alert.new(request.body.read)
    msg = @messages[alert.status].sample % alert.metric_value

    # warn -> crit -> warn という時系列で発報された場合の2度目のwarnは無視させたいため、
    # IGNORE_ALERT_OPENED_AT_SECONDS 以上古いWarnのアラートは無視する
    next "stale!" if alert.stale? && alert.status == "warning"
    TwitterAPI.post(msg) if ENV["POST_TO_TWITTER"] == "y"
    msg
  end

  run! if __FILE__ == $0
end
