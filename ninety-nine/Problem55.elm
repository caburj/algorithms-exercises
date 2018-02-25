module Main exposing (..)

import Html
import List
import String


type Tree a
    = Empty
    | Node a (Tree a) (Tree a)


balancedTree : Int -> Tree Char
balancedTree n =
    if n < 1 then
        Empty
    else
        case n of
            1 ->
                Node 'x' Empty Empty

            _ ->
                let
                    n_ =
                        (n - 1) // 2
                in
                    if n % 2 == 1 then
                        Node 'x' (balancedTree n_) (balancedTree n_)
                    else
                        Node 'x' (balancedTree (n_ + 1)) (balancedTree n_)



--main =
--    balancedTree 5
--        |> toString
--        |> Html.text


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
        [ count Empty == 0
        , count (Node 'x' (Empty) (Empty)) == 1
        , count (Node 'x' (Node 'x' (Empty) (Empty)) (Node 'x' (Empty) (Empty))) == 3
        , count
            (Node 'x'
                (Node 'x' (Node 'x' (Empty) (Empty)) (Node 'x' (Empty) (Empty)))
                (Node 'x' (Node 'x' (Empty) (Empty)) (Node 'x' (Empty) (Empty)))
            )
            == 7
        , balancedTree 0 == Empty
        , balancedTree -1 == Empty
        , balancedTree 1 == (Node 'x' (Empty) (Empty))
        , balancedTree 3 == (Node 'x' (Node 'x' (Empty) (Empty)) (Node 'x' (Empty) (Empty)))
        , balancedTree 7
            == (Node 'x'
                    (Node 'x' (Node 'x' (Empty) (Empty)) (Node 'x' (Empty) (Empty)))
                    (Node 'x' (Node 'x' (Empty) (Empty)) (Node 'x' (Empty) (Empty)))
               )
        , testBalance (balancedTree 3) 3 == True
        , testBalance (balancedTree 4) 4 == True
        , testBalance (balancedTree 5) 5 == True
        , testBalance (balancedTree 7) 7 == True
        , testBalance (balancedTree 21) 21 == True
        , testBalance (balancedTree 31) 31 == True
        , testBalance (balancedTree 32) 32 == True
        , testBalance (balancedTree 33) 33 == True
        , testBalance (balancedTree 59) 59 == True
        , testBalance (balancedTree 64) 64 == True
        , testBalance (balancedTree 73) 73 == True
        , testBalance (balancedTree 5000) 5000 == True
        ]


testBalance : Tree a -> Int -> Bool
testBalance tree n =
    case tree of
        Empty ->
            n == 0

        Node node left right ->
            List.all ((==) True)
                [ (abs (count left) - count (right)) < 2
                , count tree == n
                ]



-- count number of Nodes in a Tree


count : Tree a -> Int
count tree =
    case tree of
        Empty ->
            0

        Node n left right ->
            1 + (count left) + (count right)
