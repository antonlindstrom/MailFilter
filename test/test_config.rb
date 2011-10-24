# coding: utf-8

require 'helper'

class TestConfig < Test::Unit::TestCase

  def setup
    root = File.expand_path(File.join(File.dirname(__FILE__), ".."))
    MailFilter::Config.any_instance.stubs(:file).
      returns("#{root}/config/userdata.json.sample")
    @config = MailFilter::Config.new
  end

  def test_values
    @config.value[:foo] = 'bar'
    assert_equal 'bar', @config.value[:foo]
  end

end
