{-# LANGUAGE FlexibleInstances #-}
import GHC.Arr

--Writing Functor Instances

--Ex 1: Bool is not higher kinded, and so can't have a Functor instance

--Ex 2:
data BoolAndSomethingElse a = False' a | True' a

instance Functor BoolAndSomethingElse where
  fmap f (False' a) = False' (f a)
  fmap f (True' a) = True' (f a)

--Ex 3:
data Bamse a = Falsish | Truish a

instance Functor Bamse where
  fmap _ Falsish = Falsish
  fmap f (Truish a) = Truish (f a)

--Ex 4:
newtype Mu f = InF {outF :: f (Mu f)}

--neither Mu nor (Mu f) can be a functor, as neither of these have kind (* -> *)

--Ex 5:
data D = D (Array Word Word) Int Int
--D has kind (*), so it can't be a functor. Functions can directly access the concrete types in D.

--Parameter rearrangement exercises

--Ex 1:
data Sum b a = First a | Second b

instance Functor (Sum e) where
  fmap f (First a) = First (f a)
  fmap f (Second b) = Second b

--Ex 2:
data Company a c b = DeepBlue a c | Something b

instance Functor (Company e e') where
  fmap f (Something b) = Something (f b)
  fmap _ (DeepBlue a c) = DeepBlue a c

--Ex 3:
data More b a =
  L a b a | R b a b
  deriving (Eq, Show)

instance Functor (More b) where
  fmap f (L a1 b1 a2) = L (f a1) b1 (f a2)
  fmap f (R b1 a b2) = R b1 (f a) b2

--More Functor Instance Writing

--Ex 1:

data Quent a b = Finance | Desk a | Bloor b

instance Functor (Quent a) where
  fmap _ Finance = Finance
  fmap _ (Desk a) = Desk a
  fmap f (Bloor b) = Bloor (f b)

--Ex 2:
data K a b = K a

instance Functor (K a) where
  fmap _ (K a) = (K a)-- (K a) is changing type from (K a b1) to (K a b2) for f  :: b1 -> b2

--Ex 3:
newtype Flip f a b = Flip (f b a)
  deriving (Eq, Show)

newtype K' a b = K' a

instance Functor (Flip K' a) where
  --using the concrete type constructor K' in place of f requires the pragma FlexibleInstances 
  fmap f (Flip (K' b)) = Flip (K' (f b))

--Ex 4:
data EvilGoateeConst a b = GoatyConst b

instance Functor (EvilGoateeConst a) where
  fmap f (GoatyConst b) = GoatyConst (f b)

--Ex 5:
data LiftItOut f a = LiftItOut (f a)

instance Functor f => Functor (LiftItOut f) where
  fmap g (LiftItOut fa) = LiftItOut (fmap g fa)

--Ex 6:
data Parappa f g a = DaWrappa (f a) (g a)

instance (Functor f, Functor g) => Functor (Parappa f g) where
  fmap h (DaWrappa fa ga) = DaWrappa (fmap h fa) (fmap h ga)

--Ex 7:
data IgnoreOne f g a b = IgnoringSomething (f a) (g b)

instance Functor g => Functor (IgnoreOne f g a) where
  fmap f (IgnoringSomething fa gb) = IgnoringSomething fa (fmap f gb)

--Ex 8:
data Notorious g o a t = Notorious (g o) (g a) (g t)

instance Functor g => Functor (Notorious g o a) where
  fmap f (Notorious go ga gt) = Notorious go ga (fmap f gt)

--Ex 9:
data List a = Nil | Cons a (List a)

instance Functor List where
  fmap _ Nil = Nil
  fmap f (Cons a1 lst) = Cons (f a1) (fmap f lst)

--Ex 10:
data GoatLord a =
    NoGoat
  | OneGoat a
  | MoreGoats (GoatLord a) (GoatLord a) (GoatLord a)

instance Functor GoatLord where
  fmap _ NoGoat = NoGoat
  fmap f (OneGoat a) = OneGoat (f a)
  fmap f (MoreGoats gl1 gl2 gl3) = MoreGoats (fmap f gl1) (fmap f gl2) (fmap f gl3)

--Ex 11:
data TalkToMe a =
    Halt
  | Print String a
  | Read (String -> a)

instance Functor TalkToMe where
  fmap _ Halt = Halt
  fmap f (Print s a) = Print s (f a)
  fmap f (Read fsa) = Read (f.fsa)
