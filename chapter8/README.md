# Hashes

We've just met a very powerful object for storing information in the program world: instances of the `Array` class.

Arrays are great for storing objects, but they get harder to understand the more objects they contain. For example: what does each element in the following array _mean_?

```ruby
important_program_information = [0, "Hello", ["Sam", 1.17]]
```

Moreover, reading elements from arrays using `[]` gets harder to understand as the array grows in complexity:

```ruby
teams_with_substitutes = [[["Jim", "Yasmin", "Audrey"], ["Alex", "Mustafa"]], [["Pyotr", "Canace"], ["Xi"]]]

team_1_substitutes = teams_with_substitutes[0][0][1]
team_2_players = teams_with_substitutes[1][0][0]
```

...and it's a pain to read. Remember how important _naming_ is for helping other programmers understand your program: what does `[0][0][1]` mean? How is it different from `[1][0][0]`?

Is there a solution? Sure there is: the `Hash` class, and its instances: hashes.

## From arrays to hashes

Arrays and hashes are similar in that they both contain lists of _elements_. The main difference is that:

* Array elements are objects
* Hash elements are two objects, one used to reference the other.

> This 'two objects, one used to reference the other' might seem confusing. But there are similarities with how variables are used to reference objects. Although a variable isn't strictly an object, it's a similar concept.

Remember how variables are _names_ for _objects_? In programming, we sometimes refer to these names as **keys** and the objects they reference as **values**. Together, they make a 'key-value pair'.

Arrays use _indices_ as their keys. That is, the first element of an array has an index of `0`. The second has an index of `1`. Given an array, you can ask it for the value with key `0` in the following way:

```eval-ruby
# Given an array
array = [1, 2, 3]

# Read value with key 0
array[0]
```

And you can tell the array to set the value at key `0` in the following way:

```eval-ruby
# Given an array
array = [1, 2, 3]

# Set the value with key 0
array[0] = 999

# Return the array
array
```

So, for arrays – you can only use integers as keys. `0`, `1`, `2`, and `550` are all valid array keys.

Hashes can use _any object as a key_:

```eval-ruby
hash = { String.new("first item") => 1, 44.2 => 2, Object.new => 3 }
```

Commonly, we'll use strings:

```eval-ruby
favourite_things = { "sport" => "tennis", "food" => "chunky bacon" }
```

This is because, like arrays, we often want to read the data. String keys provide us with an easy, clearly-named way to read this data:

```eval-ruby
favourite_things = { "sport" => "tennis", "food" => "chunky bacon" }

favourite_things["sport"]
```

If this is confusing, let's make a 'pretend array' with a hash, and read the `0`th item from it:

```eval-ruby
hash_pretending_to_be_an_array = { 0 => "tennis", 1 => "sport" }

hash_pretending_to_be_an_array[0]
```

Now let's set the `0`th item, just like we would an array:

```eval-ruby
hash_pretending_to_be_an_array = { 0 => "tennis", 1 => "sport" }

hash_pretending_to_be_an_array[0] = "football"

# See that the hash (pretending to be an array) has changed
hash_pretending_to_be_an_array
```

Even more commonly than strings, we'll use **symbols**. Symbols are a special, and very widespread object in Ruby. They work like strings, except they're _immutable_ – they can't be changed once they've been set.

Since we rarely want to change the keys in a hash, symbols are a perfect choice:

```eval-ruby
favourite_things = { :"sport" => "tennis", :"food" => "chunky bacon" }

favourite_things[:"sport"]
```

> To write a symbol, add a semicolon `:` before a name. There's syntactic sugar, too: you don't need the quotes \(`""` around the symbol\). Also, you can ask a string to fetch its equivalent symbol very easily: simply send the string the message `to_sym` \(like how `to_f` worked for integers and floats\). Using symbols makes your code look super-programmery, and tells other programmers which objects they should expect to change, and which should stay the same.

So, this is the first function of hashes: as a **key-value store** for named information.

> This kind of key-value store in programming is sometimes called a **dictionary**. Sometimes, it's called a **lookup table** – because you can use dictionaries to look things up.

## Using hashes to control the flow of information

One major value of a hash is that it can be used to refactor a conditional: especially if that conditional is getting too long. Here's an example procedure. The object running this procedure berates you if you curse at it:

