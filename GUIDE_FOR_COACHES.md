# Guide for coaches

Instructions on formatting are in INSTRUCTIONS.md. Hidden code blocks and executable code blocks are especially tricky, so watch out!

In general, the curriculum should introduce concepts through analogy, followed by several links from the analogy to real-life. Aim to build a consistent mental model of programs-as-worlds and objects-as-denizens.

Where possible, include an animation to reference an analogy.

Each chapter _may_ end with a quiz.

## Building the app using `gitbook-cli`

Gitbook removed support for REPL integrations and animations in their upgraded version. To continue to provide the Mastery Curriculum using the Gitbook format, we are in the process of migrating to our deployment, utilising the `gitbook-cli` to build the book.

Below are instructions for building the application.

1. Install the required packages by running `npm install`

2. To build the GitBook run the command `npm run build`. This will create a `_book` directory in the current folder.

3. To serve the book locally and check changes, simply run `npm run serve`, this will server the app to `localhost:4000`.

## Preparing the book for deployment

In order to deploy the book to Heroku, the book needs to be migrated to use a Sinatra server.

1. Run `bundle install` to install the `sinatra` gem

2. Copy the `gitbook` and `images` into a `public` directory within the `_book` directory.

2. Create an `app.rb` file in the `_book` directory, and set up the following code:

```
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
```





### Useful links

[gitbook-cli](https://github.com/GitbookIO/gitbook-cli)
