module Problem31 exposing (isPrime)

import Html
import Primes exposing (multipleOf, primesBelow)


isPrime : Int -> Bool
isPrime n =
    if n < 2 then
        False
    else
        let
            root =
                n
                    |> toFloat
                    |> sqrt
                    |> floor
                    |> (+) 1
        in
            eratos (abs n) (List.range 2 root)


eratos : Int -> List Int -> Bool
eratos n list =
    case list of
        [] ->
            True

        x :: xs ->
            if n == 2 then
                True
            else if n % x == 0 then
                False
            else
                eratos n (List.filter (not << multipleOf x) xs)


main =
    Html.text
        (if test then
            "Your implementation passed all tests."
         else
            "Your implementation failed at least one test."
        )


test : Bool
test =
    let
        n =
            3

        primes =
            primesBelow n
    in
        List.all ((==) True) (List.map isPrime primes)
