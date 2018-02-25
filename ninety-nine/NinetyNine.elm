module NinetyNine
    exposing
        ( last
        , penultimate
        , elementAt
        , countElements
        , reverse
        , isPalindrome
        , flatten
        , noDupes
        , dropWhile
        , takeWhile
        , pack
        )


type NestedList a
    = Elem a
    | SubList (List (NestedList a))


type RleCode a
    = Run Int a
    | Single a


last : List a -> Maybe a
last =
    List.foldl (Just >> always) Nothing


penultimate : List a -> Maybe a
penultimate list =
    case (List.reverse >> List.drop 1) list of
        [] ->
            Nothing

        x ->
            List.head x


elementAt : List a -> Int -> Maybe a
elementAt list n =
    case list of
        [] ->
            Nothing

        x :: xs ->
            if n == 1 then
                Just x
            else
                elementAt xs (n - 1)


countElements : List a -> Int
countElements =
    List.sum << List.map (always 1)


reverse : List a -> List a
reverse list =
    case list of
        [] ->
            []

        x :: xs ->
            myReverse xs ++ [ x ]


isPalindrome : List a -> Bool
isPalindrome xs =
    let
        a =
            (//) (List.length xs) 2
    in
        List.take a xs == List.take a (List.reverse xs)


flatten : NestedList a -> List a
flatten nl =
    case nl of
        Elem n ->
            [ n ]

        SubList list ->
            List.concatMap flatten list


noDupes : List a -> List a
noDupes list =
    case list of
        [] ->
            []

        x :: xs ->
            x :: (noDupes <| dropWhile (\n -> n == x) xs)


dropWhile : (a -> Bool) -> List a -> List a
dropWhile predicate list =
    case list of
        [] ->
            []

        x :: xs ->
            if predicate x then
                dropWhile predicate xs
            else
                list


takeWhile : (a -> Bool) -> List a -> List a
takeWhile predicate list =
    case list of
        [] ->
            []

        x :: xs ->
            if predicate x then
                x :: (takeWhile predicate xs)
            else
                []


pack : List a -> List (List a)
pack xs =
    case xs of
        [] ->
            []

        head :: tail ->
            let
                remainder =
                    dropWhile (\x -> x == head) tail
            in
                takeWhile (\x -> x == head) xs :: pack remainder


runLengths : List (List a) -> List ( Int, a )
runLengths xss =
    List.map (\list -> ( List.length list, List.head list )) xss |> removeNothings


removeNothings : List ( Int, Maybe a ) -> List ( Int, a )
removeNothings list =
    case list of
        [] ->
            []

        ( count, Nothing ) :: tail ->
            removeNothings tail

        ( count, Just x ) :: tail ->
            ( count, x ) :: removeNothings tail


rleEncode : List a -> List (RleCode a)
rleEncode list =
    let
        converter ( len, a ) =
            case len of
                1 ->
                    Single a

                _ ->
                    Run len a
    in
        List.map converter (list |> pack |> runLengths)


rleDecode : List (RleCode a) -> List a
rleDecode =
    let
        unpack rlecode =
            case rlecode of
                Single x ->
                    [ x ]

                Run len x ->
                    List.repeat len x
    in
        List.concatMap unpack


duplicate : List a -> List a
duplicate =
    rleDecode << List.map (Run 2)
