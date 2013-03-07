#!/usr/bin/env ruby

require 'yaml'

#raw = YAML.load_file('_raw_config.yml')
#puts raw.inspect

data = {
  :safe => false,
  :source => ".",
  :lsi => false
}

File.open("_config_test.yml", "w") do |f|
  f.write(data.to_yaml)
end
