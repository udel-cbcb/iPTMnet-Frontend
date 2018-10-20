import * as React from "react";
import { css, minify, StyleSheet } from 'aphrodite';
import Navbar from "../views/Navbar";
import Footer from "../views/Footer";
import Pagination from "react-js-pagination";
import { State } from "../redux/state";
import { bindActionCreators, Dispatch } from "redux";
import { connect } from "react-redux";
import { SearchPageState } from 'src/redux/states/SearchPageState';
import { SearchResultView } from "src/views/SearchResult";
import { parse,stringify } from "query-string";
import { highLight } from "../misc/Utils";

minify(false);

interface ISearchResultsProp{
  query: string;
  history: any;
}

class SearchResults extends React.Component<ISearchResultsProp,SearchPageState>  {

    constructor(props: ISearchResultsProp){
      super(props)
      this.state = new SearchPageState();
      this.state = this.updateStateFromProps(this.state,this.props);
    }

    public async componentWillReceiveProps(nextProps: ISearchResultsProp) {
      this.setState(this.updateStateFromProps(this.state,nextProps));
    }
 
    public updateStateFromProps = (prevState:SearchPageState, props: ISearchResultsProp) => {
      const state = {...prevState,
         search_term : this.extract_search_term(props.query),
         start_index: this.extract_start_index(props.query),
         end_index: this.extract_end_index(props.query)    
      }
     return state;
    }
   

    public render() {
        const page_indicator_info =  `${this.state.start_index + 1} - ${this.state.end_index} of ${this.state.count} results for ${this.state.search_term} in iPTMnet` 
        highLight(this.state.search_term,"div_search_table")
        return (
            <div id="page" className={css(styles.page)} >
            <Navbar/>
            <div id="body" className={css(styles.body)} >
                  
              <div id="content" className={css(styles.content)}  >
                    <div id="summary" className={css(styles.summary)} >
                        <div style={{marginRight:"auto"}} >
                            {page_indicator_info} 
                        </div>
                        <div id="pagination_container" style={{marginLeft:"auto",marginRight:20}} >
                        <Pagination
                        activePage={this.getActivePageNumber()}
                        itemsCountPerPage={28}
                        totalItemsCount={this.state.count}
                        pageRangeDisplayed={5}
                        onChange={this.onPageChange}
                        innerClass={css(styles.pagination_ul)}
                        itemClass={css(styles.pagination_li)}
                        linkClass={css(styles.pagination_a)}
                        activeClass={css(styles.pagination_active_li)}
                        activeLinkClass={css(styles.pagination_active_a)}
                        prevPageText='prev'
                        nextPageText='next'
                        firstPageText='first'
                        lastPageText='last'   
                        />
                        </div>
                    </div>
                    <SearchResultView query={this.props.query} isBrowse={false} onDataLoaded={this.onDataLoaded} />
              </div>        
              
            </div>
    
            <div id="filer" style={{minHeight: "50px"}} >
    
            </div>
    
            <Footer /> 
          </div>
        );
    }

    private onDataLoaded = (data_count: number) => {
      this.setState({...this.state,count: data_count})
    }

    private getActivePageNumber = () => {
      const active_page = this.state.end_index/20  
      return active_page;
    }

    private onPageChange = (pageNumber: number) => {
      const start_index = (pageNumber - 1) * 20 ;
      const end_index = start_index + 20;
      const query = this.build_query(this.props.query,start_index,end_index);
      const url = query;
      this.props.history.push(url);
    }

    private build_query = (prev_query: string, start_index: number, end_index: number) => {
      const parsed = parse(prev_query);
      parsed.start_index = String(start_index);
      parsed.end_index = String(end_index)
      console.log(start_index)
      console.log(end_index)
      return stringify(parsed);
    }

    private extract_start_index(query: string): number {
      const parsed = parse(query);
      const value = Number(parsed.start_index);
      if(isNaN(value)) {
          return 0
      }else{
          return value;
      }   
    }

    private extract_end_index(query: string): number {
      const parsed = parse(query);
      const value = Number(parsed.end_index);
      if(isNaN(value)) {
          return 0
      }else{
          return value;
      }    
    }

    private extract_search_term(query: string): string {
      const parsed = parse(query);
      const value = parsed.search_term;
      if(value === undefined) {
          return ""
      }else if(value instanceof Array){
          return value[0];
      }else{
        return value;
      }    
    }

}

const styles = StyleSheet.create(
  {

    page:{
      display: "flex",
      flexDirection: "column",
      "min-height": "100%"
    }, 

    body: {
      display: "flex",
      flexDirection: "row",
      flex: 1,
      "min-width": "100%",
      "max-width": "100%"
    },

    content: {
      display: "flex",
      flexDirection: "column",
      "width": "100%",
      "max-width": "100%",
      paddingLeft: 10,
      paddingRight: 10
    },

    summary: {
      display: "flex",
      flexDirection: "row",
      marginTop: 5,
      marginBottom: 5,
      alignItems: "center"
    },

    pagination_li: {
      display: "inline",
      paddingTop: "5px",
      paddingLeft: "10px",
      paddingRight: "10px",
      paddingBottom: "5px",
      borderRightStyle: "solid",
      borderRightWidth: "1px",
      borderColor: "#c4c4c4",
      ":hover": {
          cursor: "pointer",
          backgroundColor: "#e6e6e6ff",
          color: "#ffffff"
      },
    },

    pagination_active_li: {
      display: "inline",
      backgroundColor: "#329CDA",
      color: "white",
      paddingTop: "5px",
      paddingLeft: "10px",
      paddingRight: "10px",
      paddingBottom: "5px",
      borderRightStyle: "solid",
      borderRightWidth: "1px",
      borderColor: "#c4c4c4",
      ":hover": {
          cursor: "pointer",
          backgroundColor: "#e6e6e6ff",
          color: "#ffffff"
      },
    },

    pagination_active_a : {
      ":link": {
        textDecoration: "none",
        color: "white"
      },
      ":hover": {
          textDecoration: "none",
          color: "black"
      },
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