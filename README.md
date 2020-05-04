# Redmine Disable Overview

## Overview

This plugin disables project overview.

## Installation

To install the Redmine Disable Overview plugin, execute the following commands from the root of your redmine directory, assuming that your RAILS_ENV enviroment variable is set to "production":

    git clone git://github.com/alexbocharov/redmine_disable_overview.git plugins/redmine_disable_overview

More information on installing Redmine plugins can be found here: [http://www.redmine.org/wiki/redmine/Plugins](http://www.redmine.org/wiki/redmine/Plugins "Redmine Plugins")

After the plugin is installed, you will need to restart Redmine for the plugin to be available.

## Uninstall

    Remove your plugin from the plugins folder: #{RAILS_ROOT}/plugins
    Restart Redmine