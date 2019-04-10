--weird exercises
a = const <$> Just "Hello" <*> (pure "World")

b = (,,,) <$> (Just 90) <*> (Just 10) <*> (Just "Tierness") <*> Just [1, 2, 3]
