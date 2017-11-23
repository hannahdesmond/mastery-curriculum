# Writing your own Classes

We've been spending a lot of time writing complex procedures. We've spent a lot of time _telling the computer how to get to the answer_:

```eval-ruby
# set up some scores
scores = [19, 17, 12]

# make an accumulator
accumulator = 0

# start a loop
scores.each do |score|
  # accumulate each score
  accumulator += score
end

# divide the accumulator, as a float, by the number of scores
accumulator.to_f / scores.length
```

- _Telling the computer how to get to the answer_ might look like: "create an accumulator. Add the scores to it. Then divide them." This is called **imperative** programming – literally, 'ordering the computer to do things'.

In [Chapter 9](../chapter9/README.md), we started seeing how we could take these imperative procedures and hide them behind _method names_. This means that our code looks more like the high-level idea of _telling the computer what we want_, by interacting with abstractions:

```ruby
# average some scores, please
average(scores)
```

- _Telling the computer what we want_ might look like "average these scores." This is called **declarative** programming – literally, 'saying what we would like to happen'.

When we're writing complex procedures, we're often working in a very _imperative_ world. We're handling things like _control flow_ with _conditionals_ and _loops_, working with simple objects like _arrays_, _strings_, _hashes_, and _integers_. It's a tough world, and it's quite unfriendly to non-programmers.

Therefore, as programmers, we try to abstract our work to a declarative style wherever possible. This is why I introduced you first to the program world: because it's a declarative world, where you can ask `1` if it's an integer:

```eval-ruby
1.integer?
```

And it'll just _tell you the answer_.

These are the kinds of worlds we strive to create as programmers. One very popular route to doing so is to use **Object-Oriented Programming**. We've met a bunch of this already, but here's a quick refresher:

```eval-ruby
# String is a class – an object in the program world.
# When we send the message 'new' to it, the class figures out how to make an instance
# my_string is an instance of the String class. It's also an object in the program world: a new one
my_string = String.new("Hello World")

# We can tell my_string to do things, declaratively
# Here, we'll tell my_string to return its text in uppercase
# We don't really have to care about how the computer makes this happen
# (maybe it iterates through the list of characters and upcases each one?)
# All we care about is that it's easy to do
my_string.upcase
```

In this chapter, we'll learn how to move from an imperative to a declarative world, by: 

- defining new methods on object interfaces, then 
- defining whole new objects.

## Back to the program world

Remember our view of the program world:

<objects interacting in the program world>

In particular, remember where all the complex imperative procedures we've been writing are actually running:

<zoom in on object interface to reveal methods working 'inside'>

That's right – procedures are running inside methods. We learned how to write methods in [Chapter 9](../chapter9/README.md) – but the methods we defined weren't obviously part of any given object's interface. So where have they been living?

## Global scope

In [Chapter 3](../chapter3/README.md), we learned that whenever you send a message to an object _without specifying the object_, that message is sent to the main program object:

```eval-ruby
+(3)
```

So, for the past few chapters we've been defining all of our procedures on the main program object. When we write:

```eval-ruby
players = [
  { :name => "Sam", :sport => "tennis" },
  { :name => "Mary", :sport => "squash" },
  { :name => "Ed", :sport => "tennis" },
  { :name => "Mark", :sport => "football" }
]

players_by_sport = {}

players.each do |player|
  sport = player[:sport]

  if players_by_sport[sport] == nil
    players_by_sport[sport] = []
  end

  players_by_sport[sport].push(player[:name])
end

players_by_sport
```

...we're defining variables on the main program object, creating objects inside the main program object, and returning values to the main program object (which, if we're using a REPL, the main program object returns to us). 

When we wrote the `average` method:

```eval-ruby
def average(scores)
  scores_accumulator = 0

  scores.each do |score|
    scores_accumulator += score
  end

  scores_accumulator.to_f / scores.length
end
```

We defined this method _on the main object_.

> In Ruby, there are no 'objectless methods'.

## Defining methods on objects

Remember that the main program object is an _instance of the `Object` class_. Here's how we'd define the `average` method on the main object formally:

```eval-ruby
class Object
  def average(scores)
    scores_accumulator = 0

    scores.each do |score|
      scores_accumulator += score
    end

    scores_accumulator.to_f / scores.length
  end
end

average([1, 2, 3])
```

> Notice that we're _opening up the class_ to fiddle with its insides. We're essentially _rewiring the gods_ so they create slightly different kinds of things.

