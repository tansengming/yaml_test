require 'helper'

class TestYamlTest < Test::Unit::TestCase
  include YAMLTest
  
  yaml_test String, File.expand_path('../tests.yml', __FILE__)
end
