module Model.StatisticsPage exposing (..)
import Model.Statistics exposing (..)
import Model.Misc exposing (..)

type alias StatisticsPage = 
    {
        statisticsData : StatisticsData
    }

setStatistics : StatisticsPage -> StatisticsData -> StatisticsPage
setStatistics statisticsPage newStatistics = 
    {statisticsPage | statisticsData = newStatistics}

initialModel : StatisticsPage
initialModel = 
    {
        statisticsData = {
            status = NotAsked,
            error = "",
            data = Model.Statistics.initialModel
        }
    }
    
