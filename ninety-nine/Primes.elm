module Primes exposing (primesBelow, primesRange, sieve, multipleOf)

import Html exposing (Html)
import List exposing (range)
import Problem01 exposing (last)


primesRange : Int -> Int -> List Int
primesRange start end =
    List.filter (\n -> n >= start && n <= end) (primesBelow end)


primesBelow : Int -> List Int
primesBelow n =
    let
        root =
            n
                |> toFloat
                |> sqrt
                |> floor
                |> (+) 1

        list =
            List.range 2 n
    in
        sieve list root


sieve : List Int -> Int -> List Int
sieve list root =
    case list of
        [] ->
            []

        x :: xs ->
            if x <= root then
                x :: sieve (List.filter (not << multipleOf x) xs) root
            else
                list


multipleOf : Int -> Int -> Bool
multipleOf a n =
    n % a == 0


main : Html msg
main =
    Html.text <| toString <| primesRange 15 100
