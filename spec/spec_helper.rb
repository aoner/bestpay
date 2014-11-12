ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'rack'
require 'rack-protection'
require 'rspec'
#require 'rspec-html-matchers'

require './lib/bestpay'
