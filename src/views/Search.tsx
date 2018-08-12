import * as React from "react";
import SearchBox from "./SearchBar";
import SearchOptions from "./SearchOptions";
import { StyleSheet, css } from 'aphrodite';
import { State } from "src/redux/state";
import { Dispatch, bindActionCreators } from "redux";
import { connect } from "react-redux";

interface ISearchState {
    readonly isAdvancedVisisble: boolean; 
}

interface ISearchProps {
    selectedPTMs: string [] 
}

class Search extends React.Component<ISearchProps,ISearchState> {
    
    constructor(props: ISearchProps,state:ISearchState = {isAdvancedVisisble:false}) {
        super(props);
        this.state = state;
        this.onSearchBoxClicked = this.onSearchBoxClicked.bind(this);
    }
   
    public render(){
        return (
            <div id="div_search_container" className={css(styles.searchContainer)}  >
                <SearchBox onSearchIconClick={this.onSearchBoxClicked} />
                {(()=>{
                    if(this.state.isAdvancedVisisble){
                        return (
                            <SearchOptions selectedPTMs={this.props.selectedPTMs} />
                        );
                    }else{
                        return <div></div>;
                    }
                })()}
                <div id="div_misc" className={css(styles.misc)} >
                    <div id="advanced_search" className={css(styles.advancedSearch)} onClick={this.onSearchBoxClicked} >
                        Advanced search
                    </div>
                    <a id="sample_report" target="_" href="/entry/Q15796" className={css(styles.sampleReport)} >
                        Sample Report
                    </a>
                    <a id="batch_retrieval" target="_" href="/batch" className={css(styles.batchRetrieval)} >
                        Batch Retrieval
                    </a>
                </div>

                <div id="search_buttons" className={css(styles.searchButtonsContainer)} >
                    <button id="btn_search" className={css(styles.searchButton)}  >
                        Search
                    </button>
                    <button id="btn_reset" className={css(styles.resetButton)}  >
                        Reset
                    </button>
                </div>

            </div>           
            
        );        
    };

    private onSearchBoxClicked(){
        this.setState({...this.state,isAdvancedVisisble: !this.state.isAdvancedVisisble})
    }

}


const mapStateToProps = (state: State) => ({
    selectedPTMs: state.homePage.selectedPTMs
});
  
const mapDispatchToProps = (dispatch: Dispatch) => bindActionCreators({}, dispatch);
  
export const SearchConnected = connect(mapStateToProps, mapDispatchToProps)(Search);

const styles = StyleSheet.create({
    
    searchContainer: {
        display: "flex",
        flexDirection: "column",
        alignItems: "stretch",
    },  

    misc: {
        display: "flex",
        flexDirection: "row",
        alignSelf: "stretch",
        marginTop: "25px",
        fontSize: "0.9em",
        paddingLeft: "10px",
        color: "#329CDA" 
    },

    advancedSearch: {
        paddingRight: 20,
        textDecoration: "underline",
        ":hover": {
            cursor: "pointer"
        } 
    },

    sampleReport: {
        marginRight: "20px",
        ":link": {
            color: "#329CDA"
        },
        ":visited": {
            color: "#329CDA"
        }
    },

    batchRetrieval: {
        marginLeft: "auto",
        marginRight: "20px",
        ":link": {
            color: "#329CDA"
        },
        ":visited": {
            color: "#329CDA"
        }
    },

    searchButtonsContainer : {
        display: "flex",
        flexDirection: "row",
        alignSelf: "center",
        marginTop: 30
    },

    searchButton : {
        backgroundColor: "#329CDA",
        width: 100,
        fontSize: "1em",
        paddingTop: 10,
        paddingBottom: 10,
        borderStyle: "none",
        borderRadius: 25,
        color: "#fbfbfb",
        ":focus": {
            outline: "none"
        },
        ":hover": {
            cursor: ":pointer",
            backgroundColor: "#258ecbff"
        }
    },

    resetButton : {
        backgroundColor: "transparent",
        width: 100,
        fontSize: "1em",
        paddingTop: 10,
        paddingBottom: 10,
        marginLeft: 40,
        borderStyle: "solid",
        borderColor: "#329CDA",
        borderRadius: 25,
        borderWidth: 1,
        color: "#131313ff",
        ":focus": {
            outline: "none"
        },
        ":hover": {
            cursor: "pointer",
            color: "#fbfbfb",
            backgroundColor: "#329cda94"
        }
    }

})



export default Search