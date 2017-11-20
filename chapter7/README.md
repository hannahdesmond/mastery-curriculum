# Arrays

So far we've met objects that can really only 'contain' one thing:

- Integers contain the value of the integer.
- Strings contain a bit of text.

We call whatever an object 'contains' that object's **state**.

What if we want to store more than one thing in an object's state? Is there an object for that?

> We've actually met an object that can contain many things: The Main Object contains all the objects in the program. Therefore, when we describe the program world, and the objects in it, we're really describing the state of the main object: the **program state**.

## Collections

The `Array` class is used to make a 'collection object': an object that can store many other objects inside itself. Crucially, a Ruby array is **mutable**: it can be made larger, by adding more objects. You can also remove objects from it.

> An instance of the `Array` class is called an array.

Here's how you use the **Array** class:

```eval-ruby
an_array = Array.new

an_array.push("Hello World")
an_array.push("It's me!")
an_array.push("Mario!")

return an_array
```

> Notice that I'm using Ruby's syntactic sugar to create new instances of the `String` class. Don't be fooled – under the hood, Ruby is still running `String.new("Hello World")`. It's just easier for me as a programmer to write it the shorthand way.

- _**Add a couple more strings to the array.**_
- _**Add a couple of integers and floats to the array.**_
- _**Add the main object to the array.**_

Hold on. If the main object contains all other objects – including this array we just made – how can we add it to the array? How can something inside the universe contain the universe itself?

## How state works in Ruby

It's not quite accurate to think of Ruby objects as being 'stored inside' one another: that's a convenient mental model. In fact, Ruby objects that reference one another do so by using **pointers**. Pointers are the arrows that join _names_ with _objects_.

<demonstrate objects being added to an array, referenced by pointer>

> This is not a big deal: it's perfectly OK to think of Ruby objects as living 'inside' one another. But it's also helpful to know that this is made possible by the idea of pointers.

## Modifying arrays

We've seen that we can add things to an existing array object by using the array's `push` method, with the object-to-be-added as an argument to that method:

```eval-ruby
another_array = []
another_array.push("A short string")
```

> Things inside an array are called **elements**.

Arrays have syntactic sugar, too: `[]` does the same thing as `Array.new`. Using this shorthand, you can set up arrays that already contain elements:

```eval-ruby
an_array_containing_elements = ["This", "is", "an", "array"]
```

You can remove elements from an array using `delete_at(index)`:

```eval-ruby
array = ["a", "b", "c"]

array.delete_at(1)

array
```

> Watch out! Arrays are _zero-indexed_. That means they count from zero: the first element is in position `0`.

Or just the last element using `pop`:

```eval-ruby
array = [1, 2, 3]

array.pop

array
```

All of the above will modify the array: that is, the array will change when you run `push`, `delete_at`, or `pop`.

## Reading arrays

You can read a single element from an array by using the `[]` method:

```eval-ruby
array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# Let's get the first element
array[0]
```

> The `[]` method won't accept dot syntax. It's one of the only things in Ruby that won't.

- _**Access different elements of the array above using `[]`.**_

You can read a bunch of elements at once, using `slice`:

```eval-ruby
array = [1, 2, 3, 4, 5, 6]

array.slice(0, 1)
```

> This is the first method we've met that takes two arguments. `slice`'s first argument is the starting index, and the last argument is the index to stop on. Play around to figure it out.

## Outputting from arrays

Arrays can be useful for storing elements you might want to keep separate sometimes, and have together in other times. If storing strings in an array, it's pretty common to use `join` to output them stitched-together:

```eval-ruby
sentence = ["Hello,", "you", "are", "NOT", "welcome", "here"]

sentence.join(" ")
```

- _**Add a line of code that removes the `"NOT"` string from the array, making the sentence friendlier. Don't modify the original array!**_

%accordion%See how I'd do it%accordion%

```eval-ruby
sentence = ["Hello,", "you", "are", "NOT", "welcome", "here"]

sentence.delete_at(3)

sentence.join(" ")
```

> Why can't I chain the methods together to make `sentence.delete_at(3).join(" ")`?

%/accordion%