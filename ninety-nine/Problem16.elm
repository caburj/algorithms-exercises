module Main exposing (..)

import Html
import List


{-| drop every nth
-}
dropNth : List a -> Int -> List a
dropNth list n =
    if n <= 0 then
        list
    else
        case list of
            [] ->
                []

            _ ->
                (List.filterMap (notNth n) << List.indexedMap (,)) list


notNth : Int -> ( Int, a ) -> Maybe a
notNth n ( i, val ) =
    if (i + 1) % n /= 0 then
        Just val
    else
        Nothing


main : Html.Html a
main =
    Html.text <|
        case test of
            0 ->
                "Your implementation passed all tests."

            1 ->
                "Your implementation failed one test."

            x ->
                "Your implementation failed " ++ toString x ++ " tests."


test : Int
test =
    List.length <|
        List.filter ((==) False)
            [ dropNth [ 1, 2, 5, 5, 2, 1 ] 2 == [ 1, 5, 2 ]
            , dropNth (List.range 1 20) 3 == [ 1, 2, 4, 5, 7, 8, 10, 11, 13, 14, 16, 17, 19, 20 ]
            , dropNth (List.range 1 5) 6 == [ 1, 2, 3, 4, 5 ]
            , dropNth (List.range 1 5) 0 == [ 1, 2, 3, 4, 5 ]
            , dropNth (List.range 1 5) -1 == [ 1, 2, 3, 4, 5 ]
            , dropNth (List.range 1 5) 1 == []
            , dropNth [ "1", "2", "3", "4", "5", "6" ] 2 == [ "1", "3", "5" ]
            ]
