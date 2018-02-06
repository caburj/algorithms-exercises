module MergeSort exposing (sort)

import Html exposing (text)
import List


sort : List comparable -> List comparable
sort list =
    case list of
        [] ->
            []

        [ x ] ->
            [ x ]

        _ ->
            let
                ( xs, ys ) =
                    partition list
            in
            merge (sort xs) (sort ys)


partition : List comparable -> ( List comparable, List comparable )
partition list =
    let
        n =
            (list |> List.length) // 2
    in
    ( List.take n list, List.drop n list )


merge : List comparable -> List comparable -> List comparable
merge l1 l2 =
    case ( l1, l2 ) of
        ( [], _ ) ->
            l2

        ( _, [] ) ->
            l1

        ( x :: xs, y :: ys ) ->
            if x < y then
                x :: merge xs l2
            else
                y :: merge l1 ys


main =
    [ 1, 4, 5, 2, 4, 6, 8, 10, 18, 12, 1, 0 ]
        |> sort
        |> toString
        |> text
