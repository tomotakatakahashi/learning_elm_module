port module Decrement exposing (..)

import Browser
import Html exposing (..)
import Html.Events as Events


port decrementPort : String -> Cmd msg



-- MAIN


main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }



-- MODEL


type Model
    = AtDecrementPage Int
    | ToIncrementPage Int


init : () -> ( Model, Cmd msg )
init _ =
    ( AtDecrementPage 0, Cmd.none )



-- UPDATE


type Msg
    = Decrement
    | MoveToIncrementPage


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( Decrement, AtDecrementPage val ) ->
            ( AtDecrementPage (val - 1), decrementPort "Decrementing..." )

        ( MoveToIncrementPage, AtDecrementPage val ) ->
            ( ToIncrementPage val, Cmd.none )

        _ ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    case model of
        AtDecrementPage val ->
            div []
                [ h1 [] [ text "Decrement page" ]
                , button [ Events.onClick Decrement ] [ text "-" ]
                , div [] [ text (String.fromInt val) ]
                , button [ Events.onClick MoveToIncrementPage ] [ text "Move" ]
                ]

        ToIncrementPage val ->
            div []
                [ text "Moving to Increment page..." ]
