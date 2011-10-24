# coding: utf-8

begin
  require 'rubygems'
rescue LoadError
end

require 'net/imap'
require 'net/http'
require 'multi_json'
require 'fileutils'
require 'logger'

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require 'mailfilter/main'
require 'mailfilter/config'
require 'mailfilter/filters'
require 'mailfilter/logging'
require 'mailfilter/imap'

module MailFilter
  VERSION = '0.0.1'

  extend self

  def config
    @config ||= MailFilter::Config.new
  end
  
  def log
    @log ||= MailFilter::Log.new
  end

end
