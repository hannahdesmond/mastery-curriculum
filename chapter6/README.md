# Advanced Control Flow

We now have access to the following tools:

* Naming
* Statements
* Messages and Methods
* Conditionals
* While loops
* Strings
* `gets` and `puts`

These are all the things required to write a more complex interactive procedural program!

## Using string input conditionally

Let's say we want to have the following program:

- The user sees a greeting, which asks them to enter their name.
- The user enters their name.
- If the user's name begins with 'S', the program shouts the user's name back at them.
- If the user's name begins with any other letter, the program just says 'Hi, ' plus their name.

- _**You have all the parts required to build this program. Go build it!**_
- _**Once you've had a go, read the hidden section below for a step-by-step approach, as well as some tips on better code.**_

%accordion%Here's how I'd do it%accordion%

When building a program, we move step-by-step through the requirements.

> Biting off too many requirements at once is the #1 mistake in programming. The best programmers do everything they can to avoid it. That's why the idea of the 'best programmer is a lazy programmer' took hold. Force yourself to move in small steps now! It's a habit that will pay off.

#### 1. Make the file

First up, I'll make a file: `greetings.rb`, and open it in a text editor (like Sublime Text).

#### 2. `puts` the greeting

- The user sees a greeting, which asks them to enter their name.

This one will require `puts`. Inside my `greetings.rb` file, I'll add:

```ruby
puts String.new("Welcome user")
```

#### 3. Get the user's name

This one will require `gets`, and the string method `chomp`. Also, I'll need a variable to store the user's name:

```ruby
puts String.new("Welcome user")
user = gets.chomp
```

#### 4. Do the simplest thing first (print 'Hi ' plus the name)

Even though the next requirement is to 'shout the user name if it begins with an S', I'm going to make the simplest thing first. That's generally a good strategy, as it avoids getting snarled up early on:

```ruby
puts String.new("Welcome user")
user = gets.chomp

puts String.new("Hi, ") + user
```

#### 5. Do the hard thing next (work out the conditional)

Conditionals are tricky, so I've saved it for nearly-last:

```ruby
puts String.new("Welcome user")
user = gets.chomp

if user.chr == String.new("S")
  puts user
else
  puts String.new("Hi, ") + user
end
```

#### 6. Make sure you meet the requirements

Everything's in place with the conditional, except I'm currently printing the `user` without upcasing it. So, let's fix that:

```ruby
puts String.new("Welcome user")
user = gets.chomp

if user.chr == String.new("S")
  puts user.upcase
else
  puts String.new("Hi, ") + user
end
```

#### 7. Refactor

The last thing I'll do is _refactor_: tidy up my code so it's as good as it can be. 

> Your code will be judged according to how readable and consistent it is. Refactoring is a huge field that we'll focus on a lot during the course. It's worth building the basics in here.

I'm going to use several pieces of syntactic sugar to tidy up my code, so it's more readable. The first is to use Ruby's shorthand for creating strings: `"hello"` is syntactic sugar for `String.new("hello")`.

```ruby
puts "Welcome user"
user = gets.chomp

if user.chr == "S"
  puts user.upcase
else
  puts "Hi, " + user
end
```

The second refactor I'm going to make is to use **early returns** along with one-line conditionals. Remember that `return` will break a procedure and return whatever value you pass to it. Using this knowledge, along with some syntactic sugar, we can do this:

```ruby
puts "Welcome user"
user = gets.chomp

return puts user.upcase if user.chr == "S"
return puts "Hi, " + user
```

> Confused by these `return`s along with `if`s? Weirded out by how the `else` disappeared? Draw out the flow diagram for these two examples, and you'll see it's just the same thing. I prefer it written like this, but others prefer `if`/`else` syntax. Either is fine!

The final refactor I'm going to make is to use Ruby's syntactic sugar of **string interpolation** to print the return value from a statement directly into a string:

```ruby
puts "Welcome user"
user = gets.chomp

return puts user.upcase if user.chr == "S"
return puts "Hi, #{user}"
```

> `#{}` inside a string will allow you to execute Ruby inside a string.

