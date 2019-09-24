# Guide for coaches

Instructions on formatting are in INSTRUCTIONS.md. Hidden code blocks and executable code blocks are especially tricky, so watch out!

In general, the curriculum should introduce concepts through analogy, followed by several links from the analogy to real-life. Aim to build a consistent mental model of programs-as-worlds and objects-as-denizens.

Where possible, include an animation to reference an analogy.

Each chapter _may_ end with a quiz.

## Build and serve using `gitbook-cli`

Run `npm run gitbook-serve`

The app will run on `localhost:4000`.

## Build the app using `gitbook-cli` and serve

Gitbook removed support for REPL integrations and animations in their upgraded version. To continue to provide the Mastery Curriculum using the Gitbook format, we are in the process of migrating to our deployment, utilising the `gitbook-cli` to build the book.

Below are instructions for building the application.

1. Install the required packages by running `npm install`

2. To build the GitBook run the command `npm run build`. This will create a `_book` directory in the current folder.

3. To serve the book locally and check changes, simply run `npm run start`, this will server the app to `localhost:4000`.

## Deploying the book

After making changes to the GitBook, you'll need to rebuild and deploy the application.

Luckily, there's a handy script for that. Just run:

```
./deploy.sh
```

It will rebuild the book and push it up to the current GitHub branch.

## Remove the `_book` directory

Run `npm run clean`.

### Useful links

[gitbook-cli](https://github.com/GitbookIO/gitbook-cli)
