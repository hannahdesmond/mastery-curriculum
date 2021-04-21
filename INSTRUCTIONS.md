# Instructions

A guide to understanding the formatting used in the curriculum.

### Important concepts

**important concepts or terminology** are in bold.

### Exercises and activities

Instructions for you to do something (an activity or exercise) look like this:

* _**An instruction for you**_

### Activity examples

Activities are usually followed by a guide as to how I'd do it:

%accordion%See how I'd do this%accordion%

```
There's usually some code to execute in here. You can't generally copy-paste it though.
```

%/accordion%


### Extensions or tangents

> If something isn't directly related, but might be interesting, provide context, or more information, it'll be in a blockquote (like this).

### Code blocks: interactive and non-interactive

There are two kinds of code examples in this curriculum. In some of them, you can play with the Ruby code in-browser. These look like this:

```eval-ruby
1 + 1
```

> You can and should play with the interactive code samples. Try changing one number to another, or one sign around, or adding extra things. Each time, try to develop a picture of what's happening in the program world when you make changes.

Another kind of code example is non-interactive. They look like this:

```
$> irb
 >
```

In these code examples, I'll include the IRB prompt as a chevron ('`>`'). You don't need to enter the chevron into your IRB. If I'm typing in the console (Terminal), rather than in IRB, I'll include the prompt as a dollar-chevron `$>`. Again, you don't need to enter the dollar-chevron into the console.

> Each line of the interactive code examples can be typed into IRB as a separate instruction. In Ruby, generally speaking, a newline (↵) means 'execute this instruction'. IRB allows you to send line-by-line instructions: interactive examples allow you to queue up instructions to send one after the other.

When I want to illustrate something but I don't want the code to be executed, I'll put a hashtag (`#`) in front of the code:

```ruby
# This line of code will not be executed.
```

Have fun! [Head to the first chapter](./chapter1/README.md)
