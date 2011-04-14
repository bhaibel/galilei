require 'rubygems'
require 'sinatra'
require 'haml'

require 'environment.rb'
require 'lib/galilei.rb'
#require File.join((File.dirname(__FILE__), 'lib', 'galilei.rb')

Galilei::App.set :run, false
Galilei::App.set :env, ENV['RACK_ENV']

run Galilei::App