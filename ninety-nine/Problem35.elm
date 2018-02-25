module Problem35 exposing (primeFactors)

import Html
import List
import Maybe
import Primes exposing (primesBelow)


primeFactors : Int -> List Int
primeFactors n =
    getFactors n (primesBelow n)


getFactors : Int -> List Int -> List Int
getFactors n primes =
    case primes of
        [] ->
            []

        x :: xs ->
            let
                soFar =
                    tryFactor n x

                factored_n =
                    List.foldl (\a acc -> acc // a) n soFar
            in
                soFar ++ getFactors factored_n xs


tryFactor : Int -> Int -> List Int
tryFactor n prime =
    if n == prime then
        [ n ]
    else
        case n % prime of
            0 ->
                prime :: tryFactor (n // prime) prime

            _ ->
                []


main =
    Html.text <| toString <| primeFactors 69146



--main =
--    Html.text
--        (if (test) then
--            "Your implementation passed all tests."
--         else
--            "Your implementation failed at least one test."
--        )
--test : Bool
--test =
--    List.all (\( result, expect ) -> result == expect)
--        [ ( primeFactors 36, [ 2, 2, 3, 3 ] )
--        , ( primeFactors 10, [ 2, 5 ] )
--        , ( primeFactors -1, [] )
--        , ( primeFactors 1, [] )
--        , ( primeFactors 0, [] )
--        , ( primeFactors 120, [ 2, 2, 2, 3, 5 ] )
--        , ( primeFactors 2, [ 2 ] )
--        , ( primeFactors 23, [ 23 ] )
--        , ( primeFactors 69146, [ 2, 7, 11, 449 ] )
--        , ( primeFactors 9007, [ 9007 ] )
--        , ( primeFactors 36028, [ 2, 2, 9007 ] )
--        , ( primeFactors 26028, [ 2, 2, 3, 3, 3, 241 ] )
--        ]
