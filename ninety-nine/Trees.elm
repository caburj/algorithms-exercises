module Trees exposing (Tree)


type Tree a
    = Empty
    | Node a (Tree a) (Tree a)
