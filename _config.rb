#!/usr/bin/env ruby

require 'yaml'


data = YAML.load_file('_raw_config.yml')

# TODO
# Automatic stuff. Read projects from github.


File.open("_config_test.yml", "w") do |f|
  f.write(data.to_yaml)
end
