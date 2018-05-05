module Entry exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (..)
import Model exposing (..)
import Msgs exposing (..)
import Views.Info
import Views.Sequence
import Views.Substrate
import Views.Proteoforms
import Views.PTMDependentPPI
import Views.ProteoformPPI

view : Model -> Html Msg
view model =  
            div [id "page",css [
            Css.property "height" "100%",
            displayFlex,
            flexDirection row,
            flex (num 1)
            ]
        ] [
            div [id "sidebar", css [
                displayFlex,
                flexDirection column,
                alignItems center,
                backgroundColor (hex "ecececff"),
                flex (num 1)
            ]][
                text "Display"
            ],
            div [id "content", css [
                displayFlex,
                flexDirection column,
                flex (num 4),
                paddingLeft (px 40),
                paddingRight (px 40)
            ]][
                Views.Info.view model.entryPage.infoData,
                Views.Sequence.view,
                Views.Substrate.view model.entryPage.substrateData model.entryPage.infoData.data.uniprot_ac model.entryPage.infoData.data.gene_name ,
                Views.Proteoforms.view model.entryPage.proteoformsData,
                Views.PTMDependentPPI.view model.entryPage.ptmDependentPPIData,
                Views.ProteoformPPI.view model.entryPage.proteoformPPIData
            ]
        ]






