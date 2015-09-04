Puppet-Slack Reporter
=====================

This is a reporter plugin for Puppet. Once the puppet execution is completed, the reports are sent to the specified Slack Channel. The necessary Slack variables like, `SLACK_URL`, `SLACK_CHANNEL`, etc.. are stored in the hiera backend. This is suitable for Standalone Puppet model. Local facts are computed durin runtime of the script (as facts are mandatory for Hiera Lookup outside puppet)


##### Dependency

RubyGems: `rest-client`, `hiera`


##### Installation

Add the SLACK variables to the Hiera backend

	# common.yml

	---
	slack_channel : '#mychannel'
	slack_botname : 'puppet-bot'
	slack_iconurl : 'http://puppetlabs.com/wp-content/uploads/2010/12/PL_logo_vertical_RGB_lg.jpg'
	slack_url : 'https://hooks.slack.com/services/XXXYYY/XYXYXYXY/xyxyxyxxyxyxyxyxy'

Copy the `slack.rb` file to the `lib/puppet/reports/` folder. Once the file is added, we need to enable this plugin. Add the below lines to the `puppet.conf`

	report=true
	reports = slack, store     # Enabled plugins for the Reports

Once the plugin is enabled, test the plugin by running a simple `puppet apply`


##### Screenshot

![Alt text](/screenshots/slack-puppet.png?raw=true "Slack-Puppet")
