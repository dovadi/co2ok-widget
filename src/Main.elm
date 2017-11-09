import Color
import Element exposing (..)
import Element.Attributes exposing (..)
import Html exposing (Html, div)
-- import Html.Events exposing (onClick)
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font
import Style.Transition as Transition

(=>) =
    (,)

type Styles
    = None
    | Container
    | Label
    | Main
    | Box

sansSerif =
    [ Font.font "helvetica"
    , Font.font "arial"
    , Font.font "sans-serif"
    ]

stylesheet : StyleSheet Styles variation
stylesheet =
    Style.styleSheet
        [ style None [] -- It's handy to have a blank style
        , style Main 
            [ Border.all 9 -- set all border widths to 9 px.
            , Color.text Color.darkCharcoal
            , Color.background Color.white
            , Color.border Color.lightGrey
            , Font.typeface sansSerif
            , Font.size 23
            , Font.lineHeight 1.3 -- line height, given as a ratio of current font size.
            ]
        , style Container []
        , style Label []
        , style Box
            [ Transition.all
            , Color.text Color.green
            , Color.background Color.white
            , Color.border Color.yellow
            , Border.rounded 9 -- round all borders to 3px
            , hover
                [ Color.text Color.white
                , Color.background Color.green
                , Color.border Color.green
                , cursor "pointer"
                ]
            ]
        ]


main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }


-- MODEL


type alias Model = {
  enabled : Bool,
  amount : Float
}


model : Model
model = 
  Model False 0

-- UPDATE


type Msg
  = Compensate


update : Msg -> Model -> Model
update msg model =
  case msg of
    Compensate ->
      { model | enabled = True }


-- VIEW


view _ =
    Element.layout stylesheet <|
        column None
            []
            [ el None [ center, width (px 800) ] <|
                column Main
                    [ spacing 50, paddingTop 50, paddingBottom 50 ]
                    (List.concat
                        [ viewBoxLayout
                        ]
                    )
            ]

viewBoxLayout =
    [ el Label [] (text "CO₂ compensatie")
    , namedGrid Container
        []
        { columns = [ px 200, px 200, px 20, fill ]
        , rows =
            [ px 42 => [ span 3 "content", span 1 "sidebar" ]
            , px 42 => [ span 3 "content2", span 1 "sidebar" ]
            ]
        , cells =
          [ named "content2"
            (el Box [] (text "info"))
              -- button [ onClick Compensate ] [ text "Make CO2ok" ]
          , named "content"
            (full Box [] (text "Make CO₂ok"))
          ]
        }
    ]




-- view : Model -> Html Msg
-- view _ =
--   [el Box
--     [ button [ onClick Compensate ] [ text "Make CO2ok" ]
--   ]
--   ]
