module Main exposing (..)

import Html
import List


type Tree a
    = Empty
    | Node a (Tree a) (Tree a)


completeTree : a -> Int -> Tree a
completeTree v n =
    case n of
        0 ->
            Empty

        1 ->
            Node v Empty Empty

        _ ->
            let
                n_ =
                    (n - 1) // 2
            in
                if n % 2 == 1 then
                    Node v (completeTree v n_) (completeTree v n_)
                else
                    Node v (completeTree v (n_ + 1)) (completeTree v n_)


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
        [ completeTree 'x' 0 == Empty
        , completeTree 'x' 1 == Node 'x' Empty Empty
        , completeTree 'x' 3 == (Node 'x' (Node 'x' Empty Empty) (Node 'x' Empty Empty))
        , completeTree 'x' 5
            == (Node 'x'
                    (Node 'x' (Node 'x' Empty Empty) (Node 'x' Empty Empty))
                    (Node 'x' Empty Empty)
               )
        ]
