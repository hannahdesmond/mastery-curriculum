# Writing your own methods

Most Ruby procedures are wrapped up in methods, which are defined 'inside' objects. When you call a method on an object:

```eval-ruby
1.positive?
```

That object executes a procedure inside itself:

```ruby
# Inside 1
if self > 0
  return true
else
  return false
end
```

And then returns the outcome of the procedure `true`.

We've written a lot of procedures now. They've used conditional logic, loops, iterators, and several kinds of specialised object. Every time we've written a procedure, we've defined it on the `main` object, which has carried out the procedure for us.

In this chapter, we'll learn how to give these procedures a name, by wrapping them inside methods. In [Chapter 10](../chapter10/README.md), we'll learn how to define these methods on objects other than the `main` object.

## Methods are reusable procedures

Let's say that we have the following program specification:

> We're a school. Our students have just finished taking their final test. We have test scores for each class of students, and we want to know the average for each class. We also want to know the average for the whole school.

Here's some (horrible!) code to solve this problem. As you can see – it's really repetitive.

```ruby
# Here are the scores
test_scores_for_class_1 = [55, 78, 67, 92]
test_scores_for_class_2 = [48, 99, 91, 70]
test_scores_for_class_3 = [56, 58, 61, 98, 100]

# Set up the accumulators
class_1_overall_score_accumulator = 0
class_2_overall_score_accumulator = 0
class_3_overall_score_accumulator = 0

# Add together for class 1
test_scores_for_class_1.each do |score|
  class_1_overall_score_accumulator += score
end

# Add together for class 2
test_scores_for_class_2.each do |score|
  class_2_overall_score_accumulator += score
end

# Add together for class 3
test_scores_for_class_3.each do |score|
  class_3_overall_score_accumulator += score
end

# Get the average for each class by dividing the sum by the number of scores
class_1_average = class_1_overall_score_accumulator.to_f / test_scores_for_class_1.length
class_2_average = class_2_overall_score_accumulator.to_f / test_scores_for_class_2.length
class_3_average = class_3_overall_score_accumulator.to_f / test_scores_for_class_3.length

# Print out the averages
puts "Class 1 average: " + class_1_average.to_s
puts "Class 2 average: " + class_2_average.to_s
puts "Class 3 average: " + class_3_average.to_s

# Store the averages in a variable
average_scores_for_classes = [class_1_average, class_2_average, class_3_average]

# Now set up an accumulator for the school scores
school_overall_score_accumulator = 0

# Add together for the school
average_scores_for_classes.each do |class_average|
  school_overall_score_accumulator += class_average
end

# Get the average for the whole school by dividing the sum by the number of classes
school_average = school_overall_score_accumulator.to_f / average_scores_for_classes.length

# Print out the school average
puts "School average: " + school_average.to_s

# And return it to the REPL
school_average
```

Which will return:
```
Class 1 average: 73.0
Class 2 average: 77.0
Class 3 average: 74.6
School average: 74.86666666666666
```

Oh my gosh. That was horrible. So much typing. So effortful.

Isn't there a better way? Of course there is.

## Defining methods

In the example above, we can use algorithmic thinking to extract some rules:

1. Accumulate the scores.
2. Divide the accumulation by the number of scores.
3. Return the result.

We can write a procedure that will carry out these rules. And, using a method, we could give that procedure a name. That's what a method is - a **named procedure**. 

> Variables are named objects. Methods are named procedures.

Here's how we define a method, using `def`:

```eval-ruby
def method_name
  # Whatever the procedure does goes in here
end
```

Just like variables, we need to define a name for the method. We can use this name to call the method later:

```eval-ruby
def hello_world
  return "Hello World!"
end

hello_world
```

To reduce the repetition of our code above, we're going to define a method called `average`:

```eval-ruby
def average
end
```

And we're going to put the procedure for finding an average inside it.

> Right now, we're defining the method on the program object. That's why we can call our method without referencing an object using dot syntax. In [Chapter 10](../chapter10/README.md), we'll define methods on other objects. If you're confused, go remind yourself about messages and objects using [Chapter 3](../chapter3/README.md).

## Return values from methods

Remember, when we send an object a message, the object invokes a method using that message. Then, the object carries out a procedure. Finally, the object returns something back to whoever sent the original message.

To designate what the return value should be from a method, use the `return` keyword:

```eval-ruby
def gimme_five
  # We want the return value to be 5
  return 5
end

gimme_five
```

Remember from [Chapter 4](../chapter4/README.md) that procedures are executed by the object _instruction-by-instruction_. When an object hits a `return` statement, it'll stop executing the procedure inside the method, and just return whatever it's told to. In the example above, the object on which `gimme_five` is defined – the `main` object – proceeds through the procedure, stopping when it sees `return 5` and returns `5` as the return value.

This 'stop when you see return' gimmick means that any instructions after a `return` instruction won't be executed:

```eval-ruby
def stop_halfway
  return "Stop here"
  sum = 1 + 1
  return sum
end

stop_halfway
```