The above simply a more formal way of writing:

```eval-ruby
def average(scores)
  scores_accumulator = 0

  scores.each do |score|
    scores_accumulator += score
  end

  scores_accumulator.to_f / scores.length
end
```

Because, by default, _methods are defined on the main object_.

How about if we wanted to define a method on another object? Say, something that would allow us to do:

```irb
> my_object = "A string!"
> my_object.say_hi
=> "Hi there!"
```

That is: when we send the message `say_hi` to a string, it should return `"Hi there!"`.

`say_hi` is not, by default, part of the instance methods available to strings. So, we have to define it, just like we did the `average` method on `Object` instances:

```eval-ruby
class String
  def say_hi
    "Hi there!"
  end
end

my_object = "A string!"
my_object.say_hi
```

> Again: we're _opening the String class_ to fiddle with the kinds of objects it creates. In this case, we're telling the `String` class: "when you create instances, make sure they have this method, too".

- _**Define another method on the string above, called `say_hi_to`. It should take one argument, a name. It should return "Hi, <name>!"**_

## Using object state in methods

Let's do something useful with this information. Our `average` method would be even more ace if we could just go:

```ruby
[1, 2, 3].average
```

> `[1, 2, 3].average` feels far more declarative than `average([1, 2, 3])`. It uses the familiar dot syntax, too.

To do this, we need to define a new method on `Array` instances:

```eval-ruby
class Array
  def average
    # Somehow, do the averaging in here
  end
end
```

But we have a problem – in order to average an array of number elements, we need access to those elements. Instances of the `Array` class know about their own elements: but how can we access them?


Enter the Ruby keyword `self`. `self` refers to the 'current object we're inside'. So, when we're messing around defining methods on `Array` instances, `self` refers to the instance.

```eval-ruby
class Array
  def average
    return self
  end
end

[1, 2, 3].average
```

> Notice that we get the array instance itself back when we call `self`.

We can use `self` to access the array instance's own elements, and average them:

```eval-ruby
class Array
  def average
    accumulator = 0

    self.each do |element|
      accumulator += element
    end

    accumulator.to_f / self.length
  end
end

[1, 2, 3].average
```

- _**Define a method on string instances, called `shoutify`. This method should return the string text in uppercase, with an extra exclamation mark on the end. In other words, `"hello world".shoutify` should return `"HELLO WORLD!"`.**_

## Defining your own classes

We've just seen how to use the `class` keyword to 're-open' existing classes and mess around with the instances they make. We can also use this `class` keyword to define entirely new classes – new gods – each of which can create whole new instances.

We're going to try and build the following program:

```ruby
fido = Dog.new

fido.bark
# We should see "Woof!"
```

We can actually let our error messages tell us what to do at each stage. This is a helpful way to figure out what we need to do next, step-by-step. Let's try running our program as-is:

```eval-ruby
fido = Dog.new
fido.bark
```

OK, we have an error: `uninitialized constant Dog`. What's this telling us? It's saying "I couldn't find a name 'Dog'". Let's make one!

```eval-ruby
Dog = "a dog"

fido = Dog.new
fido.bark
```

I did the simplest thing, and we have a new, explanative error. Apparently the `String` instance I made, `"a dog"`, doesn't respond to `new`. It sounds like we need `Dog` to be some kind of object that responds to `new`.

What objects respond to `new`? Classes! It turns out that Ruby has a class called `Class`. It's the god of classes! Instances of the `Class` class are, well, classes. We can send `new` to it, and get a new class in response:

```eval-ruby
Dog = Class.new

fido = Dog.new
fido.bark
```

We've just defined a new class, `Dog`. However, we haven't added any methods to it. Let's do that, using the technique we used before with `Object`, `Array`, and `String`:

```eval-ruby
Dog = Class.new

class Dog
  def bark
    return "Woof"
  end
end

fido = Dog.new
fido.bark
```

And that's how we define new kinds of object, and new methods on those objects.

We've seen so far that the `class` keyword is shorthand for "open up this class, and do things with it". It's actually a bit cleverer than this. If the class given to `class` doesn't exist, it will be made on-the-fly. That means we can tighten the example above down to:

```eval-ruby
class Dog
  def bark
    return "Woof"
  end
end

fido = Dog.new
fido.bark
```

This is a more common way to define new kinds of object (and methods on them) in Ruby.

- _**Add another method to the `Dog` class.**_

## Object properties

