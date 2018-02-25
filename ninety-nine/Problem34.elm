module Main exposing (..)

import Html
import List
import Problem33 exposing (coprime)


totient : Int -> Int
totient n =
    List.length <| List.filter (coprime n) <| List.range 1 n


main =
    Html.text <|
        case test of
            0 ->
                "Your implementation passed all tests."

            1 ->
                "Your implementation failed one test."

            n ->
                "Your implementation failed " ++ (toString n) ++ " tests."


test : Int
test =
    List.length <|
        List.filter ((==) False)
            [ totient 10 == 4
            , totient 25 == 20
            , totient 120 == 32
            , totient 0 == 0
            , totient 1600 == 640
            , totient 37 == 36
            , totient 330 == 80
            , totient 65934 == 19440
            , totient 1313 == 1200
            , totient 45 == 24
            , totient -23 == 0
            ]
