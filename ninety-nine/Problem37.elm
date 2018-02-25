module Main exposing (..)

import Html
import List
import Problem36 exposing (primeFactorsM)


phi : Int -> Int
phi n =
    let
        terms =
            List.map (\( p, m ) -> (p - 1) * p ^ (m - 1)) (primeFactorsM n)
    in
        if n == 1 then
            1
        else
            case terms of
                [] ->
                    0

                _ ->
                    List.foldl (\a acc -> acc * a) 1 terms



--main =
--    let
--        n =
--            1
--    in
--        Html.text (toString <| ( phi n, totient n ))


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
        [ ( phi 36, totient 36 )
        , ( phi 10, totient 10 )
        , ( phi 1, totient 1 )
        , ( phi 0, totient 0 )
        , ( phi 120, totient 120 )
        , ( phi 2, totient 2 )
        , ( phi 23, totient 23 )
        , ( phi 69145, totient 69145 )
        , ( phi 9007, totient 9007 )
        , ( phi 36028, totient 36028 )
        , ( phi 26028, totient 26028 )
        ]


totient : Int -> Int
totient n =
    List.length <| coprimes n


coprimes : Int -> List Int
coprimes n =
    List.filter (\x -> coprime n x) (List.range 1 n)


coprime : Int -> Int -> Bool
coprime a b =
    gcd a b == 1


gcd : Int -> Int -> Int
gcd a b =
    if b == 0 then
        abs a
    else
        gcd b (a % b)
