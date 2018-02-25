module Problem40 exposing (goldbach)

import Html
import List
import Maybe
import Primes exposing (primesBelow)
import List.Extra exposing (find)


goldbach : Int -> Maybe ( Int, Int )
goldbach n =
    if n < 4 then
        Nothing
    else
        case isOdd n of
            True ->
                Nothing

            False ->
                let
                    primes =
                        primesBelow n

                    rem =
                        List.map (\a -> n - a) primes
                in
                    case find isPrime rem of
                        Nothing ->
                            Nothing

                        Just x ->
                            Just ( n - x, x )


main =
    Html.text
        (if (test) then
            "Your implementation passed all tests. goldbach 37212 == " ++ (toString (goldbach 37212))
         else
            "Your implementation failed at least one test."
        )


test : Bool
test =
    List.all (\n -> testGoldbach n <| goldbach n)
        [ 4, 10, 12, 14, 16, 18, 20, 100, 222, 120, 2444, 24444, 33336, 71000 ]
        && List.all (\n -> (goldbach n) == Nothing) [ -99999, -1, 0, 1, 99, 9999 ]


testGoldbach : Int -> Maybe ( Int, Int ) -> Bool
testGoldbach n result =
    case result of
        Nothing ->
            False

        Just ( p1, p2 ) ->
            if n < 3 && result /= Nothing then
                False
            else if isOdd n then
                False
            else if p1 + p2 /= n then
                False
            else if not (isPrime p1) || not (isPrime p2) then
                False
            else
                True



-- The core library function Arithmetic.isOdd is not available
-- on elm-lang.org/try, so we'll recreate it here


isOdd : Int -> Bool
isOdd n =
    n % 2 /= 0


isPrime : Int -> Bool
isPrime n =
    if n < 2 then
        False
    else
        List.member n <| primesBelow n