> Play around with the example above. How can we return `sum` instead?

#### Implicit returns

In Ruby, any methods that don't contain a `return` statement will secretly add one on the last line of the procedure. So the following two examples are identical:

```eval-ruby
def hello
  return "Hello World!"
end

hello
```

```eval-ruby
def hello
  "Hello World!"
end

hello
```

This kind of secret returning is called using an **implicit return** (as opposed to actually writing one out, which is an **explicit return**) and helps keep Ruby so beautifully clean and readable.

#### Empty method procedures

Remember that `nil` is a Ruby object used to represent the 'absence of anything'. When we define an empty method – one with no procedure inside – Ruby will secretly add a line containing `nil` to it. So, again, the following two examples are identical:

```eval-ruby
def do_nothing
end

do_nothing
```

```eval-ruby
def do_nothing
  nil
end

do_nothing
```

> Because of implicit returns (see the section just before this one), `do_nothing` is actually executing the following procedure: `return nil`.

## Method parameters

When we call a method on an object, we often provide it with arguments to use during the procedure:

```eval-ruby
vegetables_i_like = ["broccoli", "radishes"]

# push takes one argument
vegetables_i_like.push("peas")
```

Defined on the array `vegetables_i_like` is a procedure that does something like this:

```ruby
# inside vegetables_i_like
self.elements = self.elements + "peas"
```

In the case above, the object `"peas"` is provided as an _argument_ to the method `push`. Then, in the procedure, the `"peas"` object is used somehow.

Method parameters are temporary names for objects provided as arguments. They're set up at the beginning of the procedure, then they go away at the end, just like the `each` loop we saw in Chapters [7](../chapter7/README.md) and [8](../chapter8/README.md):

```eval-ruby
def hello(person)
  return "Hello, " + person + "!"
end

hello("Tommy")
```

Method parameters _define a variable inside the method procedure_. The name of the variable is set to the parameter name, and the value is set to whatever argument you pass to the method when you execute it: 

```eval-ruby
def hello(person)
  # In a couple of lines time, 'person' will equal "Tommy"
  return "Hello, " + person + "!"
end

hello("Tommy")
```

Just like with the `each` loop, it doesn't matter what we call the parameter, so long as we refer to that parameter name in the method procedure. I've called this parameter `person` because that's a clear name for the procedure to use. But `name` would work, as would `nickname`, or `individual`, or `chicken`:

```eval-ruby
def hello(chicken)
  # In a couple of lines' time, 'chicken' will equal "Tommy"
  return "Hello, " + chicken + "!"
end

hello("Tommy")
```

In this way, the object currently executing a procedure can use other objects to vary the return value:

```eval-ruby
def make_cake(flour_exists)
  if flour_exists
    return :cake
  else
    return 0
  end
end

make_cake(true)
```

## Writing a method procedure

Inside the `def`...`end` statement, we write the procedure we want to run. Let's refactor our horrible score averager using methods. Start by defining a method called `average`:

```ruby
def average
end
```

We want the procedure inside `average` to work with an array of numbers, so we'll give it one parameter representing that array of numbers, `scores`. That way, when we call `average` we can provide an argument. That argument will be accessible (under the temporary name `scores`) to the procedure inside `average`:

```ruby
def average(scores)
end
```

> Remember, it doesn't matter what we call the parameter. The method will assign a variable inside itself, called `scores`, equal to whatever we pass into it. I've called the parameter `scores` because that's what we're going to pass to average. But `numbers` would work, as would `test_scores`, or `digits`, or `chickens`. So long as we refer to the parameter name we defined in the method procedure, we're good to go.

From the averaging procedure we wrote earlier, we know the first thing we do is accumulate the scores together:

```ruby
def average(scores)
  scores_accumulator = 0

  scores.each do |score|
    scores_accumulator += score
  end
end
```

Then, we divide the accumulated result by the number of scores:

```ruby
def average(scores)
  scores_accumulator = 0

  scores.each do |score|
    scores_accumulator += score
  end

  scores_accumulator.to_f / scores.length
end
```

Then, we return the result:

```ruby
def average(scores)
  scores_accumulator = 0

  scores.each do |score|
    scores_accumulator += score
  end

  result = scores_accumulator.to_f / scores.length
  return result
end
```

Actually, we can use Ruby's implicit return policy to leave that last step out of the procedure as the result will be implicitly returned.

Tada! We now have an `average` method we can call whenever we want:

```eval-ruby
def average(scores)
  scores_accumulator = 0

  scores.each do |score|
    scores_accumulator += score
  end

  scores_accumulator.to_f / scores.length
end

average([15, 23, 16, 100, 19])
```

What's the benefit of this? Well, now we can use `average` to refactor our first solution to the test scores problem.

## Refactoring code using methods

First up, let's define and liberally apply our `average` method to our earlier code:

```ruby
# Define the average method
def average(scores)
  scores_accumulator = 0

  scores.each do |score|
    scores_accumulator += score
  end

  scores_accumulator.to_f / scores.length
end

# Here are the scores
test_scores_for_class_1 = [55, 78, 67, 92]
test_scores_for_class_2 = [48, 99, 91, 70]
test_scores_for_class_3 = [56, 58, 61, 98, 100]

# Get the average for each class by using our method
class_1_average = average(test_scores_for_class_1)
class_2_average = average(test_scores_for_class_2)
class_3_average = average(test_scores_for_class_3)

# Print out the averages
puts "Class 1 average: " + class_1_average.to_s
puts "Class 2 average: " + class_2_average.to_s
puts "Class 3 average: " + class_3_average.to_s

# Store the averages in a variable
average_scores_for_classes = [class_1_average, class_2_average, class_3_average]

# Get the average for the whole school by using our method
school_average = average(average_scores_for_classes)

# Print out the school average
puts "School average: " + school_average.to_s

# And return it to the REPL
school_average
```

Which, as before, will return:
```
Class 1 average: 73.0
Class 2 average: 77.0
Class 3 average: 74.6
School average: 74.86666666666666
```

OK, this is much easier to read. But we can do even better, by eliminating some of these variables using referential transparency:

```ruby
# Define the average method
def average(scores)
  scores_accumulator = 0

  scores.each do |score|
    scores_accumulator += score
  end

  scores_accumulator.to_f / scores.length
end

# Here are the scores
test_scores_for_class_1 = [55, 78, 67, 92]
test_scores_for_class_2 = [48, 99, 91, 70]
test_scores_for_class_3 = [56, 58, 61, 98, 100]

# Print out the averages
puts "Class 1 average: " + average(test_scores_for_class_1).to_s
puts "Class 2 average: " + average(test_scores_for_class_2).to_s
puts "Class 3 average: " + average(test_scores_for_class_3).to_s

# Print out the school average
puts "School average: " + average([average(test_scores_for_class_1), average(test_scores_for_class_2), average(test_scores_for_class_3)]).to_s

# And return it to the REPL
average([average(test_scores_for_class_1), average(test_scores_for_class_2), average(test_scores_for_class_3)])
```

## Over-simplifying

We could go deeper. If we move the printing of averages into our `average` method, we can get rid of a few more cluttered lines:

```ruby
# Define the average method
def average(scores)
  scores_accumulator = 0

  scores.each do |score|
    scores_accumulator += score
  end

  puts (scores_accumulator.to_f / scores.length).to_s
  scores_accumulator.to_f / scores.length
end

# Here are the scores
test_scores_for_class_1 = [55, 78, 67, 92]
test_scores_for_class_2 = [48, 99, 91, 70]
test_scores_for_class_3 = [56, 58, 61, 98, 100]

# Print out the averages
average(test_scores_for_class_1)
average(test_scores_for_class_2)
average(test_scores_for_class_3)

# Print out the school average, and return to the REPL
average([average(test_scores_for_class_1), average(test_scores_for_class_2), average(test_scores_for_class_3)])
```

But is this really better? 

- For one, we're printing way too much. Every time we call `average`, it prints something (even if we just want the average value).
- For two, that last line is incredibly hard to read.

**This is a major lesson of refactoring.** It's generally good to tidy up lines of code into methods, but we run into problems when we create methods that do too much. Right now our `average` method should really be called `average_and_print`.

> Methods should **do one thing, and do it well**. The word `and` in a method name is a major clue that something's been refactored poorly. This principle is called the _Single Responsibility Principle_, and you'll meet it a lot in the next few months.

Taking a procedure (lots of lines of code) and grouping it into a named method is an example of **abstraction**. Abstraction results in code that is easier to work with – using the `average` method is definitely easier than writing all those lines of code each time – but we lose understanding of what's happening inside the code.

> I said in [Chapter 2](../chapter2/README.md) that naming is one of the hardest problems in programming. The other one is picking the 'right abstraction' – the right way to group and simplify your code. That's what we'll be spending a lot of time on during Makers.

## Picking the right abstraction

Picking the right abstraction is really hard. And, you often need to use your abstraction for a while before you know if you made a good choice or not. This means that, as programmers, we get used to writing and deleting code.

> Code is cheap! It costs literally nothing. Get used to deleting it, and rewriting it. Practising rewriting code from scratch will be painful for a while, but you'll get much faster and learn a lot in the process. It's easy to get precious over code you've written, but the confidence of knowing you're able to reproduce it from scratch is worth having.

Here are some helpful rules of thumb for picking the right abstraction when writing methods:

1. Can you name your method in a simple way, without using the word 'and'? Does it do one thing, and nothing more?
2. Can you name your method after what it returns, instead of what it does? For instance, `average(test_scores)` is a better name than `averages_scores(test_scores)`. For another example, `score(hand)` is a better method name than `scores_cards(hand)`.

If you can answer 'yes' to both 1 and 2, your method is more likely to be a good one.

## Complete the mastery quiz for chapter 9

Use your mastery quizzes repository to complete the quiz for chapter 9.