We could get this program down to three lines if we wanted to, by using a [ternary operator](https://launchschool.com/books/ruby/read/flow_control). However, I don't think that makes it much better. This code is attractive to me because each line neatly mirrors each requirement we were given. The first line is the first requirement. The second line the second, and so on.

> Good code is not as terse as possible: good code fulfils the requirements as closely as possible.

%/accordion%

## More complicated loops

Let's say we want to write a simple text-based adventure game, to the following specification:

> The user starts by facing forward. They can move right, left, or forward. If they move right, they die (there's a goblin). If they move left, they die (there's a werewolf). If they move forward, they live. They have to do this twice to win.

- _**Considering the step-by-step approach I outlined before, turn this specification into requirements (where each requirement details one feature of the game).**_

%accordion%Here's how I'd get those requirements%accordion%

We want to decompose this specification into really clear, step-by-step requirements. This is **algorithmic thinking**.

1. The user is told they're facing forward and can type 'forward', 'left', or 'right'.
2. If the user enters 'right', they die (goblin).
3. If the user enters 'left', they die (werewolf).
4. If the user enters 'forward', they're told they live, and can move again.
5. If the user enters anything other than 'right', 'left', or 'forward', they just get the message from 1 again.
6. If the user enters 'right', they die (goblin).
7. If the user enters 'left', they die (werewolf).
8. If the user enters 'forward', they're told they won and the game exits.
9. If the user enters anything other than 'right', 'left', or 'forward', they just get the message from 4 again.

This is just the right amount of detail: now I know exactly what to program, step-by-step. No way am I gonna get overwhelmed by this.

> Programming is hard. Just keep going, keep breaking it down. You can train yourself to think algorithmically: it's not a natural or intuitive way to think. Once you get better, you'll forget how tough it used to be!

%/accordion%

- _**Go build this game!**_

%accordion%Here's how I'd build it%accordion%

OK, this game sucks, but it's an interesting thing to build out. Before jumping into coding up the requirements, let's think about what we already know.

First thing: this is a game. It has repeat actions: we're going to need a `while true` loop. We have to get user input twice (once for the first move, then again for the second move).

Second thing: we need something to track what's happened across both moves (is this the first move or the second move?). Since the moves will probably happen in a `while` loop, we're probably going to need an accumulator to track the loop.

Third thing: It has a `break` condition when the user dies or wins: we're going to need `break`, probably.

So, put those things together, and we'll probably have something like this:

```ruby
move_number = 1

while true
  # do a move

  if # some sort of death or win condition
    break
  end
end
```

OK, that's the high-level thinking done. Now, let's build out the first requirement!

#### 1. Make the file

First, I'll make the game file. I'll call it `game.rb`, and open it in a text editor.

#### 2. `puts` the greeting

My first requirement (yours might be different) was:

1. The user is told they're facing forward and can type 'forward', 'left', or 'right'.

This we can do with a `puts`:

```ruby
puts "You're facing forward. You can type forward, left, or right."
```

#### 3. Get the user's input

I'm not going to write a loop yet: they're complicated, and I like to save up the complicated stuff til last. Let's just get the user input. This we can do with a `gets` and a `chomp`:

```ruby
puts "You're facing forward. You can type forward, left, or right."

user_input = gets.chomp
```

#### 4. Kill the user with a goblin if they said 'right'

2. If the user enters 'right', they die (goblin).

The specification didn't say what should happen when a user dies (and we can't ask the client what they meant right now), so I'm figuring we just print something, then let the program exit (lazy programmer, right?).

```ruby
puts "You're facing forward. You can type forward, left, or right."

user_input = gets.chomp

if user_input == "right"
  puts "You were killed by a goblin!"
end
```

#### 5. Kill the user with a werewolf if they said 'left'

3. If the user enters 'left', they die (werewolf).

This is a matter of adding an `elsif` to the conditional from before:

```ruby
puts "You're facing forward. You can type forward, left, or right."

user_input = gets.chomp

if user_input == "right"
  puts "You were killed by a goblin!"
elsif user_input == "left"
  puts "You were killed by a werewolf!"
end
```

> Note that I still haven't gotten to a `while` loop yet. I don't need it for these requirements! Maybe I will later.

#### 6. Give the user a 'you live!' message if they said 'forward'

4. If the user enters 'forward', they're told they live, and can move again.

OK, I _could_ use a `while` loop here, but it's a pretty complicated thing to do. I'd prefer to just duplicate my code for now, and only use a loop if I really need one. Besides, if I use a `while` loop right now I'll have to add `break`s to all my conditionals. That sounds like a pain. Let's just do the simplest, laziest thing, and add another `elsif`.

