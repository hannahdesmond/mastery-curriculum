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