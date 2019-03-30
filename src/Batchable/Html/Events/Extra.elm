module Batchable.Html.Events.Extra exposing
    ( charCode
    , targetValueFloat, targetValueInt, targetValueMaybe, targetValueMaybeFloat, targetValueMaybeInt
    , targetValueFloatParse, targetValueIntParse, targetValueMaybeFloatParse, targetValueMaybeIntParse
    , targetSelectedIndex
    , onClickPreventDefault, onClickStopPropagation, onClickPreventDefaultAndStopPropagation, onEnter, onChange
    )

{-| Additional decoders for use with event handlers in html.


# Event decoders

  - TODO: `key`

  - TODO: `code`

  - TODO: `KeyEvent`, `keyEvent`

@docs charCode


# Typed event decoders

@docs targetValueFloat, targetValueInt, targetValueMaybe, targetValueMaybeFloat, targetValueMaybeInt
@docs targetValueFloatParse, targetValueIntParse, targetValueMaybeFloatParse, targetValueMaybeIntParse
@docs targetSelectedIndex


# Event Handlers

@docs onClickPreventDefault, onClickStopPropagation, onClickPreventDefaultAndStopPropagation, onEnter, onChange

-}

import Batchable.Html exposing (Attribute)
import Html
import Html.Events.Extra as Extra
import Json.Decode as Json



-- TODO
-- {-| Decode the key that was pressed.
-- The key attribute is intended for users who are interested in the meaning of the key being pressed, taking into account the current keyboard layout.
--
-- * If there exists an appropriate character in the [key values set](http://www.w3.org/TR/DOM-Level-3-Events-key/#key-value-tables), this will be the result. See also [MDN key values](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent.key#Key_values).
-- * If the value is has a printed representation, it will be a non-empty Unicode character string consisting of the char value.
-- * If more than one key is being pressed and the key combination includes modifier keys (e.g. `Control + a`), then the key value will still consist of the printable char value with no modifier keys except for 'Shift' and 'AltGr' applied.
-- * Otherwise the value will be `"Unidentified"`
--
-- Note that `keyCode`, `charCode` and `which` are all being deprecated. You should avoid using these in favour of `key` and `code`.
-- Google Chrome and Safari currently support this as `keyIdentifier` which is defined in the old draft of DOM Level 3 Events.
--
-- -}
-- key : Json.Decoder String
-- key = Json.oneOf [ Json.field "key" string, Json.field "keyIdentifier" string ]
-- TODO: Waiting for proper support in chrome & safari
-- {-| Return a string identifying the key that was pressed.
-- `keyCode`, `charCode` and `which` are all being deprecated. You should avoid using these in favour of `key` and `code`.
-- See [KeyboardEvent.keyCode](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent.keyCode).
-- -}
-- code : Json.Decoder String
-- code =
--     Json.field "code" string
-- TODO: Complete keyboard event
-- keyEvent : Json.Decoder KeyEvent
-- keyEvent =
--     Json.oneOf [ Json.field "keyCode" int ]


{-| Character code for key board events.
This is being deprecated, but support for DOM3 Keyboard events is not yet present in most browsers.
-}
charCode : Json.Decoder (Maybe Char)
charCode =
    Extra.charCode


{-| Floating-point target value.
-}
targetValueFloat : Json.Decoder Float
targetValueFloat =
    Extra.targetValueFloat


{-| Integer target value.
-}
targetValueInt : Json.Decoder Int
targetValueInt =
    Extra.targetValueInt


{-| String or empty target value.
-}
targetValueMaybe : Json.Decoder (Maybe String)
targetValueMaybe =
    Extra.targetValueMaybe


{-| Floating-point or empty target value.
-}
targetValueMaybeFloat : Json.Decoder (Maybe Float)
targetValueMaybeFloat =
    Extra.targetValueMaybeFloat


{-| Integer or empty target value.
-}
targetValueMaybeInt : Json.Decoder (Maybe Int)
targetValueMaybeInt =
    Extra.targetValueMaybeInt


{-| Parse a floating-point value from the input instead of using `valueAsNumber`.
Use this with inputs that do not have a `number` type.
-}
targetValueFloatParse : Json.Decoder Float
targetValueFloatParse =
    Extra.targetValueFloatParse


{-| Parse an integer value from the input instead of using `valueAsNumber`.
Use this with inputs that do not have a `number` type.
-}
targetValueIntParse : Json.Decoder Int
targetValueIntParse =
    Extra.targetValueIntParse


{-| Parse an optional floating-point value from the input instead of using `valueAsNumber`.
Use this with inputs that do not have a `number` type.
-}
targetValueMaybeFloatParse : Json.Decoder (Maybe Float)
targetValueMaybeFloatParse =
    Extra.targetValueMaybeFloatParse


{-| Parse an optional integer value from the input instead of using `valueAsNumber`.
Use this with inputs that do not have a `number` type.
-}
targetValueMaybeIntParse : Json.Decoder (Maybe Int)
targetValueMaybeIntParse =
    Extra.targetValueMaybeIntParse


{-| Parse the index of the selected option of a select.
Returns Nothing in place of the spec's magic value -1.
-}
targetSelectedIndex : Json.Decoder (Maybe Int)
targetSelectedIndex =
    Extra.targetSelectedIndex



-- Event Handlers


{-| Always send `msg` upon click, preventing the browser's default behavior.
-}
onClickPreventDefault : msg -> Attribute msg
onClickPreventDefault =
    lift Extra.onClickPreventDefault


{-| Always send `msg` upon click, preventing click propagation.
-}
onClickStopPropagation : msg -> Attribute msg
onClickStopPropagation =
    lift Extra.onClickStopPropagation


{-| Always send `msg` upon click, preventing the browser's default behavior and propagation
-}
onClickPreventDefaultAndStopPropagation : msg -> Attribute msg
onClickPreventDefaultAndStopPropagation =
    lift Extra.onClickPreventDefaultAndStopPropagation


{-| When the enter key is released, send the `msg`.
Otherwise, do nothing.
-}
onEnter : msg -> Attribute msg
onEnter =
    lift Extra.onEnter


{-| An HTML Event attribute that passes the `event.target.value` to a `msg`
constructor when an `input`, `select`, or `textarea` element has changed.
-}
onChange : (String -> msg) -> Attribute msg
onChange =
    lift Extra.onChange



-- Helper functions


lift : (a -> Html.Attribute msg) -> a -> Attribute msg
lift f a =
    Batchable.Html.fromAttributes [ f a ]
