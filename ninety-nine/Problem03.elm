module Main exposing (..)

import Html
import List
import Maybe


elementAt : List a -> Int -> Maybe a
elementAt list n =
    case list of
        [] ->
            Nothing

        x :: xs ->
            if n == 1 then
                Just x
            else
                elementAt xs (n - 1)


main : Html.Html a
main =
    Html.text <|
        case test of
            0 ->
                "Your implementation passed all tests."

            1 ->
                "Your implementation failed one test."

            x ->
                "Your implementation failed " ++ (toString x) ++ " tests."


test : Int
test =
    List.length <|
        List.filter ((==) False)
            [ elementAt [ 1, 2, 3, 4 ] 2 == Just 2
            , elementAt [ 1 ] 2 == Nothing
            , elementAt [ 1 ] 1 == Just 1
            , elementAt [] 2 == Nothing
            , elementAt [] (-1) == Nothing
            , elementAt [] 0 == Nothing
            , elementAt [ 1, 2, 3, 4 ] (-1) == Nothing
            , elementAt [ 1, 2, 3, 4 ] 0 == Nothing
            , elementAt [ 'a', 'b', 'c' ] 2 == Just 'b'
            ]
