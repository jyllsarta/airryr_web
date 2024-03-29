require_relative 'base'

class MackerelApiMock
  def self.post
    uri = URI.parse("http://localhost:4567/#{ENV["WEBHOOK_ENDPOINT"]}")
    # webhook parameter sample from https://mackerel.io/ja/docs/entry/howto/alerts/webhook
    params = {
        "orgName": "Macker...",
        "event": "alert",
        "host": {
            "id": "22D4...",
            "name": "app01",
            "url": "https://mackerel.io/orgs/.../hosts/...",
            "type": "unknown",
            "status": "working",
            "memo": "",
            "isRetired": false,
            "roles": [
                {
                    "fullname": "Service: Role",
                    "serviceName": "Service",
                    "serviceUrl": "https://mackerel.io/orgs/.../services/...",
                    "roleName": "Role",
                    "roleUrl": "https://mackerel.io/orgs/.../services/..."
                }
            ]
        },
        "alert": {
            "openedAt": 1473129912,
            "closedAt": 1473130092,
            "createdAt": 1473129912693,
            "criticalThreshold": 1.9588528112516932,
            "duration": 5,
            "isOpen": true,
            "metricLabel": "MetricName",
            "metricValue": 2.255356387321597,
            "monitorName": "MonitorName",
            "monitorOperator": ">",
            "status": "critical",
            "trigger": "monitor",
            "url": "https://mackerel.io/orgs/.../alerts/2bj...",
            "warningThreshold": 1.4665636369580741
        }
    }
    header = {'Content-Type': 'application/json'}

    response = Net::HTTP.post(uri, JSON.dump(params), header)
    puts "status code:#{response.code} / body:#{response.body}"
  end
end

MackerelApiMock.post if $0 == __FILE__
