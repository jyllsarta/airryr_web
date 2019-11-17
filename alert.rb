require_relative "base"

class Alert
  def initialize(request_parameter)
    @params = JSON.parse(request_parameter, symbolize_names: true)
  end

  def status
    @params[:alert][:status]
  end

  def metric_value
    @params[:alert][:metricValue]
  end

  def stale?
    Time.at(@params[:alert][:openedAt]) + ENV["IGNORE_ALERT_OPENED_AT_SECONDS"].to_i < Time.now
  end
end
