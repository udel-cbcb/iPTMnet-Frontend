import { css,StyleSheet } from "aphrodite";
import * as React from "react";
import axios from "axios";
import { SubstrateTableState } from "src/redux/states/SubstrateTableState";
import { Substrate } from "../models/Substrate";
import { RequestState } from "../redux/states/RequestState";
import { ChangeEvent } from "react";

interface ISubstrateTableProps {
    id: string
}

export class SubstrateTable extends React.Component<ISubstrateTableProps,SubstrateTableState> {

    constructor(props: ISubstrateTableProps){
        super(props);
        this.state = new SubstrateTableState();
    }

    public async componentDidMount() {
        this.setState(new SubstrateTableState(RequestState.LOADING))
        axios.get(`https://research.bioinformatics.udel.edu/iptmnet/api/${this.props.id}/substrate`).then((res)=> {
            try{
                if(res.status === 200){
                    const substrateMap : Map<string, Substrate[]> = res.data;
                    const keys = Array.from(Object.keys(substrateMap));
                    let selectedForm = "";
                    if(keys.length > 0){
                        selectedForm = keys[0];
                    }
                    console.log(selectedForm);
                    const state = new SubstrateTableState(RequestState.SUCCESS,substrateMap,selectedForm,"");
                    this.setState(state);
                }else{
                    const error = res.statusText + ":" + res.data;
                    this.setState(new SubstrateTableState(RequestState.ERROR,new Map<string, Substrate[]>(),"","",error));
                }
            }catch(err){
                console.log(err);
                this.setState(new SubstrateTableState(RequestState.ERROR,new Map<string, Substrate[]>(),"","",err))
            }
                
        }).catch((err)=>{
            this.setState(new SubstrateTableState(RequestState.ERROR,new Map<string, Substrate[]>(),"","",err))
        });
    }
    
    public render() {

        let content;
        
        if(this.state.status === RequestState.LOADING){
            content = this.renderLoading();
        }else if(this.state.status === RequestState.SUCCESS){
            console.log(this.state);
            content = this.renderTable(this.state.getSelectedData());
        }else if(this.state.status === RequestState.ERROR ){
            content = this.renderError(this.state.error);
        }

        return (
            <div id="substrates_container"  className={css(styles.substratesContainer)}  >
                <div id="label_container" className={css(styles.labelContainer)}  >
                    <span id="label" className={css(styles.label)}  >
                        Substrates
                    </span>

                    <div id="search_container" className={css(styles.searchContainer)} >
                        <span style={{
                            marginRight: 10,
                            fontSize: "1em"
                        }}>
                            Search: 
                        </span>
                        
                        <input onChange={this.onSearch} />

                    </div>               
                </div>

                {content}

            </div>
        );
    }

    private renderTable = (substrates: Substrate[]) => {
        
        let filteredSubstrates = []
        if(this.state.searchTerm.trim().length > 0){
            filteredSubstrates = substrates
        }else{
            filteredSubstrates = substrates
        }   
        
        const rows = filteredSubstrates.map(this.renderRow);
        
        return (
            <div id="substrate_table" className={css(styles.substrateTable)} >
                <div id="table_header" className={css(styles.header)}  >
                    <div id="Site" className={css(styles.Site)} >
                        <div style={{marginLeft: 0}} >
                            Site
                        </div>
                    </div>
                    <div id="PTMtype" className={css(styles.PTMtype)} >
                        PTM Type
                    </div>
                    <div id="PTM Enzymes" className={css(styles.PTMEnzymes)} >
                        PTM Enzymes
                    </div>
                    <div id="Score" className={css(styles.Score)} >
                        Source
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

    private renderRow = (substrate: Substrate, index: number) => {
        return (
            <div id="table_row" className={css(styles.row)} key={index} >
                 <div id="Site" className={css(styles.Site)} >
                    <div style={{marginLeft: 0}} >
                        {substrate.site}
                    </div>
                </div>
                <div id="PTMtype" className={css(styles.PTMtype)} >
                    {substrate.ptm_type}
                </div>
                <div id="PTM Enzymes" className={css(styles.PTMEnzymes)} >
                    PTM Enzymes
                </div>
                <div id="Score" className={css(styles.Score)} >
                    Source
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

    
    
    private onSearch = (event: ChangeEvent<HTMLInputElement>) => {
        const newState = {...this.state,searchTerm: event.target.value}
        this.setState(newState);
    }
  
       
}


const styles = StyleSheet.create({
    
    substratesContainer: {
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
    
    substrateTable: {
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

    Site: {
        flex : 2,
        marginLeft: 5,
        marginRight: 20,
        paddingLeft: 5,
        display: "flex",
        flexDirection: "row" 
    },

    PTMtype: {
        flex: "1.5",
        marginRight: 10  
    },

    PTMEnzymes: {
        flex: "2",
        marginRight: 20 
    },

    Score: {
        flex: "0.5",
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