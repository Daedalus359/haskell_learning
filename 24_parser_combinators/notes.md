# Parser Combinators

### Intro

The core idea of parsing in programming is to accept serialized input in the form of a sequence of character (textual data) or bytes (binary data) and turn that into a value of a structured datatype.

Serialized data is data that has been translated into a format, such as JSON or XML, that can be stored or transmitted across a network connection.

Often when we are parsing things, the structured datatype that results will look something like a tree.

### Understanding the Parsing Process

A parser is a functiont hat takes some textual input (e.g. String, ByteString, Text) and returns some structure as output. Parsers analyze structure in conformance with the rules specified in a grammar, whether it's a grammar of human language, a programming language, or a format such as JSON.

A parser combinator is a higher order function that takes parsers as input and returns a new parser as output.

### The Parser Type

type Parser a = String -> Maybe (a, String)

A parser takes in a string, and either fails (Nothing) or returns a tuple with the value you wanted (a) and whatever's left of the string that you didn't consume (String).

Compare this to State:

newtype State s a = State {runState :: s -> (a,s)}

Parser is very much like state, except that is specifically works on Strings and the function it runs may fail.

### Hutton Meijer Parser Type

type Parser' a = Strin -> [(a, String)]

In this case the list contains any number of possibly valid parses starting from the input provided.

### Parsing Free Jazz

A single parser does not necessarily exhaust all of its input. It consumes as much text as needed to produce the value requested. Example:

Prelude> parseString (string "abc") mempty "abcdef"
success "abc"

### Parsing Fractions
