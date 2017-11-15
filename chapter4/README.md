# Other objects

We already know that when we start a Ruby program, some **objects** are made for us.

<gif (from before) demonstarting program starting and some numbers coming into existence: zoom in on the numbers to show they exist>

In [module 2](./2_variables_and_statements.md), we saw that numbers were ready and waiting for us whenever we set up the Ruby world. And, we **assigned** these pre-existent numbers to **variables**: in other words, we gave them programmer-friendly **names**.

> **Naming** is the process of **assigning variables** to objects.

In [module 3](./3_messages_and_interfaces.md), we found out that we could instruct objects to do things using **messages**. Objects might require **arguments** to be able to answer a message. We learned that the list of messages we can send to an object is called its **interface**. We saw that you could make a good guess at what an object was, based on the **methods** defined on its interface. We also saw that you can **chain** messages, thanks to **referential transparency**.

> **Messages** call **methods** on an object's **interface**.

So far, we've mostly been working with two types of object: integers and floats. They're all pre-created at the point the program world starts up. This module will ask:

* what other objects exist in this world?
* what are they for?
* how do we make new objects?

## In The Beginning

Ruby defines three more useful objects on program startup:

- `true`
- `false`
- `nil`

`true` and `false` are referred to as _booleans_. They:

* Know about the truth or falsity of things, and
* Know how to interact with each other.

- _**`true` and `false` can be used to do some logic. In Ruby, the logical messages are `&&`, `||`, and `!`. By playing with `true` and `false` in IRB, figure out what these logical operations do.**_

`nil` quite simply represents _nothing_. It is used to expressly say 'there is an absence of anything here'.

> If you come from a language that uses `void`, `nil` is Ruby's equivalent to the `void` return type.

- _**Figure out similarities and differences between `nil`, `0`, and `false` by playing with `nil` in IRB.**_

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

We can't achieve the above just using numbers (well, not easily). We're going to need an object that stores and understands _text_, too.

But where does it come from?

## `Classes` are the creators of all things

Right before our universe made the numbers, it made the gods. 

In the program world, we call these gods **Classes**. They created all the objects that pre-exist, and through them all new objects will be created. Each class – each god – is responsible for creating certain kind of objects: 'their' objects.

Just like in myths from Ancient Greece, these 'gods' exist as objects inside the universe, and we can send them messages. Mostly, we send them messages asking them to create new objects in the program world. 

> Objects created by these classes are called **Instances** of that class. You could think of instances as being 'avatars of a god'.

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

We, too, can send the message `new` to these classes. This is how we create new objects: new instances of that class.

> This process is called **instantiation**.

Let's imagine that we wanted to populate our world with people. Each person has a height. Let's also imagine that Ruby pre-defined a `Person` class. Here's how we'd instantiate people: each time, asking the god of `Person`s to create a new instance with a certain height:

```irb
> Person.new(120)
=> #<Person:0x007fadf70c53d0>
> Person.new(160)
=> #<Person:0x007fadf88045f0>
```

> Notice how we pass the person's height to `Person` along with the `new` message. We'll find out more about how this works later.

What the heck is this `#<Person:0x007fadf88045f0>` stuff?! Well – when we tell a class to create a new instance, Ruby gives us instance we just created:

<decomposition of #<Person:0x007fadf88045f0>>

## Introducing Strings

We want a class whose instances understand working with text. Ruby provides a god for this: the `String` class. The `String` class creates instances which: 

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

Much of Ruby programming is about identifying the right class to create instances for a particular job. To that end, Ruby provides you a wide range of different classes, with different purposes: like `Integer` and `String`.

> In the next module, we'll meet a very useful class: `Array`.

Of course, these classes create instances that have quite different purposes. `Integer` instances understand the value of (whole) numbers, and `String` instances understand text. `Integer` instances (integers) know how to interact with other integers, and `String` instances (strings) know how to interact with other strings.

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

Notice that the interfaces of both instances of `String` and instances of `Integer` define methods for the message `+`: even though `+` does quite different things in each case (for integers, `+` adds, for strings, `+` concatenates). Messages are interpreted differently depending on the kind of object being interacted with.

## Class and Instance interfaces

It's easy to get confused between classes and instances. The simple solution is: Class objects produce Instance objects: they are not the same object. A God of Fire is not the same object as a lit match. A God of Water is not the same object as a puddle.

Because Classes are different objects to Instances, they have different interfaces. For instance: `String` defines `new` on its interface. When called, `String.new` produces a new instance of `String`. This instance, however, does not define `new` on its interface, because it's not a class and so isn't responsible for creating new instances.

```eval-ruby
string_instance = String.new("some words")
string_instance_instance = string_instance.new
```

Decomposing that error:

<diagram of error decomposition>

And visually depicting what we're trying to do:

<gif showing calling #new on a class and on an object>

* The methods defined on a class interface are called the `class methods`. 
* The methods defined on an instance interface are called the `instance methods`.

> `String`'s _class methods_ include `new`. `String`'s _instance methods_ include `capitalize` and `+`.

## Printing using the main object

Remember that the entire program world is contained within a Universe: the Main Object.

The Main Object is a special kind of instance: an instance of the `Object` class. When we call methods in IRB without addressing a particular object, we're calling them on the Main Object.

- _**Use the `methods` message in IRB to list the methods on the main object.**_
- _**Send the main object the message `quit`.**_
- _**Diagram what just happened.**_

> Ultimately, all classes are themselves instances of the `Object` class. So if a monotheistic version of the program universe appeals to you, you could think of `Object` as being the 'one true' god entity in Ruby. It's not very specialised – so it doesn't create objects that are very useful for us.

One of the useful purposes of the Main Object is to output information from the program. `Object` instances have a method called `puts` (shorthand for '**put s**tring'). It can be used to print information from the program:

```irb
> puts String.new("I am being printed out!")
I am being printed out!
=> nil
```

<gif demonstrating the use of `puts`>

> Why do you think Ruby prints the string, then returns `nil`?

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

