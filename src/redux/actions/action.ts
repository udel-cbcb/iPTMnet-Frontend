import { EntryAction } from "./EntryActions";
import { HomePageAction } from "./HomePageActions";
import { SearchResultsAction } from "./SearchResultsActions";

export type Action = EntryAction
                    | HomePageAction
                    | SearchResultsAction
