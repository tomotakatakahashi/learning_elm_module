port module Increment exposing (..)

import Browser
import Html exposing (..)
import Html.Events as Events


port incrementPort : String -> Cmd msg



-- MAIN


main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }



-- MODEL


type Model
    = AtIncrementPage Int
    | ToDecrementPage Int


init : () -> ( Model, Cmd msg )
init _ =
    ( AtIncrementPage 0, Cmd.none )



-- UPDATE


type Msg
    = Increment
    | MoveToDecrementPage


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( Increment, AtIncrementPage val ) ->
            ( AtIncrementPage (val + 1), incrementPort "Incrementing..." )

        ( MoveToDecrementPage, AtIncrementPage val ) ->
            ( ToDecrementPage val, Cmd.none )

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
        AtIncrementPage val ->
            div []
                [ h1 [] [ text "Increment page" ]
                , button [ Events.onClick Increment ] [ text "+" ]
                , div [] [ text (String.fromInt val) ]
                , button [ Events.onClick MoveToDecrementPage ] [ text "Move" ]
                ]

        ToDecrementPage val ->
            div []
                [ text "Moving to Decrement page..." ]
