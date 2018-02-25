module Problem36 exposing (primeFactorsM)

import Html
import List
import Problem35 exposing (primeFactors)
import Problem09 exposing (pack)
import Problem10 exposing (runLengths)


primeFactorsM : Int -> List ( Int, Int )
primeFactorsM n =
    List.map invert <| runLengths <| pack <| primeFactors n


invert : ( Int, Int ) -> ( Int, Int )
invert ( a, b ) =
    ( b, a )



--main =
--    Html.text <| toString <| primeFactorsM 36028


main =
    Html.text
        (if (test) then
            "Your implementation passed all tests."
         else
            "Your implementation failed at least one test."
        )


test : Bool
test =
    List.all (\( result, expect ) -> result == expect)
        [ ( primeFactorsM 36, [ ( 2, 2 ), ( 3, 2 ) ] )
        , ( primeFactorsM 10, [ ( 2, 1 ), ( 5, 1 ) ] )
        , ( primeFactorsM -1, [] )
        , ( primeFactorsM 1, [] )
        , ( primeFactorsM 0, [] )
        , ( primeFactorsM 120, [ ( 2, 3 ), ( 3, 1 ), ( 5, 1 ) ] )
        , ( primeFactorsM 2, [ ( 2, 1 ) ] )
        , ( primeFactorsM 23, [ ( 23, 1 ) ] )
        , ( primeFactorsM 69146, [ ( 2, 1 ), ( 7, 1 ), ( 11, 1 ), ( 449, 1 ) ] )
        , ( primeFactorsM 9007, [ ( 9007, 1 ) ] )
        , ( primeFactorsM 36028, [ ( 2, 2 ), ( 9007, 1 ) ] )
        , ( primeFactorsM 26028, [ ( 2, 2 ), ( 3, 3 ), ( 241, 1 ) ] )
        ]
