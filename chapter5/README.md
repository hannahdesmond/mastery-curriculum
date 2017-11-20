# Other objects

We already know that when we start a Ruby program, some **objects** are made for us.

<gif (from before) demonstarting program starting and some numbers coming into existence: zoom in on the numbers to show they exist>

In [module 2](./2_variables_and_statements.md), we saw that numbers were ready and waiting for us whenever we set up the Ruby world. And, we **assigned** these pre-existent numbers to **variables**: in other words, we gave them programmer-friendly **names**.

> **Naming** is the process of **assigning variables** to objects.

In [module 3](./3_messages_and_interfaces.md), we found out that we could instruct objects to do things using **messages**. Objects might require **arguments** to be able to answer a message. We learned that the list of messages we can send to an object is called its **interface**. We saw that you could make a good guess at what an object was, based on the **methods** defined on its interface. We also saw that you can **chain** messages, thanks to **referential transparency**.

> **Messages** call **methods** on an object's **interface**.

So far, we've mostly been working with a few kinds of object: 

- integers 
- floats
- true
- false

They're all pre-created at the point the program world starts up. This module will ask:

* what other objects exist in this world?
* what are they for?
* how do we make new objects?

## `nil`

`nil` quite simply represents _nothing_. It is used to expressly say 'there is an absence of anything here'.

> If you come from a language that uses `void`, `nil` is Ruby's equivalent to the `void` return type.

- _**Figure out similarities and differences between `nil`, `0`, and `false` by playing with `nil` in IRB.**_
- _**Use the following example to figure out: is `nil` considered true, or false? How about `0`?**_

```eval-ruby
if false
  if nil
    return 0
  end
else
  if 0
    return 0
  end
end
```

## OK, what else?

Other than `true`, `false`, `nil`, and numbers (which, if you read the extension material, you'll know don't _really_ exist as objects until you ask for them by name), there aren't many immediately-useful objects around in a Ruby program by default. Your main job as a programmer is to make new objects to perform certain tasks.

What sort of certain tasks? Let's pick a basic task from our Todo app:

```sh
$> todo add put the dog in the car
Todo added: Put the dog in the car
```

In other words,

- We want the user to be able to input text (a 'todo'), and retrieve it later. 
- We might also want to manipulate that text: perhaps, to capitalize it.

We can't achieve the above just using numbers (well, not easily). We're going to need an object that stores and understands _text_, too. In a moment, we'll meet that object: the string.

But, before we start working with strings, we're going to answer: where do all these objects come from?

## `Classes` are the creators of all things

Right before our universe made the numbers, it made the gods. 

In the program world, we call these gods **Classes**. They created all the objects that pre-exist, and through them all new objects will be created. Each class is responsible for creating certain kind of objects: 'their' objects.

Just like in myths from Ancient Greece, these 'gods' exist as objects inside the universe, and we can send them messages. Mostly, we send them messages asking them to create new objects in the program world. 

> Objects created by these classes are called **Instances** of that class.

One such 'god-like' object is the `Integer` class. Integers, like 1, 2, and 5, are 'instances of the Integer class'.

When we start `irb` and the integers come into existence, they are created by this particular god. How does that happen?

> The true answer is complex, but for now we'll simplify.

When we want to ask a Ruby class to create an instance of itself, we send it the message `new`. So it's reasonable to imagine that, when the program world starts, Ruby automatically does this sort of thing to create the pre-existing integers 'behind the scenes':

```ruby
1 = Integer.new
#=> 1
2 = Integer.new
#=> 2
3 = Integer.new
#=> 3
# and so on
```

<gif demonstrating calling `new` on Integer and the numbers coming out of it>

