module Problem41 exposing (goldbachGT)

import Html
import List
import Problem40 exposing (goldbach)


goldbachGT : Int -> Int -> Int -> List ( Int, Int )
goldbachGT low high limit =
    if low > high then
        []
    else
        let
            evens =
                List.filter (\n -> n % 2 == 0) (List.range low high)

            goldbachs =
                List.map goldbach evens

            qualifier maybe =
                case maybe of
                    Nothing ->
                        False

                    Just ( a, b ) ->
                        if a > limit then
                            True
                        else
                            False

            noMaybe maybe =
                case maybe of
                    Nothing ->
                        ( -999, -999 )

                    Just ( a, b ) ->
                        ( a, b )
        in
            List.map noMaybe (List.filter qualifier goldbachs)



--main =
--    Html.text <| toString (goldbachGT 1 2000 50)


main =
    Html.text
        (if (test) then
            "Your implementation passed all tests."
         else
            "Your implementation failed at least one test."
        )


test : Bool
test =
    List.all ((==) True)
        [ goldbachGT 1 2000 50 == [ ( 73, 919 ), ( 61, 1321 ), ( 67, 1789 ), ( 61, 1867 ) ]
        , goldbachGT (73 + 919) (73 + 919) 50 == [ ( 73, 919 ) ]
        , goldbachGT 1 1000 80 == []
        , goldbachGT 1 200 12 == [ ( 19, 79 ), ( 13, 109 ), ( 13, 113 ), ( 19, 109 ) ]
        ]
