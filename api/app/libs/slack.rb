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
    footer_note = type == 'submitted' ? 'Reply to this person to schedule the intro call.' : 'This person started the form but didn\'t finish. Consider reaching out.'

    name = lead[:name].to_s.empty? ? '(no name)' : lead[:name]
    email = lead[:email].to_s.empty? ? '(no email)' : lead[:email]

    fields = [
      { title: 'Name', value: name, short: true },
      { title: 'Email', value: email, short: true },
      { title: 'Company', value: lead[:company].to_s.empty? ? '(none)' : lead[:company], short: true },
      { title: 'AWS Spend', value: lead[:aws_monthly].to_s.empty? ? '(none)' : lead[:aws_monthly], short: true },
      { title: 'Best Times', value: lead[:availability].to_s.empty? ? '(not specified)' : lead[:availability], short: true },
      { title: 'Campaign', value: lead[:utm_campaign].to_s.empty? ? '(none)' : lead[:utm_campaign], short: true },
      { title: 'Source / Medium', value: "#{lead[:utm_source].to_s.empty? ? '(none)' : lead[:utm_source]} / #{lead[:utm_medium].to_s.empty? ? '(none)' : lead[:utm_medium]}", short: true },
      { title: 'Page', value: lead[:page_url].to_s.empty? ? '(none)' : lead[:page_url], short: true },
      { title: 'Notes', value: lead[:notes].to_s.strip.empty? ? '(none)' : lead[:notes], short: false },
    ]

    # Add timestamps
    fields << { title: 'Created', value: lead[:created_at].to_s, short: true } if lead[:created_at]
    fields << { title: 'Last Updated', value: lead[:updated_at].to_s, short: true } if lead[:updated_at] && type == 'abandoned'

    payload = {
      text: "#{emoji} *#{status_label}:* #{name} (#{email})",
      attachments: [
        {
          color: color,
          fields: fields,
          footer: footer_note,
          ts: Time.now.to_i,
        }
      ]
    }

    slack_post(webhook_url, payload)

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

    slack_post(webhook_url, payload)

  rescue StandardError => e
    puts "[ERROR] Slack digest failed: #{e.class}: #{e.message}"
    return false
  end
end

def slack_post(webhook_url, payload)
  uri = URI.parse(webhook_url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.open_timeout = 5
  http.read_timeout = 5

  request = Net::HTTP::Post.new(uri.path)
  request['Content-Type'] = 'application/json'
  request.body = payload.to_json

  response = http.request(request)
  puts "[SLACK] Sent (#{response.code})"
  return response.code == '200'
end