Remember how `1` knows about its value (1)? And how instances of `String` know about some text? These things are both examples of **object state**. In fact, a string's internal characters are referred to as **properties** of the string.

Let's upgrade our Dog class. We'd love to be able to do something like this:

```ruby
fido = Dog.new

fido.colour = "brown"

fido.observe
# returns "You see a brown dog."
```

Moreover, we'd love to be able to do something like this:

```ruby
fido = Dog.new
chelsea = Dog.new

fido.colour = "brown"
chelsea.colour = "white"

fido.observe
# returns "You see a brown dog."

chelsea.observe
# returns "You see a white dog."

fido.observe
# returns "You see a brown dog."
```

That is: we want instances of the `Dog` class – dog objects – to:

- Respond to a method `colour =` by setting a property on themselves
- Respond to a method `observe` with a string
- Vary that string according to the colour property
- Remember what colour they are, so they always return 'their' string

We already know how to define new methods on `Dog`, so let's allow our errors to guide us:

```eval-ruby
class Dog
  def bark
    return "Woof!"
  end
end

fido = Dog.new
fido.colour = "brown"
fido.observe
```

We get a useful error: `colour=: undefined method 'colour=' for #<Dog:0x1b210>`. (Your memory address, '0x1b210' bit, will probably differ from mine.)

> In [Chapter 5](../chapter5/README.md), we found out that the `0x1b210` (or whatever number you have) is a _hexadecimal number_ referencing the memory address of the dog instance.

We can fix this by simply doing as we're told: defining a method `colour=` on dog instances:

```eval-ruby
class Dog
  def bark
    return "Woof!"
  end

  def colour=
  end
end

fido = Dog.new
fido.colour = "brown"
fido.observe
```

Now we have a new error: `undefined method 'observe' for #<Dog:0x1b210>`. We can fix this in the same way:


```eval-ruby
class Dog
  def bark
    return "Woof!"
  end

  def colour=
  end

  def observe
  end
end

fido = Dog.new
fido.colour = "brown"
fido.observe
```

> Notice that we're not doing anything with the methods, yet. We're just defining them to get rid of the errors.

OK! Now we don't see any more errors. But – at the moment, `observe` just returns `nil`.

> Remember, empty method procedures just return `nil` in Ruby.

Let's fix that with the string we want:

```eval-ruby
class Dog
  def bark
    return "Woof!"
  end

  def colour=
  end

  def observe
    return "You see a brown dog."
  end
end

fido = Dog.new
fido.colour = "brown"
fido.observe
```

Awesome! Does this work for `chelsea`, the white dog, too?

```eval-ruby
class Dog
  def bark
    return "Woof!"
  end

  def colour=
  end

  def observe
    return "You see a brown dog."
  end
end

chelsea = Dog.new
chelsea.colour = "white"
chelsea.observe
```

Ah, the program still suggests that Chelsea is a brown dog. We need to make the program vary according to the colour we provide: we need some way for the `Dog` instance to remember the colour we give it.

Here's how Ruby objects can be told to remember values:

```eval-ruby
class Dog
  def bark
    return "Woof!"
  end

  def colour=(colour)
    @colour = colour
  end

  def observe
    return "You see a " + @colour + " dog."
  end
end

chelsea = Dog.new
chelsea.colour = "white"
chelsea.observe
```

The above code will work for both Fido and Chelsea. That's because we're saving the colour property, passed as an argument to the `colour=` method, to the object state. To save things to the object state, we use an **instance variable**.

Let's look more closely at what the `colour=` method is doing:

```eval-ruby
def colour=(colour)
  @colour = colour
end
```

- In line 1, we define a new method `colour=`. It takes one argument, which we name `colour`.
- In line 2, we set up a new name, `@colour`, and assign it to the `colour` parameter of the `colour=` method.
- In line 3, we close the `colour=` method.

Let's give another example of this.

```eval-ruby
class Person
  def give_a_name(name)
    @my_name = name
  end

  def introduce
    return "Hello, I'm " + @my_name
  end
end

woman = Person.new
woman.give_a_name("Yasmin")
woman.introduce
```

In the example above, we:

- define a `Person` class with some methods.
- assign a new instance of `Person` to the variable `woman`.
- Set the property `@my_name` on the `Person` instance referenced by `woman` to a new string, `"Yasmin"`.
- Call the `introduce` method on the `Person` instance referenced by `woman`, which returns a string, `"Hello, I'm Yasmin"`.

> Look closer at the method `give_me_a_name`. We can call the parameter `name` whatever we want, so long as we reference that same parameter in the method procedure.

