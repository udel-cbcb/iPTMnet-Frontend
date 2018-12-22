import { EntryAction } from "./EntryActions";
import { HomePageAction } from "./HomePageActions";
import { SearchResultsAction } from "./SearchResultsActions";
import { IBatchAction } from "./BatchActions";

export type Action = EntryAction
                    | HomePageAction
                    | SearchResultsAction
                    | IBatchAction
