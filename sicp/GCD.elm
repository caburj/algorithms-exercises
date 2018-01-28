module FastExp exposing (..)

import Html exposing (text)


gcd a b =
    if b == 0 then
        a
    else
        gcd b (a % b)


main =
    gcd 40 6560
        |> toString
        |> text
