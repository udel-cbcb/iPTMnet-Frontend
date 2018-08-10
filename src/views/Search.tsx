import * as React from "react";
import { css,StyleSheet,minify } from 'aphrodite';

minify(false);

class Search extends React.Component {
    public render(){
        return (
            <div id="div_search_box" className={css(styles.searchBox)} >
                <div id="div_advanced_search_icon" className={css(styles.advancedSearchIcon)} >
                  <div style={{margin: "auto"}}>
                      &#xf13d;
                  </div>
                </div>

                <input id="input_search_term" className={css(styles.searchInput)}  />

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
    }     
})


export default Search