The following code will do exactly the same thing: but I've changed some of the variable and method names around to make a point:

```eval-ruby
class Person
  def call_me(nickname)
    @name_i_would_like_to_be_known_by = nickname
  end

  def introduce
    return "Hello, I'm " + @name_i_would_like_to_be_known_by
  end
end

woman = Person.new
woman.call_me("Yasmin")
woman.introduce
```

Since we're free to name variables and methods as we wish, the most sensible implementation of `Person` would use nice, terse names:

```eval-ruby
class Person
  def name=(name)
    @name = name
  end

  def introduce
    return "Hello, I'm " + @name
  end
end

woman = Person.new
woman.name=("Yasmin")
woman.introduce
```

> Using Ruby's syntactic sugar, we can replace the penultimate line with `woman.name = "Yasmin"`.

Methods that set object state – like `name=` above – are called **setters**. We've seen that setter methods can be called anything you like (`call_me` is a setter, `give_me_a_name` is a setter, and `name=` is a setter): the important thing is that they _set object state using an instance variable_.

## Mutating object state

We can change object state, too. Let's build the following program:

```ruby
robot = Robot.new
robot.legs = 4

robot.add_leg
robot.add_leg

robot.walk
# returns "I'm walking on my 6 legs!"
```

We already know how to build out the first (`legs=`) and the last (`walk`) parts:

```eval-ruby
class Robot
  def legs=(number_of_legs)
    @number_of_legs = number_of_legs
  end

  def walk
    return "I'm walking on my " + @number_of_legs.to_s + " legs!"
  end
end

robot = Robot.new
robot.legs = 4
robot.walk
```

How does `add_leg` work, though? We're changing a the `@legs` property of the `Robot` instance. 

Remember `+=`?

```eval-ruby
class Robot
  def legs=(number_of_legs)
    @number_of_legs = number_of_legs
  end

  def add_leg
    @number_of_legs += 1
  end

  def walk
    return "I'm walking on my " + @number_of_legs + " legs!"
  end
end

robot = Robot.new
robot.legs = 4

robot.add_leg
robot.add_leg

robot.walk
```

## Using `initialize` to set up instances

Imagine if `String` instances worked like this:

```ruby
my_string = String.new
string.text = "Some text"
```

How annoying that would be! And yet, thanks to our obsession with setter methods above, that's exactly what we're doing with our `Dog`, `Person`, and `Robot` classes. Wouldn't it be better to write:

```ruby
woman = Person.new("Yasmin")
```

Just like we write `my_string = String.new("Some text")`?

We can! Thanks to Ruby **initializers**.

In Ruby, whenever we call `new` on a class, that class builds an object and then runs the method `initialize` on it:

<diagram of the `new` and `initialize` process>

If we want to store information about an object as part of that object's state – as a property on the object – we need to interfere with this `initialize` method.

> Ruby automatically defines the `initialize` method, even if you don't write it. That's why `new` still worked for our `Dog`, `Person`, and `Robot` classes before.

```eval-ruby
class Dog
  def initialize
    puts "I'm initializing a dog!"
  end
end

fido = Dog.new
```

Every argument to the `new` function is passed to the `initialize` function. Therefore, if we want to send the string `"brown"` or `"white"` to be stored on a dog as soon as we call `new`, we need to set an instance variable in the initializer.

```eval-ruby
class Dog
  def initialize(colour)
    @colour = colour
  end

  def observe
    "You see a " + @colour + " dog."
  end
end

fido = Dog.new("brown")
fido.observe
```

No setter method needed! Let's do that again, with our `Person` class:

```eval-ruby
class Person
  def initialize(name)
    @name = name
  end

  def introduce
    return "Hello, I'm " + @name
  end
end

woman = Person.new("Yasmin")
woman.introduce
```

And once more, with our `Robot` class:


```eval-ruby
class Robot
  def initialize(number_of_legs)
    @number_of_legs = number_of_legs
  end

  def add_leg
    @number_of_legs += 1
  end

  def walk
    return "I'm walking on my " + @number_of_legs + " legs!"
  end
end

robot = Robot.new(4)

robot.add_leg
robot.add_leg

robot.walk
```

By using multiple parameters with `initialize`, we can provide multiple pieces of information to an object at once:

```eval-ruby
class Person
  def initialize(name, age)
    @name = name
    @age = age
  end

  def introduce
    "Hello, I'm " + @name + ", and I'm " + @age.to_s + " years old."
  end

  def get_older
    @age += 1
  end
end

peter = Person.new("Peter", 17)
peter.get_older

peter.introduce
```

