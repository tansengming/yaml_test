require 'yaml'
require 'md5'

module YAMLTest
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def yaml_test(klass, yaml_file)
      tests = YAML.load(open(yaml_file))
      tests.each do |test|
        text, expected, method = test['text'], test['expected'], test['method']
        assertion = test['assertion'] || 'assert_equal'
        raise ArgumentError if text.nil? or expected.nil? or method.nil? or method.strip.empty? or assertion.nil?

        unless test['ignore']
          define_method('test_'+ MD5.new(text + expected + method + assertion).to_s) do
            send(assertion.strip, expected, klass.new(text).send(method.strip).to_s)  
          end      
        end
      end
    end
  end    
end

