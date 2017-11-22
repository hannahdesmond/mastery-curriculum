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

In programming, defining methods or variables on the main program object is called defining at **global scope**. Global, because it surrounds the entire program (sometimes it's called the '_universal_ scope'). But 'scope'?

## Scope

In Ruby, **scope** is: 'whatever an object has access to'. Think of a sniper-rifle scope: when you look down it, you can only see a part of the world: the part of the world you can shoot.

In general, we want to _minimise the scope_ of objects. We don't want them to have access to more of the program than they should. When we do something like this:

```eval-ruby
named_object = Object.new
```

Everything in the program can now access and use the name `named_object`: so everything in the program can now access and use the object it references. This can make for a super-confusing message flow, as every part of the program tries to access names declared somewhere else. Grow beyond a few dozen lines of code, and it's going to get horrible.

This chapter

* Creating your own object worlds