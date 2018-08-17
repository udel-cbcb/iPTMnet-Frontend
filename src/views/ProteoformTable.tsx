import { css,StyleSheet } from "aphrodite";
import * as React from "react";
import axios from "axios";
import { ProteoformTableState } from "src/redux/states/ProteoformTableState";
import { JsonConvert } from "json2typescript/src/json2typescript/json-convert";
import { Proteoform } from "../models/Proteoform";
import { RequestState } from "../redux/states/RequestState";

interface IProteoformTableProps {
    id: string
}

export class ProteoformTable extends React.Component<IProteoformTableProps,ProteoformTableState> {

    constructor(props: IProteoformTableProps){
        super(props);
        this.state = new ProteoformTableState();
    }

    public async componentDidMount() {
        this.setState(new ProteoformTableState(RequestState.LOADING,[]))
        axios.get(`https://research.bioinformatics.udel.edu/iptmnet/api/${this.props.id}/proteoforms`).then((res)=> {
            if(res.status === 200){
                const jsonConvert: JsonConvert = new JsonConvert();
                const proteoforoms = jsonConvert.deserializeArray(res.data,Proteoform);
                const state = new ProteoformTableState(RequestState.SUCCESS,proteoforoms,"");
                this.setState(state);
            }else{
                const error = res.statusText + ":" + res.data;
                this.setState(new ProteoformTableState(RequestState.ERROR,[],error));
            }    
        }).catch((err)=>{
            this.setState(new ProteoformTableState(RequestState.ERROR,[],err))
        });
    }
    
    public render() {

        let content;
        
        if(this.state.status === RequestState.LOADING){
            content = this.renderLoading();
        }else if(this.state.status === RequestState.SUCCESS){
            content = this.renderTable(this.state.data);
        }else if(this.state.status === RequestState.ERROR ){
            content = this.renderError(this.state.error);
        }

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

                {content}

            </div>
        );
    }

    private renderTable = (proteoforms: Proteoform[]) => {
        
        const rows = proteoforms.map(this.renderRow);
        
        return (
            <div id="proteoform_table" className={css(styles.proteoformTable)} >
                <div id="table_header" className={css(styles.header)}  >
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

    private renderRow = (proteoform: Proteoform, index: number) => {
        return (
            <div id="table_row" className={css(styles.row)} key={index} >
                <div id="ID" className={css(styles.ID)} >
                    {proteoform.pro_id}
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

    private renderLoading = () => {
        return (
            <div id="table_row" className={css(styles.row)}  >
                Loading                                      
            </div>
        );
    }

    private renderError = (error: string) => {
        return (
            <div id="table_row" className={css(styles.row)}  >
                {error}                                      
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

    header: {
        display: "flex",
        flexDirection: "row",
        backgroundColor: "#eff1f2",
        paddingTop: 10,
        paddingBottom: 10,
        fontWeight: "bold"
    },

    row: {
        display: "flex",
        flexDirection: "row",
        paddingTop: 10,
        paddingBottom: 10,
        fontSize: "0.90em"
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