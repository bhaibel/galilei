require File.join(File.dirname(__FILE__), '..', 'environment.rb')
require 'sinatra/base'

class Galilei::App < Sinatra::Base
  set :app_file, __FILE__
  
  get '/' do
    "Hello world!"
  end
end
