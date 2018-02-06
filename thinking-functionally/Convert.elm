module Convert exposing (..)

import Array
import Html exposing (text)


(!!) list index =
    case Array.get index (list |> Array.fromList) of
        Nothing ->
            ""

        Just x ->
            x


units =
    [ "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" ]


teens =
    [ "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen" ]


tens =
    [ "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety" ]


convert1 n =
    units !! n


convert2 n =
    let
        ( t, u ) =
            ( n // 10, n % 10 )
    in
    if t == 0 then
        convert1 u
    else if t == 1 then
        teens !! u
    else if u == 0 then
        tens !! (t - 2)
    else
        tens !! (t - 2) ++ " " ++ convert1 u


convert3 n =
    let
        ( h, t ) =
            ( n // 100, n % 100 )
    in
    if h == 0 then
        convert2 t
    else
        convert1 h ++ " hundred " ++ convert2 t


convert4 n =
    let
        ( t, h ) =
            ( n // 1000, n % 1000 )
    in
    if t == 0 then
        convert3 h
    else
        convert3 t ++ " thousand " ++ link t ++ convert3 h


link t =
    if t > 99 then
        "and "
    else
        ""


convert =
    convert4


main =
    text (convert 99464)
