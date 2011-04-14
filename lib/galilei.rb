require File.join(File.dirname(__FILE__), '..', 'environment.rb')
require 'sinatra/base'

class Galilei::App < Sinatra::Base
  STORAGE_DIR = File.join(File.dirname(__FILE__), '..', 'storage')
  
  set :app_file, __FILE__
  set :views, STORAGE_DIR
  
  get '/' do
    Dir.new(STORAGE_DIR).inject("") do |response, filename|
      if filename[0,1] == '.'
        response
      else
        response << "<a href='#{filename}'>#{filename}</a>"
      end
    end
  end
  
  get '/:filename' do
    params[:filename].slice!('.haml')
    haml params[:filename].to_sym
  end
end
