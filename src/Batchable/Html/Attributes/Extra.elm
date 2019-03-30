module Batchable.Html.Attributes.Extra exposing
    ( static
    , valueAsFloat, valueAsInt
    , role
    , low, high, optimum
    , volume
    , stringProperty
    , boolProperty
    , floatProperty
    , intProperty
    )

{-| Additional attributes for html


# Embedding static attributes

@docs static


# Inputs

@docs valueAsFloat, valueAsInt


# Semantic web

@docs role


# Meter element

@docs low, high, optimum


# Media element

@docs volume


# Custom Attributes

@docs stringProperty
@docs boolProperty
@docs floatProperty
@docs intProperty

-}

import Batchable.Html exposing (Attribute)
import Html
import Html.Attributes.Extra as Extra


{-| Embedding static attributes.

Works alike to [`Html.Extra.static`](Html-Extra#static).

-}
static : Attribute Never -> Attribute msg
static attrs =
    Batchable.Html.fromAttributes <|
        List.map Extra.static <|
            Batchable.Html.toAttributes attrs


{-| Create arbitrary string _properties_.
-}
stringProperty : String -> String -> Attribute msg
stringProperty =
    lift2 Extra.stringProperty


{-| Create arbitrary bool _properties_.
-}
boolProperty : String -> Bool -> Attribute msg
boolProperty =
    lift2 Extra.boolProperty


{-| Create arbitrary floating-point _properties_.
-}
floatProperty : String -> Float -> Attribute msg
floatProperty =
    lift2 Extra.floatProperty


{-| Create arbitrary integer _properties_.
-}
intProperty : String -> Int -> Attribute msg
intProperty =
    lift2 Extra.intProperty


{-| Uses `valueAsNumber` to update an input with a floating-point value.
This should only be used on &lt;input&gt; of type `number`, `range`, or `date`.
It differs from `value` in that a floating point value will not necessarily overwrite the contents on an input element.

    valueAsFloat 2.5 -- e.g. will not change the displayed value for input showing "2.5000"

    valueAsFloat 0.4 -- e.g. will not change the displayed value for input showing ".4"

-}
valueAsFloat : Float -> Attribute msg
valueAsFloat =
    lift Extra.valueAsFloat


{-| Uses `valueAsNumber` to update an input with an integer value.
This should only be used on &lt;input&gt; of type `number`, `range`, or `date`.
It differs from `value` in that an integer value will not necessarily overwrite the contents on an input element.

    valueAsInt 18 -- e.g. will not change the displayed value for input showing "00018"

-}
valueAsInt : Int -> Attribute msg
valueAsInt =
    lift Extra.valueAsInt


{-| Used to annotate markup languages with machine-extractable semantic information about the purpose of an element.
See the [official specs](http://www.w3.org/TR/role-attribute/).
-}
role : String -> Attribute msg
role =
    lift Extra.role


{-| The upper numeric bound of the low end of the measured range, used with the meter element.
-}
low : String -> Attribute msg
low =
    lift Extra.low


{-| The lower numeric bound of the high end of the measured range, used with the meter element.
-}
high : String -> Attribute msg
high =
    lift Extra.high


{-| This attribute indicates the optimal numeric value, used with the meter element.
-}
optimum : String -> Attribute msg
optimum =
    lift Extra.optimum


{-| Audio volume, starting from 0.0 (silent) up to 1.0 (loudest).
-}
volume : Float -> Attribute msg
volume =
    lift Extra.volume



-- Helper functions


lift : (a -> Html.Attribute msg) -> a -> Attribute msg
lift f a =
    Batchable.Html.fromAttributes [ f a ]


lift2 : (a -> b -> Html.Attribute msg) -> a -> b -> Attribute msg
lift2 f a b =
    Batchable.Html.fromAttributes [ f a b ]
