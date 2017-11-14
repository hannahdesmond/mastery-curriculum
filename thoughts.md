Ch4 -> Strings and Arrays? Using 'syntactic sugar' notation?
Ch5 -> Procedures should come earlier?

* Constants section should talk about program state:
## Naming conventions and `CONSTANTS`

Some objects change throughout the course of the program. In Ruby, we call these objects **Constants**. There are special rules for assigning names to constants: once we've assigned them, we can't assign them again.

When we start the program world, some constants come into existence automatically. One of these is `RUBY_VERSION`.

* _**Open a REPL, and output the `RUBY_VERSION` constant.**_
* _**Answer this: why isn't `RUBY_VERSION` just called `ruby_version`?**_

<details>
<summary>See how I'd do this</summary>
<p>

```irb
> RUBY_VERSION
=> "2.4.1"
```
</p>
</details>
<p></p>

> To tell Ruby that a particular object should never change (i.e. should be a constant), give it a name starting with a capital letter.
* Classes chapter should involve wrapping state with good names (encapsulation)