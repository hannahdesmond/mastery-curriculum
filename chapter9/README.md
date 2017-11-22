# Writing your own methods

We've written a lot of procedures, now. They've used conditional logic, loops, iterators, and a number of kinds of specialised object.

But sometimes, we might want to reuse these procedures. Let's say that our program wants to average some test scores for classes, then average the averages of those scores to get an average for the whole school:

```eval-ruby
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
puts "Class 1 average: " + class_1_average
puts "Class 2 average: " + class_2_average
puts "Class 3 average: " + class_3_average

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
puts "School average: " + school_average

# And return it to the REPL
school_average
```

Oh my gosh. That was horrible. So much typing. So effortful.

Isn't there a better way?

## Defining methods

Of course is there is. In the example above, we can extract some rules:

1. Accumulate the scores.
2. Divide the accumulation by the number of scores.

And we can define a procedure that will handle it. To store this procedure, we'll need to define a method:

```eval-ruby
def method_name
  # Whatever the procedure does, goes in here
end
```

Just like variables, we need to define a name for the method – so we can call it later:

```eval-ruby
def hello_world
  return "Hello World!"
end

hello_world
```

> Right now, we're defining the method on the program object. That's why we can call our method without referencing an object. More on this in [Chapter 10](../chapter10/README.md) – if you're confused for now, go remind yourself about [Chapter 3](../chapter3/README.md)!

## Method parameters

Methods can take parameters, which are objects used in the procedure: just like the `each` loop we saw in Chapters [7](../chapter7/README.md) and [8](../chapter8/README.md):

```eval-ruby
def hello(person)
  return "Hello, " + person + "!"
end

hello("Sam")
```

> Just like with the `each` loop, it doesn't matter what we call the parameter. I've called it `person` because that's a clear name for future programmers to read. But `name` would work, as would `nickname`, or `individual`, or `chicken`. So long as we refer to the parameter name we defined in the method procedure, we're golden.

## Writing a method procedure

Inside the `def`...`end` statement, we write the procedure we want to run:

<diagram showing the parts of a method outlined>

Let's refactor our horrible averager using methods. Start by defining a method called `average`:

```eval-ruby
def average
end
```

We want our `average` method to work with an array of numbers, so we'll give it one parameter:

```eval-ruby
def average(scores)
end
```

> Remember – it doesn't matter what we call the parameter. I've called it `scores` because that's what we're going to pass to average. But `numbers` would work, as would `test_scores`, or `digits`, or `chickens`. So long as we refer to the parameter name we defined in the method procedure, we're good-to-go.

From our code before, we know the first thing we do is accumulate the scores together:

```eval-ruby
def average(scores)
  scores_accumulator = 0

  scores.each do |score|
    scores_accumulator += score
  end
end
```

Then, we divide the accumulated result by the number of scores:

```eval-ruby
def average(scores)
  scores_accumulator = 0

  scores.each do |score|
    scores_accumulator += score
  end

  scores_accumulator.to_f / scores.length
end
```

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

OK, let's use `average` to refactor our first code.

## Refactoring code using methods

Let's start with the code we had to begin with:

```eval-ruby
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
puts "Class 1 average: " + class_1_average
puts "Class 2 average: " + class_2_average
puts "Class 3 average: " + class_3_average

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
puts "School average: " + school_average

# And return it to the REPL
school_average
```

First up, let's define and liberally apply our `average` method to it:

```eval-ruby
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
puts "Class 1 average: " + class_1_average
puts "Class 2 average: " + class_2_average
puts "Class 3 average: " + class_3_average

# Store the averages in a variable
average_scores_for_classes = [class_1_average, class_2_average, class_3_average]

# Get the average for the whole school by using our method
school_average = average(average_scores_for_classes)

# Print out the school average
puts "School average: " + school_average

# And return it to the REPL
school_average
```

OK, this is much shorter. But we can do better, by eliminating some of these variables using referential transparency:

```eval-ruby
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
puts "Class 1 average: " + average(test_scores_for_class_1)
puts "Class 2 average: " + average(test_scores_for_class_2)
puts "Class 3 average: " + average(test_scores_for_class_3)

# Print out the school average
puts "School average: " + average([average(test_scores_for_class_1), average(test_scores_for_class_2), average(test_scores_for_class_3)])

# And return it to the REPL
average([average(test_scores_for_class_1), average(test_scores_for_class_2), average(test_scores_for_class_3)])
```

## Over-simplifying

We can go deeper. If we move the printing of averages into our `average` method, we can get rid of a few more cluttered lines:

```eval-ruby
# Define the average method
def average(scores)
  scores_accumulator = 0

  scores.each do |score|
    scores_accumulator += score
  end

  puts scores_accumulator.to_f / scores.length
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

OK, now we're printing way too much. Every time we call `average`, it prints something (even if we just want the average value). **This is a major lesson of refactoring.** It's pretty tempting to try and tidy up lines of code into methods, but we run into problems when we try to make methods that do too much. Right now our `average` method should really be called `average_and_print`.

> Methods should **do one thing, and do it well**. The word `and` in a method name is a major clue that something's been refactored poorly. This principle is called the _Single Responsibility Principle_, and you'll meet it a lot in the next few months.

This entire process – of taking lots of lines of code, each of which does some small task, and grouping it into a method, is called **abstraction**. What you are doing is taking a bunch of actions and giving that whole bunch a name. As a result, it becomes easier to work with – working with the `average` method is definitely easier than writing all those lines of code by hand – but you also lose understanding of what's happening inside it.

> I said in [Chapter 2](../chapter2/README.md) that naming is one of the hardest problems in programming. The other one is picking the 'right abstraction' – the right way to group and simplify your code. That's what we'll be spending a lot of time on during Makers Academy.

## Picking the right abstraction

Choosing the right abstraction is incredibly hard to do. And, it's often a while before you know if you made a good choice or not.

That said, here are some helpful rules of thumb to picking the right abstraction when writing methods:

1. Can you name your method in a simple way, without using the word 'and'? Does it do one thing, and nothing more?
2. Can you name your method after what it returns, instead of what it does? For instance, `average(test_scores)` is a better name than `averages_scores(test_scores)`. For another example, `score(hand)` is a better method name than `scores_cards(hand)`.

If you can answer 'yes' to both 1 and 2, your method is more likely to be a good one.