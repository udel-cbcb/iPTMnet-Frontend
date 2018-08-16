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
import { RequestState } from "../redux/states/RequestState";
import SearchResult from "src/models/SearchResult";
import { highLight } from "../misc/Utils";

minify(false);

interface ISearchResultsProp{
  searchTerm: string,
  searchResults: SearchResultState,
  selectedPage: number
}

class SearchResults extends React.Component<ISearchResultsProp,{}>  {

    constructor(props: ISearchResultsProp){
      super(props)
    }

    public render() {
        
        let body;
        if(this.props.searchResults.status === RequestState.ERROR){
          body = this.renderError(this.props.searchResults.error)
        }else if(this.props.searchResults.status === RequestState.LOADING){
          body = this.renderLoading();
        }else if(this.props.searchResults.status === RequestState.SUCCESS){
          body = this.renderSearchResults(this.props.searchResults.data.searchResults,
                                          this.props.searchResults.data.totalCount,
                                          this.props.selectedPage,
                                          this.props.searchTerm);
        }else{
          body = (<div>
            Not asked
          </div>)
        }

        return (
            <div id="div_page" className={css(CommonStyles.page)} >
        
            <div id="div_header" className={css(CommonStyles.header)} >
              <Navbar/>
            </div>

            {body}

            <Footer />
                     
          </div>
        );
    }

    private renderError(errorMsg: string){
      return (
        <div>
          {errorMsg}
        </div>
      )
    }

    private renderLoading(){
      return (
        <div>
          Loading
        </div>
      )
    }

    private renderSearchResults = (searchResults: SearchResult[], totalCount: number, selectedPage: number, searchTerm: string) => {
      highLight(searchTerm,"div_search_table")
      const tableRows = searchResults.map(this.renderRow)
      
      return (     
        <div id="div_body" className={css(styles.body)} >
              <div id="div_search_results_stats" className={css(styles.searchResultStats)} >

                <div style={{alignSelf: "center", maxHeight: "fit-content",marginLeft: 10}} >
                  Showing results for :  
                </div>

                <div style={{alignSelf: "center",
                             maxHeight: "fit-content",
                             marginLeft:10,
                             fontWeight: "bold"
                             }} >
                  {searchTerm}
                </div>

                <div id="pagination_container" style={{marginLeft:"auto",marginRight:20}} >
                  <Pagination
                    activePage={selectedPage}
                    itemsCountPerPage={28}
                    totalItemsCount={totalCount}
                    pageRangeDisplayed={5}
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
                                  
              <div id="div_search_table" className={css(styles.searchTable)} >
                   <div className={css(styles.searchResultHeader)} >
                     <div className={css(styles.iptm_id)} >
                        <input type="checkbox" style={{marginLeft: 10,marginRight: 10}}  />
                        iPTM ID
                     </div>

                     <div className={css(styles.protein_name)} >
                      Protein Name
                     </div>
                     
                     <div className={css(styles.gene_name)} >
                      Gene Name
                     </div>
                     
                     <div className={css(styles.organism)} >
                      Organism
                     </div>
                     
                     <div className={css(styles.substrate_role)} >
                      Substrate Role
                     </div>
                     
                     <div className={css(styles.enzyme_role)} >
                      Enzyme Role
                     </div>
                     
                     <div className={css(styles.ptm_dependent_ppi)} >
                      PTM-dependent PPI
                     </div>
                     
                     <div className={css(styles.sites)} >
                      Sites
                     </div>
                     
                     <div className={css(styles.isoforms)} >
                      Isoforms
                     </div>

                   </div>
                   {tableRows} 
              </div>
    
              <div id="filer" className={css(CommonStyles.filer)} />
        </div>
    
      )
    }

    private renderRow(searchResult: SearchResult) {
        return (
          <div className={css(styles.searchResultRow)} >
                     <div className={css(styles.iptm_id)} >
                        <input type="checkbox" style={{marginLeft: 10,marginRight: 10}}  />
                        {searchResult.iptm_id}
                     </div>

                     <div className={css(styles.protein_name)} >
                        {searchResult.protein_name}
                     </div>
                     
                     <div className={css(styles.gene_name)} >
                        {searchResult.gene_name}
                     </div>
                     
                     <div className={css(styles.organism)} >
                        {searchResult.organism.common_name}
                     </div>
                     
                     <div className={css(styles.substrate_role)} >
                        {searchResult.substrate_role}
                     </div>
                     
                     <div className={css(styles.enzyme_role)} >
                        {searchResult.enzyme_role}
                     </div>
                     
                     <div className={css(styles.ptm_dependent_ppi)} >
                          PTM-dependent PPI
                     </div>
                     
                     <div className={css(styles.sites)} >
                        {searchResult.sites}
                     </div>
                     
                     <div className={css(styles.isoforms)} >
                        {searchResult.isoforms}
                     </div>

          </div>
        )
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
      flexDirection: "row",
      alignitems: "center"
    },

    searchTable: {
      display: "flex",
      flexDirection: "column",
      marginTop: 10
    },

    searchResultHeader: {
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      marginBottom: 5,
      fontWeight: "bold"
    },

    searchResultRow: {
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      paddingTop: 10,
      paddingBottom: 10,
      fontSize: "0.9em",
      ":hover": {
        backgroundColor: "#ededed"
      }
    },

    iptm_id: {
      display: "flex",
      flexDirection: "row",
      flex: 2 
    },

    protein_name: {
      flex: 2,
      marginRight: 10,
      marginLeft: 8
    },

    gene_name: {
      flex: 2,
      marginRight: 10,
      marginLeft: 8
    },

    organism: {
      flex: 1.5,
      marginRight: "20",
      paddingLeft: "5"
    },

    substrate_role: {
      flex: 1,
      marginRight: 20,
      paddingLeft: 10
    },

    enzyme_role: {
      flex: 1,
      marginRight: 20,
    },

    ptm_dependent_ppi: {
      flex: 1.5,
      marginRight: 20,
    },

    sites: {
      flex: 0.5,
      marginRight: 20,
    },

    isoforms: {
      flex: 0.5,
      marginRight: 20,
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
  searchTerm: state.searchResultPage.searchTerm,
  searchResults: state.searchResultPage.searchResultData,
  selectedPage: state.searchResultPage.selectedPage
});

const mapDispatchToProps = (dispatch: Dispatch) => bindActionCreators({}, dispatch);

export const SearchResultsConnected = connect(mapStateToProps, mapDispatchToProps)(SearchResults);

export default SearchResults;