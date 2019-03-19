require 'sinatra'

get '/' do
  File.read('index.html')
end

get '/chapter1/' do
  File.read(File.join('chapter1', 'index.html'))
end

get '/chapter2/' do
  File.read(File.join('chapter2', 'index.html'))
end

get '/chapter3/' do
  File.read(File.join('chapter3', 'index.html'))
end

get '/chapter4/' do
  File.read(File.join('chapter4', 'index.html'))
end

get '/chapter5/' do
  File.read(File.join('chapter5', 'index.html'))
end

get '/chapter6/' do
  File.read(File.join('chapter6', 'index.html'))
end

get '/chapter7/' do
  File.read(File.join('chapter7', 'index.html'))
end
get '/chapter8/' do
  File.read(File.join('chapter8', 'index.html'))
end

get '/chapter9/' do
  File.read(File.join('chapter9', 'index.html'))
end

get '/chapter10/' do
  File.read(File.join('chapter10', 'index.html'))
end