> I've got a pattern going here, and that feels good. So I'm going to keep using that pattern.

```ruby
puts "You're facing forward. You can type forward, left, or right."

user_input = gets.chomp

if user_input == "right"
  puts "You were killed by a goblin!"
elsif user_input == "left"
  puts "You were killed by a werewolf!"
elsif user_input == "forward"
  puts "You live! Go again. You can type forward, left, or right."
end
```

#### 7. Handle users typing the wrong thing

5. If the user enters anything other than 'right', 'left', or 'forward', they just get the message from 1 again.

I can catch all other inputs other than 'right', 'left', or 'forward', by adding an `else` to my conditional:

```ruby
puts "You're facing forward. You can type forward, left, or right."

user_input = gets.chomp

if user_input == "right"
  puts "You were killed by a goblin!"
elsif user_input == "left"
  puts "You were killed by a werewolf!"
elsif user_input == "forward"
  puts "You're facing forward. You can type forward, left, or right."
else
  puts "You're facing forward. You can type forward, left, or right."
end
```

#### 8. Repeating

6. If the user enters 'right', they die (goblin).
7. If the user enters 'left', they die (werewolf).

We've seen these instructions before. OK! Now I could use a `while` loop. Of course, this is just going to run forever – but it solves all the requirements so far.

I'll have to add `break` statements where being killed should exit the program. I'll also remove the `puts`ing when the user gave either a 'forward' command, or some other command (maybe they typed 'chicken').

```ruby
while true
  puts "You're facing forward. You can type forward, left, or right."

  user_input = gets.chomp

  if user_input == "right"
    puts "You were killed by a goblin!"
    break
  elsif user_input == "left"
    puts "You were killed by a werewolf!"
    break
  elsif user_input == "forward"
    # Nothing happens here, we just start the loop again.
  else
    # Same here. Maybe they entered 'chicken' or something.
  end
end
```

#### 9. Going forward again

8. If the user enters 'forward', they're told they won and the game exits.

At the moment, our game has _loss conditions_ – going right or left – which will exit the game. However, there isn't a win condition – both typing `forward` and typing some other command, like `chicken`, will result in the same thing happening: the loop restarts, and the user sees "You're facing forward. You can type forward, left, or right".

There's no _win condition_ that will exit the game. I can't just add a `break` statement after the line `elsif user_input == "forward"`, because then the user won't get to take two turns (like the client asked).

I need something to track the turns: an accumulator. Then, I can exit depending on the value of the accumulator.

```ruby
# Here's my accumulator
move_number = 1

while true
  puts "You're facing forward. You can type forward, left, or right."

  user_input = gets.chomp

  if user_input == "right"
    puts "You were killed by a goblin!"
    break
  elsif user_input == "left"
    puts "You were killed by a werewolf!"
    break
  elsif user_input == "forward"
    # if this is the second turn, let's quit!
    if move_number == 2
      puts "You win!"
      break
    end

    # increase the move number here, because we're getting closer to victory
    move_number = move_number + 1
  else
    # don't increase the move number here, because we're no closer to victory
  end
end
```

#### 10. The final requirement

9. If the user enters anything other than 'right', 'left', or 'forward', they just get the message from 4 again.

We've actually already solved this requirement: if the user doesn't type 'right', 'left', or 'forward', the move number will never increase.

#### 11. Refactor

OK, let's tidy up this code a bit. For one, this final `else` condition doesn't seem to contain any procedures any more. Let's kill it.

```ruby
move_number = 1

while true
  puts "You're facing forward. You can type forward, left, or right."

  user_input = gets.chomp

  if user_input == "right"
    puts "You were killed by a goblin!"
    break
  elsif user_input == "left"
    puts "You were killed by a werewolf!"
    break
  elsif user_input == "forward"
    if move_number == 2
      puts "You win!"
      break
    end

    move_number = move_number + 1
  end
end
```

The only refactor I'm going to do here is using some more syntactic sugar. Ruby allows you to squish together the following:

```eval-ruby
move_number = 1
move_number = move_number + 1
```

Into this:

```eval-ruby
move_number = 1
move_number += 1
```

That is to say: `a += b` is the same as writing `a = (a + b)`. It's a powerful, space-saving feature!

%/accordion