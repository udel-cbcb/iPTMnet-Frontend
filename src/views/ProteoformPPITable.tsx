import { css,StyleSheet } from "aphrodite";
import * as React from "react";
import axios from "axios";
import { ProteoformPPIState } from "src/redux/states/ProteoformPPIState";
import { JsonConvert } from "json2typescript/src/json2typescript/json-convert";
import { RequestState } from "../redux/states/RequestState";
import { ChangeEvent } from "react";
import { ProteoformPPI } from '../models/ProteoformPPI';
import { Protein } from "src/models/Protein";
import { buildSource, buildPMIDs } from './Utils';
import { filterSource } from '../misc/Utils';
import { filterPMIDS } from 'src/misc/Utils';

interface IProteoformPPIProps {
    id: string
}

export class ProteoformPPITable extends React.Component<IProteoformPPIProps,ProteoformPPIState> {

    constructor(props: IProteoformPPIProps){
        super(props);
        this.state = new ProteoformPPIState();
    }

    public async componentDidMount() {
        this.setState(new ProteoformPPIState(RequestState.LOADING,[]))
        axios.get(`https://research.bioinformatics.udel.edu/iptmnet/api/${this.props.id}/proteoformsppi`).then((res)=> {
            if(res.status === 200){
                const jsonConvert: JsonConvert = new JsonConvert();
                const proteoformPPI = jsonConvert.deserializeArray(res.data,ProteoformPPI);
                const state = new ProteoformPPIState(RequestState.SUCCESS,proteoformPPI,"");
                this.setState(state);
            }else{
                const error = res.statusText + ":" + res.data;
                this.setState(new ProteoformPPIState(RequestState.ERROR,[],error));
            }    
        }).catch((err)=>{
            this.setState(new ProteoformPPIState(RequestState.ERROR,[],err.toString()))
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
            <div id="proteoformppis_container"  className={css(styles.proteoformppisContainer)}  >
                <div id="label_container" className={css(styles.labelContainer)}  >
                    <span id="label" className={css(styles.label)}  >
                        Proteoform PPI
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

    private renderTable = (proteoformPPI: ProteoformPPI[]) => {
        
        let filteredProteoformPPI = []
        if(this.state.searchTerm.trim().length > 0){
            filteredProteoformPPI = proteoformPPI.filter(this.filterProteoformPPI(this.state.searchTerm))
        }else{
            filteredProteoformPPI = this.state.data;
        }   
        
        const rows = filteredProteoformPPI.map(this.renderRow);
        
        return (
            <div id="proteoformppi_table" className={css(styles.proteoformppiTable)} >
                <div id="table_header" className={css(styles.header)}  >
                    <div id="protein_1" className={css(styles.Protein1)} >
                        <div style={{marginLeft: 0}} >
                            Protein 1
                        </div>
                    </div>
                    <div id="relation" className={css(styles.Relation)}  >
                        Relation
                    </div>
                    <div id="protein_2" className={css(styles.Protein2)}  >
                        Protein 2
                    </div>
                    <div id="source" className={css(styles.Source)}  >
                        Source
                    </div>
                    <div id="PMID" className={css(styles.PMID)}  >
                        PMID
                    </div>                                        
                </div>
                {rows}                
            </div>
        )
    }

    private renderRow = (proteoformPPI: ProteoformPPI, index: number) => {
        return (
            <div id="table_row" className={css(styles.row)} key={index} >
                <div id="protein_1" className={css(styles.Protein1)} >
                    <input type="checkbox" style={{marginRight: 10}}/>
                    {this.buildProtein(proteoformPPI.protein_1)}
                </div>
                <div id="relation" className={css(styles.Relation)}  >
                    {proteoformPPI.relation}
                </div>
                <div id="protein_2" className={css(styles.Protein2)}  >
                    {this.buildProtein(proteoformPPI.protein_2)}
                </div>
                <div id="source" className={css(styles.Source)}  >
                    {buildSource(proteoformPPI.source)}
                </div>
                <div id="PMID" className={css(styles.PMID)}  >
                    {buildPMIDs(proteoformPPI.pmids)}
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

    private buildProtein = (protein: Protein) => {
        if(protein.pro_id !== ""){
            return (
                <div>
                    <a href={"http://purl.obolibrary.org/obo/" + protein.pro_id} target="blank" >
                        {protein.pro_id}  
                    </a>
                    &nbsp;{"(" + protein.label + ")"}
                </div>
            )
        }else{
            return (
                <div>

                </div>
            )
        }
    }


    private onSearch = (event: ChangeEvent<HTMLInputElement>) => {
        const newState = {...this.state,searchTerm: event.target.value}
        this.setState(newState);
    }

    private filterProteoformPPI = (searchTerm : string) => (proteoformppi: ProteoformPPI, index: number, proteoformppis: ProteoformPPI[]) => {
        const searchTermRegex = new RegExp(searchTerm, "i");
        if(proteoformppi.relation.search(searchTermRegex) !== -1){
            return true;
        }else if([proteoformppi.source].filter(filterSource(searchTerm)).length > 0){
            return true;
        } else if(this.filterProtein(proteoformppi.protein_1,searchTerm)){
            return true;
        } else if(this.filterProtein(proteoformppi.protein_2,searchTerm)){
            return true;
        } else if(proteoformppi.pmids.filter(filterPMIDS(searchTerm)).length > 0){
            return true;
        }
        else{
            return false
        }
    }

    private filterProtein = (protein: Protein, searchTerm: string) => {
        const searchTermRegex = new RegExp(searchTerm, "i");
        if(protein.label.search(searchTermRegex) !== -1){
            return true
        }else if(protein.pro_id.search(searchTermRegex) !== -1){
            return true;
        }else{
            return false;
        }
    }

    
    
}


const styles = StyleSheet.create({
    
    proteoformppisContainer: {
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
    
    proteoformppiTable: {
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

    Protein1: {
        width: "30%",
        marginLeft: 10,
        marginRight: 10,
        display: "flex",
        flexDirection: "row",
        wordBreak: "break-all",  
    },

    Relation: {
        width: "10%",
        marginRight: 10,
        wordBreak: "break-all", 
    },


    Protein2: {
        width: "30%",
        marginRight: 10,
        wordBreak: "break-all", 
    },

    Source: {
        width: "10%",
        marginRight: 10,
        wordBreak: "break-all", 
    },

    PMID: {
        width: "20%",
        marginRight: 10,
        wordBreak: "break-all", 
    }  
});