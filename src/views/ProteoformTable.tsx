import { css,StyleSheet } from "aphrodite";
import * as React from "react";

export class ProteoformTable extends React.Component {

    public render() {

        const table = this.renderTable([]);

        return (
            <div id="proteoforms_container"  className={css(styles.proteoformsContainer)}  >
                <div id="label_container" className={css(styles.labelContainer)}  >
                    <span id="label" className={css(styles.label)}  >
                        Proteoforms
                    </span>

                    <div id="search_container" className={css(styles.searchContainer)} >
                        <span style={{
                            marginRight: 10,
                            fontSize: "1em"
                        }}>
                            Search: 
                        </span>
                        
                        <input/>

                    </div>               
                </div>

                {table}

            </div>
        );
    }

    private renderTable = (proteoforms: ProteoformTable[]) => {
        
        const rows = proteoforms.map(this.renderRow);
        
        return (
            <div id="proteoform_table" className={css(styles.proteoformTable)} >
                <div id="table_header" className={css(styles.tableHeader)}  >
                    <div id="ID" className={css(styles.ID)} >
                        ID
                    </div>
                    <div id="Sites" className={css(styles.Sites)} >
                        Sites
                    </div>
                    <div id="PTM Enzymes" className={css(styles.PTMEnzymes)} >
                        PTM Enzymes
                    </div>
                    <div id="Source" className={css(styles.Source)} >
                        Source
                    </div>
                    <div id="PMID" className={css(styles.PMID)} >
                        PMID
                    </div>                                        
                </div>
                {rows}                
            </div>
        )
    }

    private renderRow = (proteoform: ProteoformTable) => {
        return (
            <div id="table_header" className={css(styles.tableHeader)}  >
                <div id="ID" className={css(styles.ID)} >
                    ID
                </div>
                <div id="Sites" className={css(styles.Sites)} >
                    Sites
                </div>
                <div id="PTM Enzymes" className={css(styles.PTMEnzymes)} >
                    PTM Enzymes
                </div>
                <div id="Source" className={css(styles.Source)} >
                    Source
                </div>
                <div id="PMID" className={css(styles.PMID)} >
                    PMID
                </div>                                        
            </div>
        );
    }

}


const styles = StyleSheet.create({
    
    proteoformsContainer: {
        display: "flex",
        flexDirection: "column",
        marginTop : 30,
        alignItems: "center"
    },

    labelContainer: {
        display: "flex",
        flexDirection: "row",
        paddingTop : 10,
        paddingBottom: 10,
        alignItems: "center",
        alignSelf: "stretch"
    },

    label: {
        fontSize: "1.5em"
    },

    searchContainer: {
        marginLeft: "auto",
        alignSelf: "center"
    },
    
    proteoformTable: {
        display: "flex",
        flexDirection: "column",
        fontSize: "0.88em",
        borderWidth: 1,
        borderStyle: "solid",
        borderColor: "#d9dadb",
        alignSelf: "stretch"
    },

    tableHeader: {
        display: "flex",
        flexDirection: "row",
        backgroundColor: "#eff1f2",
        paddingTop: 10,
        paddingBottom: 10,
        fontWeight: "bold"
    },

    ID: {
        flex : 2,
        marginLeft: 5,
        marginRight: 20,
        paddingLeft: 5 
    },

    Sites: {
        flex: "1.5",
        marginRight: 10  
    },

    PTMEnzymes: {
        flex: "2",
        marginRight: 20 
    },

    Source: {
        flex: "0.5",
        marginRight: 20 
    },

    PMID: {
        flex: "1",
        marginRight: 20 
    }




    
    

})