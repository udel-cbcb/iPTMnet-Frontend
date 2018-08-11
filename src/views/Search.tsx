import * as React from "react";
import SearchBox from "src/views/SearchBar";
import { StyleSheet, css } from 'aphrodite';

interface ISearchState {
    readonly isAdvancedVisisble: boolean; 
}

class Search extends React.Component<{},ISearchState> {
    
    constructor(props: {},state:ISearchState = {isAdvancedVisisble:false}) {
        super(props);
        this.state = state;
        this.onSearchBoxClicked = this.onSearchBoxClicked.bind(this);
    }
   
    public render(){
        return (
            <div>
                <SearchBox onSearchIconClick={this.onSearchBoxClicked} />
                {(()=>{
                    if(this.state.isAdvancedVisisble){
                        return (<div>
                            Advanced search
                        </div>);
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
            </div>
            
            
        );        
    };

    private onSearchBoxClicked(){
        this.setState({...this.state,isAdvancedVisisble: !this.state.isAdvancedVisisble})
    }

}

const styles = StyleSheet.create({
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
    }

})



export default Search