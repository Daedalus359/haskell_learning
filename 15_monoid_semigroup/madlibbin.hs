type Verb = String
type Adjective = String
type Adverb = String
type Noun = String
type Exclamation = String

madlibbin :: Exclamation
	-> Adverb
	-> Noun
	-> Adjective
	-> String

madlibbin exc adj noun adv =
	mconcat [exc,
			 "! he said ",
			 adv, 
			 " as he jumped into his car ", 
			 noun, 
			 " and drove off with his ", 
			 adj, 
			 " wife."]