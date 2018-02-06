module Sqrt exposing (sqrt)

import Html exposing (text)


until : (a -> Bool) -> (a -> a) -> a -> a
until p f x =
    if p x then
        x
    else
        until p f (x |> f)


sqrt : Float -> Float
sqrt n =
    let
        eps =
            1.0e-7

        goodenough x =
            abs (x * x - n) < eps * x

        improve x =
            (x + n / x) / 2
    in
    until goodenough improve n


main =
    10
        |> sqrt
        |> toString
        |> text
