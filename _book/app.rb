require 'sinatra'


get '/' do
  File.read(File.join('public', 'index.html'))
end

get '/chapter1/' do
  File.read(File.join('public/chapter1', 'index.html'))
end