## Different kinds of variables

All variables are references to objects in Ruby – because everything is an object: from `1`, to `"Hello world"`, to the `Dog` class.

So far, we've met a few different kinds of variables:

- Regular variables, like `my_string = "Hello World`
- Constants, like `ONE = 1`
- Variables inside methods, which get their names from parameters, like `scores` in our `average` method
- Instance variables, like `@name`, `@colour` and `@legs`.

What's the difference between these kinds of variables? They answer is, broadly speaking, _which objects can see them_.

#### What can see an instance variable?

**Instance variables** are the simplest: they can only be seen by the object that they're 'inside':

```eval-ruby
class Dog
  def initialize(colour)
    @colour = colour
  end

  # We can use @colour in any methods defined on Dog instances
  # Such as this one
  def observe
    "You see a " + @colour + " dog."
  end
end

# We can't see @colour from outside instances of the Dog class
# Here, we're trying to access @colour from the main object
# It can't see the instance variable @colour
@colour
```

> If you try to reference an _instance_ variable that an object can't see, you'll get `nil`.

#### What can see a local variable?

**Regular variables** are normally referred to as **local variables**. Here, we're in imperative-land: telling the computer what to do, line-by-line.

If a line defining that local variable _has already been executed_, that local variable is available to anything that wants it.

```eval-ruby
# Define a local variable in the main program object
my_variable = 1

# We can access the local variable here, because the line above was executed before this one
my_variable
```

<animation showing local variables>

This is the case even if the local variable was defined in a conditional branch that got executed:

```eval-ruby
if true
  # This conditional branch will be executed
  my_variable = 1
end

my_variable
```

One gotcha – strange things happen if you define variables in branches that _don't_ get executed:

```eval-ruby
if false
  my_variable = 1
end

my_variable
```

The program can still read the name: but the value is set to `nil`.

There's one really tricky thing about local variables, and it has to do with methods. Here it is:

```eval-ruby
def my_method
  my_variable = 1
end

my_variable
```

Why can't the main object see the `my_variable` variable, even though it was defined in the lines above? The answer that most makes sense: `my_method` didn't get executed yet. We only declared it, but we didn't call the method.

So we can solve it like this, right?

```eval-ruby
# define the method
def my_method
  my_variable = 1
end

# run the method, executing the procedure that defines my_variable
my_method

my_variable
```

Wrong. For some reason – even though the procedure `my_variable = 1` (inside the method `my_method`) has been executed – the main object still can't see `my_variable`. Why is this?

## Scope

Every time we write one of the following:

- `def`
- `class`

We 'open' something.

- `def` opens a method, so we can define a procedure inside.
- `class` opens a new class, so we can define methods inside.

The keyword `end` then 'closes' that something you just opened.

```eval-ruby
def average
  # we opened the average method, so we can define procedures in it
end

class Dog
  # we opened the Dog class, so we can define methods in it
end
```

Variables that we define inside these things cannot be seen outside of them:

```eval-ruby
def average
  accumulator = 0
end

class Dog
  some_variable = 1
end

puts accumulator
puts some_variable
```

The area of a program in which a variable can be read is called the variable **scope**. `def` and `class` are known as **scope gates**: when the program runs this instruction, it enters a new scope. Variables defined inside this scope cannot be read outside of the scope gate. Variables defined outside of the scope gate cannot be read inside it.

```eval-ruby
my_variable = 1

def my_method
  # I'm in a new scope gate! I can't read my_variables
  my_variable + my_variable
end

my_method
```

Here's a visual representation of scope:

<diagram of code with highlighted scope and out of scope>

> Confused by the word 'scope'? Think of the scope on top of a sniper-rifle: when you look down it, you can only see a part of the world: the part of the world you can shoot.

## Scope and parameters

Scope is especially helpful when it comes to understanding method parameters. For each parameter, methods will define a local variable within their scope. The name of that variable will be set to the name of the parameter:

```eval-ruby
age = 22

def age_reporter(number)
  # Whatever we pass as an argument to age_reporter will be assigned to a local variable named 'number'
  return "Your age is " + number.to_s
end

age_reporter(age)
```

Since `def` is a scope gate, we can't read these local variables outside of them:

```eval-ruby
name = "Sam"

def say_hi_to(person)
  return "Hi, " + person
end

# We can't read this
person
```