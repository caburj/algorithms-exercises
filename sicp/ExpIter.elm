module Main exposing (..)

import Html exposing (text)


expt b n =
    if n == 0 then
        1
    else
        exp_iter b n 1 b


exp_iter b n x y =
    if n == 1 then
        x * y
    else if isEven n then
        exp_iter b (n / 2) x (y * y)
    else
        exp_iter b (n - 1) (b * x) y


isEven n =
    n / 2 == 0


main =
    expt 2 10
        |> toString
        |> text
