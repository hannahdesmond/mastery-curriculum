# Flow of Control

We already know that when we start a Ruby program, some **objects** are made for us.

![A user starting IRB in the terminal, causing a world to come into existence with a window as the 'REPL'](../images/2-numbers.gif)

In [module 2](../chapter2/README.md), we saw that integer objects were ready and waiting for us whenever we set up the Ruby world. And, we **assigned** these pre-existent numbers to **variables**: in other words, we gave them programmer-friendly **names**.

In [module 3](../chapter3/README.md), we found out that we could instruct objects to do things using **messages**. Objects might require **arguments** to be able to answer a message. We learned that the list of messages we can send to an object is called its **interface**. We saw that you could make a good guess at what an object was, based on the **methods** defined on its interface. We also saw that you can **chain** messages, thanks to **referential transparency**.

> **Messages** call **methods** on an object's **interface**.

So far, we've looked a lot at what exists in the program world (objects), and how those things communicate (messages). But our understanding of how messages are handled by methods is fuzzy. What happens _inside_ object methods?

## Going inside methods

Methods contain pre-written instructions for the computer. Just as we have used instructions – line-by-line – to control our program world and everything in it, so object methods contain pre-written lines of instructions to control themselves, and everything inside them.

Let's investigate. How does `1` know to return `true` here?

```eval-ruby
-1.positive?
```

And `-1` knows to return `false`?

```eval-ruby
-1.positive?
```

Let's go inside the `positive?` method defined on the interface of `1`:

<animation showing 'going into' the method defined on these interfaces and seeing some instructions>

Inside `1`'s `positive?` method is a set of instructions (aka some _code_) like this:

```ruby
if self > 0
  return true
else
  return false
end
```

So what the heck do these instructions do?

## Conditional logic

Let's identify the parts of this code:

- `self` is the object that the instructions are within (i.e. the object on which this method is defined). In this case, since we're 'inside' `1`, `self` is `1`.
- `self > 0` is a statement comparing `self` with `0`. It's: 
  - `true` if `self` is greater than `0`. 
  - `false` if `self` is less than or equal to `0`.
- `if` is an instruction to look at the following statement. If it's _not false_, execute the following instructions. If it _is false_, look for an `else`, and execute the instructions following that instead.
- `end` says "OK, return to executing every line as normal, thanks."

There are two ways this code could be executed. In one situation, the computer will `return true`. In the other, the computer will `return false`. The computer must make a choice, depending on the value of `self`.

Let's depict the contents of the `positive?` method as a flow chart, and simplify the chart in the way the computer does.

{% flowchart %}

st=>start: positive?
true=>operation: True
false=>operation: False
cond=>condition: is self > 0?

st->cond
cond(yes)->true
cond(no)->false

st@>cond({"stroke":"Red"})

{% endflowchart %}

Since we're currently inside `1`, we can use referential transparency to replace `self` with `1`. That gives us:

```ruby
if 1 > 0
  return true
else
  return false
end
```

{% flowchart %}

st=>start: positive?
true=>operation: True
false=>operation: False
cond=>condition: is 1 > 0?

st->cond
cond(yes)->true
cond(no)->false

st@>cond({"stroke":"Red"})

{% endflowchart %}

Next, we can use referential transparency again, to replace the statement `1 > 0` with its return value, `true`:

```ruby
if true
  return true
else
  return false
end
```

Update the flow chart, with the obvious conclusion of the flow:

{% flowchart %}

st=>start: positive?
true=>operation: True
false=>operation: False
cond=>condition: is true?

st->cond
cond(yes)->true
cond(no)->false

st@>cond({"stroke":"Red"})@>true({"stroke":"Red"})

{% endflowchart %}

> This kind of process, replacing statements and names via referential transparency, is the first key skill in **computational thinking** (aka, thinking like a computer).

So, when the program world runs the instructions within `1` (i.e. with `self` set to `1`), the result is:

```eval-ruby
if 1 > 0
  return true
else
  return false
end
```

And that's how `positive?` works.

> This process might seem laborious, but I'm trying to get you to think like the computer. In fact, Ruby will translate code statements like `if 1 < 0; else...` into something very similar to the flowchart we made: an [Abstract Syntax Tree](https://en.wikipedia.org/wiki/Abstract_syntax_tree). Being able to deconstruct code into similar structures – whether you verbalise them, draw them out, or something else – is a crucial part of learning to work with code.

The idea of _controlling which instructions get executed and which don't_ is called the **control flow**. There are other ways to adjust the control flow: we'll meet them in a minute.

- _**Draw out flow charts for the following sets of instructions. You should be able to guess the comparison operators. Your aim is to use referential transparency to replace the instructions, chunk-by-chunk, until your flowchart looks like the last one we made.**_

```ruby
if 1 + 2 > 2
  return true
else
  return false
end
```

```ruby
if -1.negative?
  return true
else
  return false
end
```

```ruby
if -1.negative?
  return 150
else
  return 0
end
```

```ruby
if false
  return true
else
  return true
end
```

## Comparison operators

We've seen the comparison operators `>` and `<`. Here are the rest:

```
>
<
==
=>
<=
```

Play in the REPL below to figure out which one means what.

```eval-ruby
1 > 0
```

## `true` and `false`

What the heck are these things `true` and `false`, anyway?

They're objects, of course! And, like `1`, `2`, `3`, and all the other integers, they have meaning in the program world. They represent _boolean values_ in Ruby. `true` and `false`:

* Know about the truth or falsity of things, and
* Know how to interact with each other.

`true` and `false` are used to do logic: often, to manage the control flow. 

In Ruby, the logical operators include: 

```
&&
||
!
```

Play in the REPL below to figure out what they mean:

```eval-ruby
!true
```

## Parentheses

_Generally speaking_, Ruby will evaluate things in parentheses `()` before anything else in a line:

```eval-ruby
!true && false
```

```eval-ruby
!(true && false)
```

> If these two examples are confusing you, use referential transparency to replace each part of the line.

Here's another example:

```eval-ruby
2 * 3 + 2
```

```eval-ruby
2 * (3 + 2)
```

## Repeating instructions

What about if we wanted to do a different kind of instruction? One where we don't want the computer to skip instructions: we want to repeat them.

```ruby
while true
  puts 1
end
```

The code above will output 1, forever. That's because every time the computer reaches the `end` statement, it'll return to the `while true` statement:

