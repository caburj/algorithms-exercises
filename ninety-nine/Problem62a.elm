module Main exposing (..)

import Html
import List


type Tree a
    = Empty
    | Node a (Tree a) (Tree a)


countInternals : Tree a -> Int
countInternals tree =
    case tree of
        Empty ->
            0

        Node _ Empty Empty ->
            0

        Node _ left right ->
            1 + countInternals left + countInternals right


main =
    Html.text
        (if (test) then
            "Your implementation passed all tests."
         else
            "Your implementation failed at least one test."
        )


test : Bool
test =
    List.all ((==) True)
        [ countInternals Empty == 0
        , countInternals (Node 1 Empty Empty) == 0
        , countInternals (Node 1 (Node 2 Empty Empty) Empty) == 1
        , countInternals (Node 1 (Node 2 Empty Empty) (Node 0 Empty Empty)) == 1
        , countInternals (Node "A" (Node "B" Empty Empty) (Node "C" Empty Empty)) == 1
        , countInternals
            (Node 1
                (Node 1 Empty (Node 4 Empty Empty))
                (Node 1 (Node 2 Empty Empty) Empty)
            )
            == 3
        ]
