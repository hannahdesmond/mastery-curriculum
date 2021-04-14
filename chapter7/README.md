# Arrays and Iterators

So far we've met objects that can really only 'contain' one thing:

- Integers contain the value of the integer.
- Strings contain a bit of text.

We call whatever an object 'contains' that object's **state**.

What if we want an object whose state can store more than one thing? Is there an object for that?

## `Array`

The `Array` class creates instances that can store many other objects inside themselves. Like `String` instances are called 'strings', `Array` instances are called 'arrays'. 

Arrays can have objects added to them, and removed from them: they'll grow and shrink depending on how many objects they contain, like an elastic band.

> Any object which can change its state during the course of the program world's existence is referred to as being **mutable**. Strings can be chopped up, capitalized, and so on: they're mutable, too. Integers can't be changed: `1` will always represent `1`. They're **immutable**. Because other objects can change the state of an array – by adding or removing objects to or from it – arrays in Ruby are _mutable_.

Let's instruct the `Array` class to create a new instance. Then, let's use the array instance method `push` to add some strings into the array:

```eval-ruby
an_array = Array.new

an_array.push("Hello World")
an_array.push("It's me!")
an_array.push("Mario!")

an_array
```

<animation showing adding items to an array>

> Notice that I'm using Ruby's syntactic sugar to create new instances of the `String` class. Don't be fooled – under the hood, Ruby is still running `String.new("Hello World")`. It's just easier for me as a programmer to write it the shorthand way.

- _**Add a couple more strings to the array.**_
- _**Add a couple of integers and floats to the array.**_
- _**Add the main object to the array.**_

## Modifying arrays

We've seen that we can add things to an existing array object's state by using the array's `push` method, with the object-to-be-added as an argument to that method:

```eval-ruby
another_array = []
another_array.push("A short string")

another_array
```

> Things inside an array are called **elements**.

Just like Ruby offers syntactic sugar for creating strings with `""`, arrays have syntactic sugar, too: `[]` does the same thing as `Array.new`. Using this shorthand, we can set up arrays pre-filled with elements:

```eval-ruby
an_array_containing_elements = ["This", "is", "an", "array"]
```

We can remove elements from an array by sending it the message `delete_at`, with an argument denoting the 'index' of the element we want to remove. For arrays, this 'index' is a number, which denotes an element in the array. The first element is index `0`, the second is index `1`, the third is index `2`, and so on:

```eval-ruby
array = ["a", "b", "c"]

array.delete_at(1)

array
```

> Watch out! Arrays are _zero-indexed_. That means they count from zero: the first element is in position `0`. Play with the code example above until that's clear.

We can also remove just the _last element of an array_ by sending an array the `pop` message:

```eval-ruby
array = [1, 2, 3]

array.pop

array
```

All of the above will modify the array: that is, the array will change when you run `push`, `delete_at`, or `pop`.

## Reading arrays

You can read a single element from an array by sending the array the `[]` method with the index of your desired element:

```eval-ruby
array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# Let's get the first element
array[0]
```

> The `[]` method won't accept dot syntax. It's one of the only things in Ruby that won't.

- _**Access different elements of the array above using `[]`.**_

You can read a bunch of elements at once, by calling the array's `slice` method:

```eval-ruby
array = [1, 2, 3, 4, 5, 6]

array.slice(0, 1)
```

> This is the first method we've met that takes two arguments. `slice`'s first argument is the starting index, and the last argument is length of the slice. Play around to figure it out.

## Outputting from arrays

Arrays can be useful for storing elements you might want to keep separate sometimes and join together at others. A common use case for an array is to store strings, then to send the array of strings a `join` message, which will concatenate them:

```eval-ruby
sentence = ["Hello,", "you", "are", "NOT", "welcome", "here"]

sentence.join(" ")
```

> The argument you provide to `join` is the joining character. Here, we used a space (`" "`). What happens if we use a different character?

- _**Add a line of code that removes the `"NOT"` string from the array, making the sentence friendlier.**_

%accordion%See how I'd do it%accordion%

```eval-ruby
sentence = ["Hello,", "you", "are", "NOT", "welcome", "here"]

sentence.delete_at(3)

sentence.join(" ")
```

> Why can't I chain the methods together to make `sentence.delete_at(3).join(" ")`?

%/accordion%

## Making arrays from strings

Remember that strings are objects which:

* Know about some text we give it, and 
* Know how to interact with other instances of the `String` class.

