import * as React from "react";
import SearchBox from "./SearchBox";
import SearchOptions from "./SearchOptions";
import { StyleSheet, css } from 'aphrodite';
import { State } from "../redux/state";
import { Dispatch, bindActionCreators } from "redux";
import { connect } from "react-redux";
import { Role, roleToString } from "../models/Role";
import { withRouter } from 'react-router-dom';
import { resetOptions } from "../redux/actions/HomePageActions";
import store from "../redux/store";
import { TermType } from 'src/models/TermType';
import { termTypeToString } from 'src/models/TermType';

interface ISearchState {
    readonly isAdvancedVisisble: boolean; 
}

interface ISearchProps {
    searchTerm: string
    searchTermType: TermType
    selectedPTMs: string []
    selectedOrganisms: string []
    selectedRole: Role 
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
                <SearchBox 
                        searchTerm={this.props.searchTerm}
                        searchTermType={this.props.searchTermType}
                        onSearchIconClick={this.onSearchBoxClicked}
                        onEnterPress={this.onSearchButtonClicked}
                        />
                {(()=>{
                    if(this.state.isAdvancedVisisble){
                        return (
                            <SearchOptions
                             selectedPTMs={this.props.selectedPTMs}
                             selectedOrganisms={this.props.selectedOrganisms}
                             selectedRole={this.props.selectedRole}
                            />
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
                    <button id="btn_search" className={css(styles.searchButton)} onClick={this.onSearchButtonClicked}  >
                        Search
                    </button>
                    <button id="btn_reset" className={css(styles.resetButton)} onClick={this.onResetButtonClicked}  >
                        Reset
                    </button>
                </div>

            </div>           
            
        );        
    };

    private onSearchBoxClicked(){
        this.setState({...this.state,isAdvancedVisisble: !this.state.isAdvancedVisisble})
    }

    private onSearchButtonClicked = () => {
        if(this.props.searchTerm.trim() !== ""){            
            const searchUrl = this.buildSearchUrl();  
            (this.props as any).history.push(searchUrl);
        }
    }

    private onResetButtonClicked = () => {
        store.dispatch(resetOptions());
    }

    private buildSearchUrl = () => {
        
        const termTyepStr = termTypeToString(this.props.searchTermType);
        console.log(termTyepStr)
        
        let ptm_types_string = "";
        if(this.props.selectedPTMs.length > 0){
            ptm_types_string = "&" + this.props.selectedPTMs.map(this.buildPTMType); 
        }

        let organisms_string = ""
        if(this.props.selectedOrganisms.length > 0){
            organisms_string = "&" + this.props.selectedOrganisms.map(this.buildOrganism);
        }

        return `search/search_term=${this.props.searchTerm}&term_type=All&role=${roleToString(this.props.selectedRole)}${ptm_types_string}${organisms_string}&paginate=true&start_index=0&end_index=20`;
      
    }

    private buildPTMType(ptmName: string): string {
        return "ptm_type="+ptmName
    }

    private buildOrganism(organism: string) : string {
        return "taxon=" + organism;
    }

}


const mapStateToProps = (state: State) => ({
    searchTerm: state.homePage.searchTerm,
    searchTermType: state.homePage.searchTermType,
    selectedPTMs: state.homePage.selectedPTMs,
    selectedOrganisms: state.homePage.selectedOrganisms,
    selectedRole: state.homePage.selectedRole
});
  
const mapDispatchToProps = (dispatch: Dispatch) => bindActionCreators({}, dispatch);
  
export const SearchConnected = connect(mapStateToProps, mapDispatchToProps)(withRouter(Search as any));

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
            cursor: "pointer",
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