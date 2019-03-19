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

2. Create an `app.rb` file in the `_book` directory, and set up the following code:

```
require 'sinatra'


get '/' do
  File.read(File.join('public', 'index.html'))
end

```





### Useful links

[gitbook-cli](https://github.com/GitbookIO/gitbook-cli)
