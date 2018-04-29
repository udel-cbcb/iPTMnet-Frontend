module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Model exposing (Info)
import RemoteData

fetchInfo: Cmd Msg
fetchInfo = 
    Http.get fetchInfoUrl infoDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchInfo

fetchInfoUrl : String
fetchInfoUrl =
    "http://aws3.proteininformationresource.org/Q15796/info"

infoDecoder: Decode.Decoder Info
infoDecoder =
    decode Info
        |> required "uniprot_ac" Decode.string