import * as React from "react";
import { css,StyleSheet,minify } from 'aphrodite';

minify(false);

class SearchBox extends React.Component {
    public render(){
        return (
            <div id="div_search_box" className={css(styles.searchBox)} >
                <div id="div_advanced_search_icon" className={css(styles.advancedSearchIcon)} >
                  <div style={{margin: "auto"}}>
                      &#xf13d;
                  </div>
                </div>

                <input id="input_search_term" className={css(styles.searchInput)} placeholder="Search for protein in iPTMnet database" />
                <div id="div_search_term_type_container" className={css(styles.searchTermTypeContainer)} >
                    <select id="select_search_term_type" className={css(styles.selectSearchTermType)} >
                        <option value="all" className={css(styles.searchTermTypeOption)} >
                            All
                        </option>
                        <option value="uniprot" className={css(styles.searchTermTypeOption)} >
                            Uniprot
                        </option>
                        <option value="name" className={css(styles.searchTermTypeOption)} >
                            Name
                        </option>
                        <option value="pmid" className={css(styles.searchTermTypeOption)} >
                            Name
                        </option>
                    </select>
                </div>
                
            </div>
        );        
    };
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
        width: 164,
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
        width: 164,
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