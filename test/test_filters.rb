# coding: utf-8

require 'helper'

class TestFilters < Test::Unit::TestCase

  def setup
    root = File.expand_path(File.join(File.dirname(__FILE__), ".."))
    MailFilter::Config.any_instance.stubs(:file).
      returns("#{root}/config/userdata.json.sample")

    @filters = MailFilter::Filters.new

    @test_filter = {
      :name => "test_filter",
      :filter => [ "from", "example@example.com"],
      :search_folder => "INBOX",
      :destination_folder => "INBOX.example"
    }
  end

  def test_add
    @filters.add(@test_filter)

    f = @filters.get("test_filter").first

    assert_equal "test_filter", f[:name]
    assert_equal "from", f[:filter].first
    assert_equal "example@example.com", f[:filter].last
    assert_equal "INBOX", f[:search_folder]
    assert_equal "INBOX.example", f[:destination_folder]
  end

  def test_translate
    t = @filters.translate("header => MyHeader, in INBOX.Test, to INBOX.HeaderTest")

    assert_equal "header", t[:filter].first
    assert_equal "MyHeader", t[:filter].last
    assert_equal "INBOX.Test", t[:search_folder]
    assert_equal "INBOX.HeaderTest", t[:destination_folder]
  end

  def test_delete
    d = @filters.delete("Nagios")
    f = @filters.get("Nagios")

    assert_equal true, f.empty?
  end

end
