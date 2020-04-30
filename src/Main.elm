module Main exposing (main)

import Browser
import Decrement
import Html exposing (..)
import Html.Events as Events
import Increment
import Json.Encode



-- MAIN


main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }



-- MODEL


type Model
    = IModel Increment.Model
    | DModel Decrement.Model


init : () -> ( Model, Cmd msg )
init _ =
    let
        ( m, c ) =
            Increment.init ()
    in
    ( IModel m, c )



-- UPDATE


type Msg
    = IMsg Increment.Msg
    | DMsg Decrement.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( IMsg Increment.MoveToDecrementPage, IModel (Increment.AtIncrementPage val) ) ->
            ( DModel (Decrement.AtDecrementPage val), Cmd.none )

        ( DMsg Decrement.MoveToIncrementPage, DModel (Decrement.AtDecrementPage val) ) ->
            ( IModel (Increment.AtIncrementPage val), Cmd.none )

        ( IMsg iMsg, IModel iModel ) ->
            let
                ( newIModel, newCmd ) =
                    Increment.update iMsg iModel
            in
            ( IModel newIModel, Cmd.map IMsg newCmd )

        ( DMsg dMsg, DModel dModel ) ->
            let
                ( newModel, newCmd ) =
                    Decrement.update dMsg dModel
            in
            ( DModel newModel, Cmd.map DMsg newCmd )

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
        IModel iModel ->
            Increment.view iModel
                |> Html.map IMsg

        DModel dModel ->
            Decrement.view dModel
                |> Html.map DMsg
