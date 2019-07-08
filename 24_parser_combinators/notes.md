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

fail is currently part of Monad. The authors expect to to eventally be moved to MonadFail.

fail :: Monad m -> String -> m a

fail is how you can indicate a failed parse.

### Another Example

Prelude> parseString (integer >> eof) mempty "123"
Success ()

The parser worked properly - it found an integer followed by the end of the file. The type of eof is Parsing m => m (), so the type of (integer >> eof) is Parsing m => m (), and since the type of parseString is Parser a -> Text.Trifecta.Delta.Delta -> String -> Result a, a is bound to (), and our output type is thus Result ().

### Type Classes of Parsers

The trifecta library relies on the parsers library, which defines a variety of parser related type classes. Here is some relevant info:

The type class Parsing has Alternative as a superclass.
A minimal instance of Parsing includes try, notFollowedBy, and (<?>)

class Alternative m => Parsing m where
  try :: m a -> m a
  notFollowedBy :: Show a => m a -> m ()
  (<?>) :: Parsing m => m a -> String -> m a
  eof :: m ()

try takes a parser that may consume input and, on failure, goes back to where it started and fails.

notFollowedBy lets us specify a type to not match on. This can be helpful for creating a parser that matches on some pattern but only when that pattern is not followed by another type of pattern.

(<?>) takes a Parser and a String, and creates a parser which will use that String as an error message whenever the Parser did not consume input.

eof parses the end of input.

The CharParsing type class is for parsing individual characters.

class Parsing m => CharParsing m where
  notChar :: Char -> m Char
  anyChar :: m Char
  string :: String -> m String
  text :: Text -> m Text

notChar parses any single character other than the one provided, and returns whatever character it parsed.

anyChar succeeds for any character and returns the charater parsed.

string parses a sequence of characters, and returns the string parsed

text does the same as string, but for character sequences represented as a Text value.

### 24.6 Alternative

class Applicative f => Alternative f where
  
  --the identity of (<|>)
  empty :: f a

  --should be associative
  (<|>) :: f a -> f a -> f a

  some :: f a -> f [a]
  --one or more
  some v = some_v
    where
      many_v = some_v <|> pure []
      some_v = (fmap (:) v) <*> many_v

  --zero or more
  many :: f a -> f [a]
  many v = many_v
    where
      many_v = some_v <|> pure
      some_v = (fmap (:) v) <*> many_v

Note: I don't understand the implementations of some and many as written above

### QuasiQuotes

Quasiquotes are a language extension. It includes a value r :: QuasiQuoter which allows writing arbitrary text inside of the delimeters [r| |]


### Character and token parsers

Traditionally, parsing has been done in two stages: lexing and parsing.
Lexers typically perform parses that don't require looking ahead into the input stream by more than one token at a time.

Examples of tokenizing:

H> parseString (some integer) mempty "123 456"
Success [123, 456]

### Marshalling from an AST to a datatype

Marshalling describes going from a "Meaning" (such as a data value) to a Structure (such as an AST) that is serializable
Unmarshalling allows you to go from an AST to a "Meaning", which may be what you need to do after parsing

see Marshalling.hs for examples of doing this with JSON data