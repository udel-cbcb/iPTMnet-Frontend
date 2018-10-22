import * as React from "react";
import { css,StyleSheet,minify } from 'aphrodite';
import { setSearchTerm, setSearchTermType } from '../redux/actions/HomePageActions';
import store from "../redux/store";
import { TermType, termTypeToString, termTypeFromString } from "src/models/TermType";

minify(false);

interface ISearchBoxProps{
    readonly searchTerm: string
    readonly searchTermType: TermType
    onSearchIconClick: () => any
    onEnterPress?: () => any 
}

class SearchBox extends React.Component<ISearchBoxProps,{}> {

    constructor(props: ISearchBoxProps) {
        super(props);
    }  

    public render(){
        return (
            <div id="div_search_box" className={css(styles.searchBox)} >
                <div id="div_advanced_search_icon" className={css(styles.advancedSearchIcon)} onClick={this.props.onSearchIconClick} >
                  <div style={{margin: "auto"}}>
                      &#xf13d;
                  </div>
                </div>

                <input id="input_search_term"
                       className={css(styles.searchInput)}
                       placeholder="Search for protein in iPTMnet database"
                       value={this.props.searchTerm}
                       onChange={this.onSearchTermChange}
                       onKeyPress={this.onKeyPress}
                       />
                <div id="div_search_term_type_container" className={css(styles.searchTermTypeContainer)} >
                    <select id="select_search_term_type" 
                            className={css(styles.selectSearchTermType)}
                            value={termTypeToString(this.props.searchTermType)}
                            onChange={this.onSearchTermTypeChange}
                            >
                        <option value="All" className={css(styles.searchTermTypeOption)} >
                            All
                        </option>
                        <option value="UniprotID" className={css(styles.searchTermTypeOption)} >
                            UniprotID
                        </option>
                        <option value="Protein/Gene Name" className={css(styles.searchTermTypeOption)} >
                            Protein/Gene Name
                        </option>
                        <option value="PMID" className={css(styles.searchTermTypeOption)} >
                            PMID
                        </option>
                    </select>
                </div>
                
            </div>
        );        
    };

    private onSearchTermChange = (event: any) => {
        store.dispatch(setSearchTerm(event.target.value));
    }

    private onSearchTermTypeChange = (event: any) => {
        console.log(event.target.value);
        const termType = termTypeFromString(event.target.value);
        store.dispatch(setSearchTermType(termType));
    }

    private onKeyPress = (event: any) => {
        if(event.key === "Enter"){
            if(this.props.onEnterPress){
                this.props.onEnterPress();
            }
        }
    }

}


const styles = StyleSheet.create({
    searchBox : {
        display: "flex",
        flexDirection: "row",
        alignItems: "center",
        height: "50",
        marginTop: 60,
        boxShadow:"0px 3px 10px #83838354",
        ":focus": {
            boxShadow: "4px 6px 12px #83838354"
        },
    
        ":hover": {
            boxShadow: "4px 6px 12px #83838354"
        }
      },
    
    advancedSearchIcon : {
        height: "50px",
        width: "50px",
        backgroundColor: "#329CDA",
        display: "flex",
        flexDirection: "column",
        alignItems: "baseline",
        color: "#FFFFFF",
        ":hover": {
            cursor: "pointer",
            backgroundColor: "#258ecbff"
        },
        fontFamily: "Ionicons",
        fontSize: "1.5em"
    },

    searchInput : {
        width: "400px",
        height: "48px",
        backgroundColor: "#f7f7f7ff",
        paddingLeft: 30,
        paddingRight: 30,
        borderStyle: "none",
        fontSize: 16,
        ":focus": {
            outline: "none"
        }
    },

    searchTermTypeContainer: {
        display: "flex",
        flexDirection: "row",
        alignItems: "center",
        height: 50,
        backgroundColor: "#329CDA",
        boxShadow: "0px 3px 5px #83838354",
        ":hover": {
            cursor: "pointer",
            backgroundColor: "#258ecbff"
        }
    },
    
    selectSearchTermType : {
        borderStyle: "none",
        backgroundColor: "transparent",
        color: "#fbfbfb",
        fontSize: "1em",
        paddingLeft: 20,
        paddingRight: 10,
        height: "100%",
        "-webkit-appearance": "none",
        "-moz-appearance": "none",
        margin: 0,
        ":focus": {
            outline: "none"
        },
        ":hover" : {
            cursor: "pointer"
        },
    },

    searchTermTypeOption: {
        color: "#606060ff",
        width: 164,
        textAlign: "center"
    }
    
})


export default SearchBox