In [Chapter 5](../chapter5/README.md), we learned that strings store text:

```eval-ruby
string = String.new("Some text")
```

> In [Chapter 6](../chapter6/README.md), we saw that we can use Ruby's syntactic sugar to create new strings using `string = "Some text"`. Under-the-hood, this calls `String.new("Some text")`.

What might surprise you is that strings actually store lists of characters – similarly to how arrays store lists of elements. We can call some – but not all – array methods on strings:

```eval-ruby
greeting = "Hello World!"

greeting[0]
```

We just used the sent the array reader method `[]` to `greeting` to pull the first character from a string (remember, lists are zero-indexed in Ruby).

> This is possible because `String` instances define a method `[]` on their interface.

We might want to tell a string to create a new array using its text. Strings define a method called `split` to do this:

```eval-ruby
string = "Hello World!"

string.split
```

Sending `split` to a string will cause the string to invoke some procedure that returns a new array of strings. Strings will use their text to build the new array. By default, they'll use a space – `" "` – as the split point. We call this split point a _delimiter_.

We can provide a different delimiter to `split` to ask the string to build a different array:

```eval-ruby
string = "Hello World!"

string.split("l")
```

> Where did the 'l's go in the example above? Think about this: in the first `split` example, where did the `" "` spaces go?

If we provide an empty string (with no characters or spaces in it), the string will build an array with each element representing one character of that string's text:

```eval-ruby
string = "Hello World!"

string.split("")
```

We've already seen that we can send the `join` method to arrays. The array will return a concatenation of its elements. Therefore, combining `split` and `join` gives us some power to manipulate strings:

```eval-ruby
bad_string = "Why|am|I|so|hard|to|read"

bad_string.split("|").join(" ")
```

## Arrays of arrays

