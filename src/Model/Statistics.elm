module Model.Statistics exposing (..)
import Model.Misc exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)

type alias StatisticsData = 
    {
        status: RequestState,
        error: String,
        data: Statistics
    }

type alias Statistics = 
    {
        date: String,
        release: String,
        overview: StatisticsOverview
    }

type alias StatisticsOverview = 
    {
        substrates_protein : Int,
        substrates_proteoform: Int,
        sites: Int,
        enzymes: Int,
        enzyme_substrate_pairs: Int,
        enzyme_substrate_site: Int,
        ptm_dependent_ppi: Int,
        pmids: Int
    }

initialModel: Statistics
initialModel = 
    {
        date = "",
        release = "",
        overview = {
            substrates_protein  = 0,
            substrates_proteoform = 0,
            sites = 0,
            enzymes = 0,
            enzyme_substrate_pairs = 0,
            enzyme_substrate_site = 0,
            ptm_dependent_ppi = 0,
            pmids = 0
        }
    }

statisticsDecoder: Decoder Statistics
statisticsDecoder =
    decode Statistics
    |> required "date" string
    |> required "release" string
    |> required "overview" statisticsOverviewDecoder

statisticsOverviewDecoder: Decoder StatisticsOverview
statisticsOverviewDecoder =
    decode StatisticsOverview
    |> required "Substrates (protein)" int
    |> required "Substrates (proteoforms)" int
    |> required "Sites" int
    |> required "Enzymes" int
    |> required "Enzyme-substrate pairs" int
    |> required "Enzyme-substrate-site" int
    |> required "PTM-dependent PPI" int
    |> required "PMIDs" int