```eval-ruby
curse = "dang"

if curse == "damn"
  return "That's a curse word! How dare you"
elsif curse == "dang"
  return "That's a less bad curse word! Still, how dare you"
elsif curse == "darn"
  return "Hmm, I'm mildly offended but I'll survive. Watch your language!"
elsif curse == "durn"
  return "Ahh, that's good Southern swearing, that is!"
end
```

We can refactor the above example to use a hash:

```eval-ruby
curse = "dang"

# First, set up the options
beratings = {
  "damn" => "That's a curse word! How dare you",
  "dang" => "That's a less bad curse word! Still, how dare you",
  "darn" => "Hmm, I'm mildly offended but I'll survive. Watch your language!",
  "durn" => "Ahh, that's good Southern swearing, that is!"
}

# Second, do a lookup on the beratings hash
beratings[curse]
```

This is a pretty powerful technique!

* _**Using the technique above, implement a program to the following specification without using a conditional.**_

> I want a simple dictionary. I put in the word, and I get out the definition of that word. Here are the definitions I want:
>
> * **bear**: a creature that fishes in the river for salmon.
> * **river**: a body of water that contains salmon, and sometimes bears.
> * **salmon**: a fish, sometimes in a river, sometimes in a bear, and sometimes in both.
>
> In general, programmers try to minimise the amount of conditionals in a program. This is because such pathways can quickly multiply in number \(especially if a lot of programmers are working on the codebase\). Each pathway can lead to a new program state, which results in more program states than any one programmer can reason about. [This article](https://www.theatlantic.com/technology/archive/2017/09/saving-the-world-from-code/540393/) is a fantastic recent case study into what happens when programmers can no longer reason about the complexity of their codebases. Lookup tables are one way to reduce conditional complexity in a program, by centralising possible program states. In [Chapter 9](../chapter9/README.md), we'll see that we can use procedures as values to lookup tables, which allows us to control program state even more tightly.

## Grouping things in hashes

One other useful application of hashes is _grouping_. Grouping makes use of the fact that we can _set the value of a hash key to an array_:

```eval-ruby
my_hash = { :my_array => ["an", "array", "containing", "elements"] }
```

We can use all our regular array methods to read elements, add elements, remove elements, and so on, from an array inside a hash:

```eval-ruby
my_hash = { :my_array => ["an", "array", "containing", "elements"] }

my_hash[:my_array].delete_at(0)
my_hash[:my_array].push("like").push("this")

my_hash
```

* _**Group the array of hashes below into a hash, where each key of the hash is a sport, and each value of the hash is a list of names of people who play that sport.**_

```eval-ruby
players = [
  { :name => "Sam", :sport => "tennis" },
  { :name => "Mary", :sport => "squash" },
  { :name => "Ed", :sport => "tennis" },
  { :name => "Mark", :sport => "football" }
]
```

%accordion%See how I'd do it%accordion%

This is a very tricky program to pull off. It's actually one of the things I find hardest in all programming, because it feels like I have to keep track of so much at once: what keys mean what, which values are where, and so on.

So no worries if you find this tough! I do too, and we're in good company. We can make life easier for ourselves by moving in small steps.

Let's decompose the specification into requirements.

1. Set up a new hash \(`sorted_by_sport` will do as a name for now\).
2. Go through the players.
3. For each player \(`player_under_consideration` will do as a name for now\), take a note of the sport they play \(`sport` will do as a name for now\).
4. Check the `sorted_by_sport` hash. If `sport` does not exist as a **key** on that hash, set `sport` equal to an array containing the name of `player_under_consideration`. Then move to the next player.
5. Else, if `sport` DOES exist as a key on the hash, push the `player_under_consideration`'s' name into the array that already exists. Then go to the next player.

> When making these requirements, I actually went back-and-forth a bunch. The first set I tried didn't work, so I had to come back. Then the second set worked up to 3, but broke at 4. I ended up with this set of 'perfect requirements' third time round. So I didn't just 'come up with this' on the spot! Programmers rarely crank out known code: 'back and forth', deleting code, zooming in and out is all normal.

OK, this should get us started. Step-by-step.

#### 1. Set up a new hash

1. Set up a new hash \(`sorted_by_sport` will do as a name for now\).

```eval-ruby
players = [
  { :name => "Sam", :sport => "tennis" },
  { :name => "Mary", :sport => "squash" },
  { :name => "Ed", :sport => "tennis" },
  { :name => "Mark", :sport => "football" }
]

sorted_by_sport = {}
```

#### 2. Set up a loop on the players

1. Go through the players.

```eval-ruby
players = [
  { :name => "Sam", :sport => "tennis" },
  { :name => "Mary", :sport => "squash" },
  { :name => "Ed", :sport => "tennis" },
  { :name => "Mark", :sport => "football" }
]

sorted_by_sport = {}

players.each do |player_under_consideration|
end

# Let's return the sorted_by_sport hash so we can see it in the REPL too
sorted_by_sport
```

#### 3. Name the sport each player plays, using a variable

1. For each player \(`player_under_consideration` will do as a name for now\), take a note of the sport they play \(`sport` will do as a name for now\).

```eval-ruby
players = [
  { :name => "Sam", :sport => "tennis" },
  { :name => "Mary", :sport => "squash" },
  { :name => "Ed", :sport => "tennis" },
  { :name => "Mark", :sport => "football" }
]

sorted_by_sport = {}

players.each do |player_under_consideration|
  sport = player_under_consideration[:sport]
end

sorted_by_sport
```

#### 4. Set the key on `sorted_by_sport` if there isn't one already

1. Check the `sorted_by_sport` hash. If `sport` does not exist as a **key** on that hash, set `sport` equal to an array containing the name of `player_under_consideration`. Then move to the next player.

```eval-ruby
players = [
  { :name => "Sam", :sport => "tennis" },
  { :name => "Mary", :sport => "squash" },
  { :name => "Ed", :sport => "tennis" },
  { :name => "Mark", :sport => "football" }
]

sorted_by_sport = {}

players.each do |player_under_consideration|
  sport = player_under_consideration[:sport]
  # I think I'll also give a variable for the name, since we did with the sport
  name = player_under_consideration[:name]

  if sorted_by_sport[sport] == nil
    sorted_by_sport[sport] = [name]
  end
end

sorted_by_sport
```

#### 5. Push the player name into the key on `sorted_by_sport` if the key already exists

1. Else, if `sport` DOES exist as a key on the hash, push the `player_under_consideration`'s' name into the array that already exists. Then go to the next player.

```eval-ruby
players = [
  { :name => "Sam", :sport => "tennis" },
  { :name => "Mary", :sport => "squash" },
  { :name => "Ed", :sport => "tennis" },
  { :name => "Mark", :sport => "football" }
]

sorted_by_sport = {}

players.each do |player_under_consideration|
  sport = player_under_consideration[:sport]
  name = player_under_consideration[:name]

  if sorted_by_sport[sport] == nil
    sorted_by_sport[sport] = [name]
  else
    sorted_by_sport[sport].push(name)
  end
end

sorted_by_sport
```

#### 6. Refactor

I'm going to tidy up these names first, to make them a bit terser without losing clarity:

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
  name  = player[:name]

  if players_by_sport[sport] == nil
    players_by_sport[sport] = [name]
  else
    players_by_sport[sport].push(name)
  end
end

players_by_sport
```

I can get rid of an `else` here, reducing the conditional complexity:

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
  name  = player[:name]

  if players_by_sport[sport] == nil
    players_by_sport[sport] = []
  end

  players_by_sport[sport].push(name)
end

players_by_sport
```

Since I'm only using `name` once, it doesn't feel that helpful to keep it around:

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

This feels much more readable!

%/accordion%

## Iterating over hashes

When we iterate over a hash, we get both the key and value as parameters to a procedure \(since the elements of a hash are key-value pairs\):

```eval-ruby
my_favourite_things = { :sport => "tennis", :music => "classical" }

my_favourite_things.each do |key, value|
  # Do something with key and value
end
```

> Remember – just like array `each`es, you can name the parameters whatever you like. Just like the `each` parameter for an array represented each element – no matter what you called it – the first parameter for a hash `each` will be the element key, and the second will be the element value.

## Complete the mastery quiz for chapter 8

Use your mastery quizzes repository to complete the quiz for chapter 8.