Arrays can contain any kind of object (although it's rare that they contain more than one kind at once):

```eval-ruby
array_of_strings = ["An", "array", "of", "strings!"]
array_of_integers = [1, 4, 8]
array_of_floats = [1.2, 1.4, 2.2]
array_of_objects = [Object.new, Object.new, Object.new]

mixed_array = ["An", 4, 2.2, Object.new]
```

Although it might seem a bit confusing, arrays can therefore contain other arrays:

```eval-ruby
array_of_arrays = [["An", "array", "of", "strings"], ["another", "array", "of", "strings"]]
```

Because this can get confusing to read, these 'arrays of arrays' are often written across multiple lines. The following is the same as the above, just easier to read:

```eval-ruby
array_of_arrays = [
  ["An", "array", "of", "strings"], 
  ["another", "array", "of", "strings"]
]
```

> Play around with `join` and the array reader function `[]` to figure out how this array of arrays works.

Arrays of arrays could be used to represent different groups (say, teams of people):

```eval-ruby
groups = [
  ["Mary", "Sam"],
  ["Peter", "Kay"]
]

team_1 = groups[0]
team_2 = groups[1]
```

Or, we can make an array of arrays _from_ different groups:

```eval-ruby
team_1 = ["Mary", "Sam"]
team_2 = ["Peter", "Kay"]

groups = [team_1, team_2]
```

> It's perfectly fine to reference variables within arrays. Why? _Referential transparency!_ The main object, in which this procedure is running, just turns the names `team_1` and `team_2` into the arrays they reference.

## Combining arrays

You can tell arrays to build new arrays that combine their elements, using `+`:

```eval-ruby
array_1 = ["What's", "the", "last", "word", "in", "this"]
array_2 = ["sentence?"]

array_1 + array_2
```

> Notice that `+` doesn't alter `array_1` or `array_2`: it builds a new array that combines their elements.

## Finding out how many elements there are

We can tell an array to give us its length (i.e. how many elements it contains) by calling the `length` method on it:

```eval-ruby
array = [1, 2, 3, 4]

array.length
```

## Using arrays to manage control flow

In [Chapter 4](../chapter4/README.md), we met `while`, which can be used to manage control flow by forcing an object to repeat procedures.

Arrays can be used to manage control flow too: by forcing an object to execute a procedure once for each element of an array. This process is called **iterating** over an array. 

There are a few ways to do this. We can use a `while` loop with an accumulator to run a procedure once for each item of an array:

```ruby
my_array = ["Hello", "there", "friend!"]
current_index = 0

while current_index < my_array.length do
  puts "I'm looping!"
  current_index += 1
end
```

> Still confused by `while` loops? Alter the code example above to use `break` instead.

We can combine this structure with the array reader method `[]` to tell an object to do something with elements of the array one after the other:

```ruby
my_array = ["Hello", "there", "friend!"]
current_index = 0

while current_index < my_array.length do
  puts my_array[current_index]
  current_index += 1
end
```

`Array` provides us with a neat method to tell an object to 'run a procedure once for each element of the array': the `each` method:

```eval-ruby
my_array = ["Hello", "there", "friend!"]

my_array.each do
  puts "I'm looping!"
end
```

What about if we want an object to do something with elements of the array one after the other? That is: to reference each item within an array during the procedure? We can do that in the following way:

```eval-ruby
my_array = ["Hello", "there", "friend!"]

my_array.each do |element|
  puts element
end
```

This `|element|` structure looks pretty weird. It works like this:

<animation demonstrating piping>

In other words, as `each` walks through the array, it grabs an element and shoves it into the pipe. `each` temporarily gives that element a name – in this case, `element`. That way, we can use the element in the procedure we wrote.

Just like program naming, we can call `element` whatever we like: so long as we use that name in the procedure. So, this:

```eval-ruby
my_array = ["Hello", "there", "friend!"]

my_array.each do |item|
  puts item
end
```

Is exactly the same as this:

```eval-ruby
my_array = ["Hello", "there", "friend!"]

my_array.each do |word|
  puts word
end
```

Is exactly the same as this:

```eval-ruby
my_array = ["Hello", "there", "friend!"]

my_array.each do |friendly_statement|
  puts friendly_statement
end
```

Is exactly the same as this:

```eval-ruby
my_array = ["Hello", "there", "friend!"]

my_array.each do |chicken|
  puts chicken
end
```

This kind of name, one that's assigned on the fly in a procedure, is called a **parameter**. We'll meet them in more detail, in [Chapter 9](../chapter9/README.md).

> It's a good idea to name the parameter after what elements _are_. So, if you're iterating over an array of numbers, each element is a number: so the parameter should probably be called `number`. If you're iterating over an array of instances of the `Dog` class, each element is a dog: so the parameter should probably be called `dog`. The naming choice is up to you as a programmer: pick one that future programmers, who'll have to work with your procedure, will understand.

## Using arrays as accumulators

A common programming problem goes something like this:

- Filter this list of numbers to return only numbers less than 10.

To solve this, we can use an **array as an accumulator**. On each pass of a loop, we'll tell the main object to add items to an array _if they meet a condition_ (being less than 10):

```eval-ruby
list_of_numbers = [17, 2, -1, 88, 7]
accumulator = []

list_of_numbers.each do |number|
  if number < 10
    accumulator.push(number)
  end
end

accumulator
```

> The `accumulator` was mutated during the `each` loop (it had elements added to it). What happened to the array referenced by `list_of_numbers`? Play with the code example above to find out.

## Checking if elements are in arrays

We can ask an array whether it includes an object by sending it the `include?` method:

```eval-ruby
words = ["Hello", "World!"]

words.include?("Hello")
```

- _**You've now met a very powerful set of array techniques. Combine them to build a program to the following specification (it's been started for you). Don't forget to break the specification into requirements!**_

> I'm a client working for the Blank House. We want to display positive tweets about our president on our website. However, our president is kind of unpopular, and we pretty much only receive negative press. Write me a program that filters out the following words from tweets: "sucks", "bad", "hate", "foolish", and the most popular: "danger to society". Replace each negative word or phrase them with the word "CENSORED". Some test tweets have been provided for you.

```eval-ruby
test_tweets = [
  "This president sucks!",
  "I hate this Blank House!",
  "I can't believe we're living under such bad leadership. We were so foolish",
  "President Presidentname is a danger to society. I hate that he's so bad – it sucks."
]

banned_phrases = ["sucks", "bad", "hate", "foolish", "danger to society"]
```

> It won't surprise you to know that these sorts of clients and these sorts of programs exist in the real world. As a programmer, you have a responsibility to build only what you're comfortable building. While you don't have to sign it, I recommend reading the [Responsible Software Manifesto](https://manifesto.responsiblesoftware.org/) and considering what sort of power you want to wield. Makers founder, Evgeny, wrote a great blog article on the subject too called [On Building Good Things](https://blog.makersacademy.com/on-building-good-things-fe75981a860e).

## Complete the mastery quiz for chapter 7

Use your mastery quizzes repository to complete the quiz for chapter 7.
