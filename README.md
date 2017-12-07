# Stryng
String utilities to make your life easier. Swift's strings management is one of the most painful feature of the language. Sure, it's great to have Unicode correctness and efficiency, but this comes at a cost: too much verbosity and complexity.

`Stryng` is designed to make it easier to work with strings by using the common and easy to remember subscript syntax.

## Examples

Retrieve a single character at a specific position.

```swift
let string = "Example"
// Without
string[self.index(startIndex, offsetBy: 1)] // "x"
// With Stryng
string[1] // "x"
```

Retrieve a string between two indices.

```swift
let string = "Example"
// Without
string[string(string, offsetBy: 0)..<string(string, offsetBy: 2)] // "Ex"
// With Stryng
string[0..<2] // "Ex"
```

Retrieve positions of a all substring occurences.

```swift
let string = "Example Example"
let occurences = string["xa"] // Returns a [Range<String.Index>] containing all positions of the subtring.
```

## Disclosure
Yes, string traversal in Swift can be slow. The reason why these subscripts don't exist in the standard library is that some people think that it hides the performance implications of traversing a string. Traversing a string from the `startIndex` until the `endIndex` has complexity O(n). 
If you need to get a character at a specific index, in one way or another you will have to traverse the string, but why would you need 3 lines of code instead of 1 to do that if you know what you're doing? 

This is why Stryng is here to help you.

## Author

I'm [Patrick Balestra](http://www.patrickbalestra.com).
Email: [me@patrickbalestra.com](mailto:me@patrickbalestra.com)
Twitter: [@BalestraPatrick](http://twitter.com/BalestraPatrick).

## License

`Stryng` is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

