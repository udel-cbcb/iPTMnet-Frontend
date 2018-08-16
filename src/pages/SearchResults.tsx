import * as React from "react";
import { css, minify, StyleSheet } from 'aphrodite';
import Navbar from "../views/Navbar";
import {CommonStyles} from "../misc/CommonStyles"
import Footer from "../views/Footer";
import Pagination from "react-js-pagination";
import { SearchResultState } from "../redux/states/SearchResultState";
import { State } from "src/redux/state";
import { bindActionCreators, Dispatch } from "redux";
import { connect } from "react-redux";

minify(false);

interface ISearchResultsProp{
  searchResults: SearchResultState,
  selectedPage: number
}

class SearchResults extends React.Component<ISearchResultsProp,{}>  {

    constructor(props: ISearchResultsProp){
      super(props)
    }

    public render() {

        

        return (
            <div id="div_page" className={css(CommonStyles.page)} >
        
            <div id="div_header" className={css(CommonStyles.header)} >
              <Navbar/>
            </div>
    
            <div id="div_body" className={css(styles.body)} >

              <div id="div_search_results_stats" className={css(styles.searchResultStats)} >
                <div id="pagination_container" style={{marginLeft:"auto",marginRight:20}} >
                  <Pagination
                    activePage={this.props.selectedPage}
                    itemsCountPerPage={28}
                    totalItemsCount={this.props.searchResults.data.length}
                    pageRangeDisplayed={10}
                    onChange={this.onSearchPageChange}
                    innerClass={css(styles.pagination_ul)}
                    itemClass={css(styles.pagination_li)}
                    linkClass={css(styles.pagination_a)}
                    prevPageText='prev'
                    nextPageText='next'
                    firstPageText='first'
                    lastPageText='last'   
                    />
                </div>
              </div>       
                                  
              <div id="div_search_results_container" >
                            
              </div>
    
              <div id="filer" className={css(CommonStyles.filer)} />
    
            </div>
    
            <Footer />
                     
          </div>
        );
    }

    private onSearchPageChange = (pageNumber: number) => {
        console.log("pageNumber: " + pageNumber)
    }

}

const styles = StyleSheet.create(
  {

    body: {
      display: "flex",
      flexDirection: "column",
      minWidth: "100%",
      maxWidth: "100%",
      "flex-grow": "1",
      paddingTop: "20",
      overflow: "auto"
    },

    searchResultStats: {
      display: "flex",
      flexDirection: "row"
    },

    pagination_ul : {
      display: "flex",
      flexDirection: "row",
      paddingLeft: 0,
      margin: "20px 0px",
      borderStyle: "solid",
      borderColor: "#c4c4c4",
      borderRadius: "5px",
      borderWidth: "1px",
      fontSize: "0.8em"
    },

    pagination_a : {
      ":link": {
        textDecoration: "none"
      }
    },

    pagination_li: {
      display: "inline",
      paddingTop: "10px",
      paddingLeft: "20px",
      paddingRight: "20px",
      paddingBottom: "10px",
      borderRightStyle: "solid",
      borderRightWidth: "1px",
      borderColor: "#c4c4c4"
    }
  }
)

const mapStateToProps = (state: State) => ({
  searchResults: state.searchResultPage.searchResultData,
  selectedPage: state.searchResultPage.selectedPage
});

const mapDispatchToProps = (dispatch: Dispatch) => bindActionCreators({}, dispatch);

export const SearchResultsConnected = connect(mapStateToProps, mapDispatchToProps)(SearchResults);

export default SearchResults;