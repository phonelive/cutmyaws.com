# =============================================================================
# SLACK WEBHOOK HELPER
# =============================================================================
#
# Sends lead notifications to Slack via incoming webhook.
# Webhook URL stored in SSM as /cutmyaws/{env}/slack/webhook_url
#
# =============================================================================

require 'net/http'
require 'uri'
require 'json'

def slack_notify_lead(lead, type: 'submitted')
  webhook_url = ENV['SLACK_WEBHOOK_URL'] || awsssm_get_param("/cutmyaws/#{ENV['env']}/slack/webhook_url")
  return false unless webhook_url && !webhook_url.empty?

  begin
    emoji = type == 'submitted' ? ':tada:' : ':warning:'
    status_label = type == 'submitted' ? 'New Lead' : 'Abandoned Lead'
    color = type == 'submitted' ? '#f97316' : '#ef4444'

    name = lead[:name].to_s.empty? ? '(no name)' : lead[:name]
    email = lead[:email].to_s.empty? ? '(no email)' : lead[:email]

    fields = []
    fields << { title: 'Company', value: lead[:company].to_s, short: true } unless lead[:company].to_s.empty?
    fields << { title: 'AWS Spend', value: lead[:aws_monthly].to_s, short: true } unless lead[:aws_monthly].to_s.empty?
    fields << { title: 'Best Times', value: lead[:availability].to_s, short: true } unless lead[:availability].to_s.empty?
    fields << { title: 'Campaign', value: lead[:utm_campaign].to_s, short: true } unless lead[:utm_campaign].to_s.empty?
    fields << { title: 'Source', value: "#{lead[:utm_source]}/#{lead[:utm_medium]}", short: true } unless lead[:utm_source].to_s.empty?
    fields << { title: 'Notes', value: lead[:notes].to_s, short: false } unless lead[:notes].to_s.strip.empty?

    payload = {
      text: "#{emoji} *#{status_label}:* #{name} (#{email})",
      attachments: [
        {
          color: color,
          fields: fields,
          footer: "cutmyaws.com | #{lead[:page_url] || 'direct'}",
          ts: Time.now.to_i,
        }
      ]
    }

    uri = URI.parse(webhook_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.open_timeout = 5
    http.read_timeout = 5

    request = Net::HTTP::Post.new(uri.path)
    request['Content-Type'] = 'application/json'
    request.body = payload.to_json

    response = http.request(request)
    puts "[SLACK] Notification sent (#{response.code}): #{name} (#{email})"
    return response.code == '200'

  rescue StandardError => e
    puts "[ERROR] Slack notification failed: #{e.class}: #{e.message}"
    return false
  end
end

def slack_notify_digest(summary_text)
  webhook_url = ENV['SLACK_WEBHOOK_URL'] || awsssm_get_param("/cutmyaws/#{ENV['env']}/slack/webhook_url")
  return false unless webhook_url && !webhook_url.empty?

  begin
    payload = {
      text: ":clipboard: *Daily Leads Digest*",
      attachments: [
        {
          color: '#f97316',
          text: summary_text,
          footer: "cutmyaws.com daily digest",
          ts: Time.now.to_i,
        }
      ]
    }

    uri = URI.parse(webhook_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.open_timeout = 5
    http.read_timeout = 5

    request = Net::HTTP::Post.new(uri.path)
    request['Content-Type'] = 'application/json'
    request.body = payload.to_json

    response = http.request(request)
    puts "[SLACK] Digest sent (#{response.code})"
    return response.code == '200'

  rescue StandardError => e
    puts "[ERROR] Slack digest failed: #{e.class}: #{e.message}"
    return false
  end
end
