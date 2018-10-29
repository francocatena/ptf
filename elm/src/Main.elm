module Main exposing (init)

import Browser
import Html exposing (Html, a, button, div, form, h2, i, input, p, section, span, text)
import Html.Attributes exposing (autocomplete, autofocus, class, href, name, placeholder, type_, value)
import Html.Events exposing (onInput)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { email : String
    , password : String
    }


init : Model
init =
    Model "" ""



-- UPDATE


type Msg
    = Email String
    | Password String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Email email ->
            { model | email = email }

        Password password ->
            { model | password = password }



-- VIEW


viewField : Html msg -> Html msg
viewField field =
    div [ class "field" ] [ field ]


viewIcon : String -> Html msg
viewIcon iconClasses =
    span
        [ class "icon is-left" ]
        [ i
            [ class iconClasses ]
            []
        ]


view : Model -> Html Msg
view model =
    let
        viewEmailInput : Html Msg
        viewEmailInput =
            viewField
                (div
                    [ class "control has-icons-left" ]
                    [ input
                        [ class "input is-medium"
                        , type_ "email"
                        , name "email"
                        , value model.email
                        , autocomplete False
                        , placeholder "Email"
                        , autofocus True
                        , onInput Email
                        ]
                        []
                    , viewIcon "fas fa-envelope"
                    ]
                )

        viewPasswordInput : Html Msg
        viewPasswordInput =
            viewField
                (div
                    [ class "control has-icons-left" ]
                    [ input
                        [ class "input is-medium"
                        , type_ "password"
                        , name "password"
                        , value model.password
                        , placeholder "Password"
                        , onInput Password
                        ]
                        []
                    , viewIcon "fas fa-lock"
                    ]
                )

        viewSubmitButton : Html Msg
        viewSubmitButton =
            viewField
                (p
                    [ class "control has-text-centered" ]
                    [ button
                        [ class "button is-dark is-medium", type_ "button" ]
                        [ text "Login" ]
                    ]
                )

        viewLoginBox : Html Msg
        viewLoginBox =
            div
                [ class "box" ]
                [ h2
                    [ class "title is-4 has-text-grey" ]
                    [ text "Log in" ]
                , form
                    []
                    [ viewEmailInput
                    , viewPasswordInput
                    , viewSubmitButton
                    ]
                ]

        viewLoginLinks : Html Msg
        viewLoginLinks =
            p
                []
                [ a
                    [ href "#/passwords/new" ]
                    [ text "Forgot password?" ]
                ]
    in
    section
        [ class "hero is-light is-fullheight" ]
        [ div
            [ class "hero-body" ]
            [ div
                [ class "container has-text-centered" ]
                [ div
                    [ class "columns" ]
                    [ div
                        [ class "column is-half is-offset-one-quarter" ]
                        [ viewLoginBox
                        , viewLoginLinks
                        ]
                    ]
                ]
            ]
        ]
