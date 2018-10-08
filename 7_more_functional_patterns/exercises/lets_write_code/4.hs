module Arith4 where

    roundTrip :: (Show a, Read b) => a -> b

    --ex 4
    --roundTrip a = read (show a)

    --ex 5
    roundTrip = read.show

    main = do
        --ex 6
        print ((roundTrip 4) :: Integer)
        print (id 4)