> If you try to run the `Integer.new` code above, you'll get an error. Again, the reasons are complex and have to do with the deep-level implementation of Ruby. If you want to learn more, [here's some reading](https://stackoverflow.com/questions/3430280/how-does-object-id-assignment-work). For now, we're using `Integer.new` to illustrate how instances are created from classes.

## Creating new objects in the world

We, too, can send the message `new` to these classes. This is how we create new objects (new instances of that class).

> The process of asking classes to create instances is called **instantiation**.

Let's imagine that we wanted to populate our world with people. Each person has a height. Let's also imagine that Ruby pre-defined a `Person` class. Here's how we'd instantiate people: each time, asking the god of `Person`s to create a new instance with a certain height:

```irb
> Person.new(120)
=> #<Person:0x007fadf70c53d0>
> Person.new(160)
=> #<Person:0x007fadf88045f0>
```

> Notice how we pass the person's height to `Person` along with the `new` message. We'll find out more about how this works later.

So what's with this `#<Person:0x007fadf88045f0>` thing? Simply: when we tell a class to create a new instance, Ruby gives us the instance we just created:

<decomposition of #<Person:0x007fadf88045f0>>

> The 'memory address' is a number the program uses to remember where objects are physically stored on the computer so it can read and write from and to that object. This is similar to a street address on a postcard, which the postal system uses to remember where your house is, so it can send and receive mail to and from your house. If you're interested, the first minute of [this video](https://www.youtube.com/watch?v=F0Ri2TpRBBg) is a little more thorough, and [this video](https://www.youtube.com/watch?v=TQCr9RV7twk) dives deeper into the awesome history of computer memory.

> `0x007fadf88045f0` might not seem like a number, but it is: a [hexadecimal number](https://www.mathsisfun.com/hexadecimals.html)

## Introducing Strings

We want a class whose instances understand working with text. This 'god of text' is provided by Ruby: the `String` class. The `String` class creates instances which: 

* Know about some text we give it, and 
* Know how to interact with other instances of the `String` class.

> We call instances of the `String` class 'strings'.

We need an object that stores and can manipulate some text. What better object than an instance of `String`?

* _**Assign a variable `todo_1` to a new instance of `String`, storing the text `"wash the dog"`.**_
* _**Send the string referenced by `todo_1` a message that activates the `capitalize` method on its interface.**_

%accordion%See how I'd do this%accordion%

```eval-ruby
todo_1 = String.new("wash the dog")
todo_1.capitalize
```

%/accordion%


<Animation showing String being called into existence, knowing about the text, and capitalizing>

## Different objects, different purposes

When programming, we often stop to think: "what's the right class to create instances for this particular job?" 

To that end, Ruby provides you a wide range of different classes, with different purposes: like `Integer` and `String`.

Objects created by these classes have quite different purposes. `Integer` instances understand the value of (whole) numbers, and `String` instances understand text. `Integer` instances (integers) know how to interact with other integers, and `String` instances (strings) know how to interact with other strings.

Even though they're different kinds of objects used for different purposes, these objects sometimes respond to the same message – but their methods might do quite different things with those messages.

What happens if integers try to interact with strings? In other words, what happens if instances of one class try to interact with instances of another?

* _**Assign to the variable `one_string` a new instance of `String`, with the text `"1"`.**_
* _**Assign to the variable `two_string` a new instance of `String`, with the text `"2"`.**_
* _**Tell `one_string` to return the result of adding itself to `two_string`**_
* _**Explain what happens, and why it's different from the `1 + 2` statement we did with instances of `Integer`.**_
* _**Try adding together a string with an integer. Explain what happens.**_

%accordion%See how I'd do this%accordion%

```eval-ruby
one_string = String.new("1")
two_string = String.new("2")
one_string + two_string
```

%/accordion%


> As you can see, messages are interpreted differently depending on the kind of object they were sent to.

## Class and Instance interfaces

It's easy to get confused between classes and instances, because they're both objects and they both exist in the program world. Both classes and instances have memory addresses: so their difference in purpose is purely a decision taken by Ruby designers.

> Class objects produce Instance objects: they are not the same object. A god of Fire is not the same object as a lit match. A god of Water is not the same object as a puddle.

Because Classes are different objects to Instances, they have different interfaces. For example: `String` defines `new` on its interface. When called, `String.new` produces a new instance of `String`. String instances, however, do not define `new` on their interfaces, because they're not classes – and so they're not responsible for creating new instances.

```eval-ruby
string_instance = String.new("some words")
string_instance_instance = string_instance.new
```

Decomposing that error:

<diagram of error decomposition>

And visually depicting what we're trying to do:

<gif showing calling #new on a class and on an object>

> The methods defined on a class interface are called the `class methods`. The methods defined on an instance interface are called the `instance methods`.

> `String`'s _class methods_ include `new`. `String`'s _instance methods_ include `capitalize` and `+`.

## The main object

Remember that the entire program world is contained within a Universe. That Universe is the Main Object.

The Main Object is a special kind of instance: an instance of the `Object` class. When we call methods in IRB without addressing a particular object, we're calling them on the Main Object.

- _**Use the `methods` message in IRB to list the methods on the main object.**_
- _**Send the main object the message `quit`.**_
- _**Explain what just happened.**_

> Ultimately, all classes are themselves instances of the `Object` class. So if a monotheistic version of the program universe appeals to you, you could think of `Object` as being the 'one true' god entity in Ruby. It's not very specialised – so it doesn't create objects that are very useful for us.

## Input and Output

#### Output

We've already seen two ways to get output from a program:  

1. Send a message to an object in the REPL. The REPL will print that object method's return value.
2. Use `puts` to print a value (even if it's not a return value).

Let's quickly investigate the difference between the two.

- _**What's going on here? Why is the return value `nil`?**_

```eval-ruby
puts String.new("Hello World!")
```

%accordion%Here's my explanation%accordion%

Here's my explanation: the REPL treats you, the REPL-typer, as if you (the programmer) were _just another object in the program_. When you ask an object something – say `1.integer?`, `1` treats that message as if it arrived from another program object. So, you get the return value (`true`), which is helpfully shown to you in the REPL.

On the other hand: the method `puts` doesn't expect to be used from a REPL. It's designed to output information from the program to the console when you're _not_ using the REPL – in other words, when you're not 'inside' the program. `puts` actually does two things: outputs information to the console, and then returns `nil`.

%/accordion%

> `puts` is used a lot in pre-written programs, because it's one of the only ways to 'see into' the program world when you're not using a REPL.

#### Input

How, then, do we _input_ to a program? Again, there are two ways:

1. Use the REPL to instruct the program, or objects in the program, directly.
2. Use `gets` to input a string from 'outside the program'.

- _**Investigate the difference between the two. Keep in mind the idea of being 'just another object in the program' when you're using the REPL.**_

`gets` (which stands for 'get string') is very useful to add information on-the-fly to a program: the sort of thing we might need to do, say, if we were writing a build-your-own text adventure game. Which is totally what we're doing in the next module.

> `gets` calls a method on the main object. This method returns a string. This string usually has a `\n` newline character in it. To get the string without the newline, use the string `chomp` method. A line of code using `gets` usually looks something like this: `user_input = gets.chomp`.


## Putting it all together

Let's build out the first part of our Todo app.

- _**Start up IRB.**_
- _**Define variables for three new instances of the `String` class: `todo_1`, `todo_2`, and `todo_3`. Each one should store some text with a todo item.**_
- _**Create a pre-written world containing `todo_1`, `todo_2`, and `todo_3`, then print them immediately.**_

You should be able to run:

```bash
$> irb -r ./todo.rb
```

And immediately see:

```irb
This is todo item 1
This is todo item 2
This is todo item 3
>
```

- _**Make it so the user can add a fourth todo item of their choice. This program should run outside of the REPL.**_
