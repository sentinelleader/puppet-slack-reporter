#####
# Use it freely as u wish :)
###

require 'puppet'
require 'hiera'
require 'rest-client'

Puppet::Reports.register_report(:slack) do

  desc <<-DESC
  Send notification of puppet run reports to Slack Messaging.
  DESC
  scope = (Facter.to_hash).to_yaml      # Computing the local facts
  hiera = Hiera.new(:config => "/etc/puppet/hiera.yaml")
  SLACK_CHANNEL = hiera.lookup('slack_channel', 'common', scope)
  SLACK_BOTNAME = hiera.lookup('slack_botname', 'common', scope)
  SLACK_ICONURL = hiera.lookup('slack_iconurl', 'common', scope)
  SLACK_URL = hiera.lookup('slack_url', 'common', scope)

  def process
    RestClient.post "#{SLACK_URL}", { :channel => "#{SLACK_CHANNEL}", :username => "#{SLACK_BOTNAME}", :icon_url => "#{SLACK_ICONURL}", :text => "`#{self.host}: Puppet run Status: #{self.status} at #{Time.now.asctime}`" }.to_json, :content_type => 'application/json'
    self.logs.each do |log|
      RestClient.post "#{SLACK_URL}", { :channel => "#{SLACK_CHANNEL}", :username => "#{SLACK_BOTNAME}", :icon_url => "#{SLACK_ICONURL}", :text => "`#{self.host}: #{log}`" }.to_json, :content_type => 'application/json'
    end
  end
end
