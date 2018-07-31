module Model.Tab exposing (..)

type alias Tab  = 
    {
        title : String,
        count : Int
    }

type alias TabData =
    {
        tabs: List Tab,
        selectedTab: String
    }

setSelectedTab: String -> TabData -> TabData
setSelectedTab newSelectedTab tabData =
    { tabData | selectedTab = newSelectedTab}