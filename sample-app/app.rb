#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'haml'
require 'rdiscount'
require 'coderay'

get "/" do
  haml :index
end

post "/" do
  puts params.inspect
  "OK"
end

get "/default.css" do
  content_type "text/css", :charset => "utf-8"
end