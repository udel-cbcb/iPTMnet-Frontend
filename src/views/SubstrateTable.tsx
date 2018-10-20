import { css,StyleSheet } from "aphrodite";
import * as React from "react";
import axios from "axios";
import { SubstrateTableState } from "src/redux/states/SubstrateTableState";
import { Substrate } from "../models/Substrate";
import { RequestState } from "../redux/states/RequestState";
import { ChangeEvent } from "react";
import { buildPMIDs, buildSources, buildEnzymes, renderScore } from 'src/views/Utils';
import { filterSource } from 'src/misc/Utils';
import { filterPMIDS } from 'src/misc/Utils';
import { filterEnzyme } from '../misc/Utils';


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
                    const keys = Array.from(Object.keys(substrateMap)).sort();
                    let selectedForm = "";
                    if(keys.length > 0){
                        selectedForm = keys[0];
                    }
                    const state = new SubstrateTableState(RequestState.SUCCESS,substrateMap,selectedForm,"");
                    this.setState(state);
                }else{
                    const error = res.statusText + ":" + res.data;
                    this.setState(new SubstrateTableState(RequestState.ERROR,new Map<string, Substrate[]>(),"","",error));
                }
            }catch(err){
                this.setState(new SubstrateTableState(RequestState.ERROR,new Map<string, Substrate[]>(),"","",err.toString()))
            }
                
        }).catch((err)=>{
            this.setState(new SubstrateTableState(RequestState.ERROR,new Map<string, Substrate[]>(),"","",err.toString()))
        });
    }
    
    public render() {

        const tabs = this.state.getForms().map(this.renderTab)

        let content;
        
        if(this.state.status === RequestState.LOADING){
            content = this.renderLoading();
        }else if(this.state.status === RequestState.SUCCESS){
            content = this.renderTable(this.state.getData(this.state.selectedForm));
        }else if(this.state.status === RequestState.ERROR ){
            content = this.renderError(this.state.error);
        }



        return (
            <div id="substrates_container"  className={css(styles.substratesContainer)}  >
                <div id="label_container" className={css(styles.labelContainer)}  >
                    <span id="label" className={css(styles.label)}  >
                        Substrates
                    </span>                                                       
                </div>

                <div id="tabs_container" className={css(styles.tabsContainer)} >
                    <ul className={css(styles.tabs)} >
                        {tabs}
                    </ul>
                </div>

                <div id="search_container" className={css(styles.searchContainer)} >
                        <span style={{
                            marginRight: 10,
                            fontSize: "1em"
                        }}>
                            Search: 
                        </span>
                        
                        <input onChange={this.onSearch} />

                </div>

                {content}

            </div>
        );
    }

    private renderTable = (substrates: Substrate[]) => {
        
        let filteredSubstrates = []
        if(this.state.searchTerm.trim().length > 0){
            filteredSubstrates = substrates.filter(this.filterSubstrate(this.state.searchTerm.trim()))
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
                        Score
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
        let backgroundColor;
        if((index + 1)%2 === 0){
            backgroundColor = styles.evenRowBackground
        }else{
            backgroundColor = styles.oddRowBackground
        }
        return (
            <div id="table_row" className={css(styles.row,backgroundColor)} key={index} >
                 <div id="Site" className={css(styles.Site)} >
                    <div style={{marginLeft: 0}} >
                        {substrate.site}
                    </div>
                </div>
                <div id="PTMtype" className={css(styles.PTMtype)} >
                    {substrate.ptm_type}
                </div>
                <div id="PTM Enzymes" className={css(styles.PTMEnzymes)} >
                    {buildEnzymes(substrate.enzymes)}
                </div>
                <div id="Score" className={css(styles.Score)} >
                    {renderScore(substrate.score)}
                </div>
                <div id="Source" className={css(styles.Source)} >
                    {buildSources(substrate.sources)}
                </div>
                <div id="PMID" className={css(styles.PMID)} >
                    {buildPMIDs(substrate.pmids)}
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

    private renderTab = (form: string, index: number) => {
        let visibility;
        
        if(form === this.state.selectedForm){
            visibility = styles.visible
        }else{
            visibility = styles.hidden
        }
        
        return (
            <div className={css(styles.tab)} key={index} onClick={this.onTabClick(form)} >
                <div id="tab_label" className={css(styles.tabLabel)}  >
                    {form}
                </div>
                <div className={css(styles.tabSelectionBar,visibility)} >

                </div>
            </div>
        )
    }
       
    private onSearch = (event: ChangeEvent<HTMLInputElement>) => {
        const newState = {...this.state,searchTerm: event.target.value}
        this.setState(newState);
    }

    private onTabClick = (form: string) => (event: any) => {
        const newState = {...this.state, selectedForm: form}
        this.setState(newState);
    }

    private filterSubstrate = (searchTerm: string) => (substrate: Substrate): boolean => {
        const searchTermRegex = new RegExp(searchTerm, "i");
        if(substrate.site && substrate.site.search(searchTermRegex) !==  -1){
            return true;
        }else if(substrate.ptm_type && substrate.ptm_type.search(searchTermRegex) !== -1 ){
            return true;
        }else if(substrate.sources.filter(filterSource(searchTerm)).length > 0){
            return true;
        }else if(substrate.pmids.filter(filterPMIDS(searchTerm)).length > 0){
            return true;
        }else if(substrate.enzymes.filter(filterEnzyme(searchTerm)).length > 0){
            return true;
        }
        else {
            return false;
        }
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
        marginBottom: 10,
        alignSelf: "center"
    },

    tabsContainer: {
        display: "flex",
        flexDirection: "row",
        alignItems: "center",
        alignSelf: "stretch"
    },
    
    tabs: { 
       display: "flex",
       flexDirection: "row",
       alignItems: "center",
       paddingLeft: 0 
    },

    tab: {
        display: "flex",
        flexDirection: "column",
        alignItems: "stretch",
        borderWidth: 1,
        borderStyle: "solid",
        borderColor: "#d9dadb",
        ":hover": {
            cursor: "pointer"
        }
    },

    visible: {
        visibility: "visible"
    },

    hidden: {
        visibility: "hidden"
    },

    tabLabel: {
        paddingLeft: 10,
        paddingTop: 5,
        paddingBottom: 5,
        paddingRight: 10,
    },

    tabSelectionBar: {
        height: 2,
        width: "100%",
        backgroundColor: "#329CDA"
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
        fontSize: "0.90em",
        ":hover":{
            backgroundColor: "#f4f4f4"
        }
    },

    evenRowBackground: {
        backgroundColor: "#ffffff"
    },

    oddRowBackground: {
        backgroundColor: "#f9f9f9ff"
    },

    Site: {
        width: "20%",
        minWidth: "5%",
        marginLeft: 20,
        marginRight: 20,
        display: "flex",
        wordBreak: "break-all",
        flexDirection: "row" 
    },

    PTMtype: {
        width: "16%",
        marginRight: 20,
        wordBreak: "break-all",  
    },

    PTMEnzymes: {
        width: "30%",
        minWidth: "10%",
        marginRight: 20,
        wordBreak: "break-all", 
    },

    Score: {
        width: "10%",
        marginRight: 20,
        wordBreak: "break-all", 
    },

    Source: {
        width: "30%",
        marginRight: 20,
        wordBreak: "break-all", 
    },

    PMID: {
        width: "30%",
        marginRight: 20,
        wordBreak: "break-all", 
    }
    

})