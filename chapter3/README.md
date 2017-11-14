# Messages and Interfaces

Our REPL provides us with a window through which we can interact with the program world. But how does that interaction happen? And what kinds of interaction are allowed?

## Messages

We interact with the program world by sending it **messages**. In our REPL, by default we're interacting with the Main Object (the 'Universe').

<gif showing me interacting with the main object by sending it messages>

The main object will then figure out what to do with the message. Just as we, the user, send the main object messages, so the main object can send other objects messages.

Here's a visual depiction of us, the programmer, interacting with the REPL by requesting an object by name (`one`). Provided that we have defined this variable, the REPL goes and fetches the object referenced by that name:

<gif showing me interacting with the main object by sending it the message `one` and it figuring out to get me the '1' object>

Now that we have the object referenced by `one`, we can send it messages directly. For instance, we can send it the '`+`' message, telling it to add another number to itself, and return the result:

<gif showing me executing `1 + 2` and the resulting messages that are sent in the world>

Or, we can send the object referenced by `one` other messages, like `integer?`, to tell us about itself:

<gif showing me executing `1.integer?` and the resulting messages that are sent in the world>

Note the difference between those two messages we just sent to the object referenced by `1`:

```ruby
1 + 2
1.integer?
```

In both cases, we're sending a message to an object – but in the first case, we've got a space before the message `+`, making the statement look like a regular sum. In the second case, we've got this crazy dot thing between the object and the message. What gives?

## Dot syntax

What might surprise you is that the second way is, secretly, the only way to send messages to objects in Ruby. The `.` (**dot**) means 'send this object a message'. `1.integer?` means "send the object referenced by `1` a message asking it to answer if it's an integer or not."

In the first case, `1 + 2`, Ruby is actually translating this to `1.+ 2`. We say, and see, 'one plus two', and Ruby translates that to "send the object referenced by `1` a message to add itself to the object referenced by `2`."

So why does Ruby permit us to use this non-dot-syntaxy way of sending messages? In short, convenience.Ruby was designed to read as similarly to English as possible. These sorts of 'edge cases' – where Ruby syntax differs from normal – are rare. They're referred to as 'syntactic sugar' – because they are, quite literally, _sweeteners_ on top of the rules of the language.

- _**Convert your numeral calculator to use dot syntax.**_

## Interfaces

What determines the possible things that can be sent to a particular object? If we wanted to, could we try:

```irb
> 1.any_message_i_want
=> ???
```

Of course not. Objects have a limited number of possible messages they can be sent. In fact, it's this very set of messages that mostly determines what an object _is_ in Ruby. For instance, if an object responded to a set of messages like this:

```irb
> object.bark
=> "woof!"
> object.wag_tail
=> "wag wag wag"
> object.dream_about_chasing_things
=> "*twitches*"
```

Then you could pretty reasonably figure out what that object is (a dog, if you were guessing).

The set of messages that can be sent to an object is called its **interface** (from _inter_ (between) and _face_ (form) – so literally the shape of the space 'between objects'). A message that can be received by an interface is called a **method**. 

Interfaces are a list of object methods. Methods make up the interfaces of objects.

<diagram of the above>

How do we find out what an object's interface is? Two ways:

1. All Ruby objects have a method called `methods` defined on their interface. If you call it, you get a list of every method defined on that object's interface.
2. Object interfaces are detailed in documentation, along with examples of how to use those interfaces. For instance, here's the [documentation for integers](https://ruby-doc.org/core-2.2.0/Integer.html).

> If you're using the docs, right now we're using the word _interface_ interchangeably with _public instance methods_. We'll go deeper in the next module!

- _**Find out every method defined on the interface of the object referenced by `1` (you don't have to memorise them).**_

> Many beginner programmers feel like they have to memorise every method on an object's interface. That's not true. While there are core methods you should learn – like `+`, `-`, and so on – it's far more useful to get good at looking methods up. One benefit to Ruby methods is they're well-named: they usually do just what they say on the tin.

## Integers and floats

Something pretty weird happens when we do divison with our numeral calculator:

```irb
> nine / two
=> 4
```

What's going on here? 

The problem is that _integer objects don't understand decimal points, so they round them down_: 9/2 is 4.5, which the integer referenced by `nine` rounds down to 4.

To use decimal points, we need to use a different kind of number: a **float** (short for 'floating point number' – that is, the decimal point can float anywhere along the line of numbers).

Here are some example floats:

```
 1.6
28.004
-0.41
```

Floats have a very specific purpose in programs: to do very fine calculations usually involving division, and as such they're rarely-used (as [Chris Pine points out](https://pine.fm/LearnToProgram/chap_01.html), who wants to look at 7.4 emails, or browse 1.8 webpages, or listen to 5.24 of their favorite songs?). But we need floats now!

When we send an integer object the message `to_f`, the integer object says "OK! You're looking for a float object with the same value as me", and returns that corresponding float object:

```
> 4.to_f
=> 4.0
```

We can now divide this returned float object by another integer (or another float):

```
> 4.to_f / 5
=> 0.8
```

Of course, this is going to get pretty ugly for our poor numeral calculator. We don't want to be jamming `to_f` on the first numeral every time we want to do division; it destroys readability:

```
> four.to_f / five
=> 0.8
```

- _**Figure out how to rewrite your numeral calculator to achieve the following functionality:**_

```
> four / five
=> 0.8
```



