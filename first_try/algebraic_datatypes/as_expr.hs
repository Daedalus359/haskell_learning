isSubSeqOf :: (Eq a) => [a] -> [a] -> Bool
isSubSeqOf [] _ = True
isSubSeqOf (_:ssqc) [] = False
isSubSeqOf c@(a : ssqc) (b : sqs)
    |a == b = isSubSeqOf ssqc sqs
    |otherwise = isSubSeqOf c sqs

data Expr =
    Lit Integer
    | Add Expr Expr

eval :: Expr -> Integer
eval (Lit a) = a
eval (Add a b) = eval a + eval b

printExpr :: Expr -> String
printExpr (Lit a) = show a
printExpr (Add a b) = printExpr a ++ "+" ++ printExpr b