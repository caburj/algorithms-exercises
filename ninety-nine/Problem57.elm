module Main exposing (..)

import Html
import List


type Tree a
    = Empty
    | Node a (Tree a) (Tree a)


toBSTree : List comparable -> Tree comparable
toBSTree list =
    case list of
        [] ->
            Empty

        _ ->
            List.foldl addBSNode Empty list


addBSNode : comparable -> Tree comparable -> Tree comparable
addBSNode v tree =
    case tree of
        Empty ->
            Node v Empty Empty

        Node v_ left right ->
            case compare v v_ of
                LT ->
                    Node v_ (addBSNode v left) right

                GT ->
                    Node v_ left (addBSNode v right)

                EQ ->
                    tree


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
        [ toBSTree [] == Empty
        , toBSTree [ 1 ] == Node 1 Empty Empty
        , toBSTree [ 1, 1, 1 ] == Node 1 Empty Empty
        , toBSTree (List.range 1 5) == Node 1 Empty (Node 2 Empty (Node 3 Empty (Node 4 Empty (Node 5 Empty Empty))))
        , toBSTree (List.reverse (List.range 1 5)) == Node 5 (Node 4 (Node 3 (Node 2 (Node 1 Empty Empty) Empty) Empty) Empty) Empty
        , toBSTree [ 6, 2, 4, 20, 1, 11, 12, 14, 6 ]
            == Node 6
                (Node 2
                    (Node 1 Empty Empty)
                    (Node 4 Empty Empty)
                )
                (Node 20
                    (Node 11
                        Empty
                        (Node 12
                            Empty
                            (Node 14 Empty Empty)
                        )
                    )
                    Empty
                )
        ]
