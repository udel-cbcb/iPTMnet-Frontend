import { css,StyleSheet } from "aphrodite";
import * as React from "react";
import axios from "axios";
import { ProteoformTableState } from "src/redux/states/ProteoformTableState";
import { JsonConvert } from "json2typescript/src/json2typescript/json-convert";
import { Proteoform } from "../models/Proteoform";
import { RequestState } from "../redux/states/RequestState";
import { ChangeEvent } from "react";
import { buildSource, buildPMIDs, buildPTMEnzyme } from "src/views/Utils";
import { filterPMIDS, filterSource } from "src/misc/Utils";

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
            this.setState(new ProteoformTableState(RequestState.ERROR,[],err.toString()))
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
                        
                        <input onChange={this.onSearch} />

                    </div>               
                </div>

                {content}

            </div>
        );
    }

    private renderTable = (proteoforms: Proteoform[]) => {
        
        let filteredProteoforms = []
        if(this.state.searchTerm.trim().length > 0){
            filteredProteoforms = proteoforms.filter(this.filterProteoforms(this.state.searchTerm))
        }else{
            filteredProteoforms = this.state.data;
        }   
        
        const rows = filteredProteoforms.map(this.renderRow);
        
        return (
            <div id="proteoform_table" className={css(styles.proteoformTable)} >
                <div id="table_header" className={css(styles.header)}  >
                    <div id="ID" className={css(styles.ID)} >
                        <div style={{marginLeft: 0}} >
                            ID
                        </div>
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
                    <input type="checkbox" style={{marginRight: 10}} />
                    {this.buildProteoformID(proteoform.pro_id)}
                    {" (" + proteoform.label + ")" }
                </div>
                <div id="Sites" className={css(styles.Sites)} >
                    {proteoform.sites.join(", ")}
                </div>
                <div id="PTM Enzymes" className={css(styles.PTMEnzymes)} >
                    {buildPTMEnzyme(proteoform.ptm_enzyme)}
                </div>
                <div id="Source" className={css(styles.Source)} >
                    {buildSource(proteoform.source)}
                </div>
                <div id="PMID" className={css(styles.PMID)} >
                    {buildPMIDs(proteoform.pmids)}
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

    private buildProteoformID = (id: string) => {
        return (
            <div style={{marginRight:5}} >
                <a
                    href={"http://purl.obolibrary.org/obo/" + id}
                >
                    {id}
                </a>
            </div>
        );
    }
    
    private onSearch = (event: ChangeEvent<HTMLInputElement>) => {
        const newState = {...this.state,searchTerm: event.target.value}
        this.setState(newState);
    }

    private filterProteoforms = (searchTerm : string) => (proteoform: Proteoform) => {
        const searchTermRegex = new RegExp(searchTerm, "i");
        if(proteoform.pro_id.search(searchTermRegex) !== -1 ){
            return true;
        }else if(proteoform.label.search(searchTermRegex) !== -1 ){
            return true;
        }else if(proteoform.ptm_enzyme.pro_id.search(searchTermRegex) !== -1 ){
            return true;
        }else if(proteoform.ptm_enzyme.label.search(searchTermRegex) !== -1 ){
            return true;
        }else if(proteoform.sites.filter(this.filterSites(searchTerm)).length > 0){
            return true;
        }else if(proteoform.pmids.filter(filterPMIDS(searchTerm)).length> 0){
            return true;
        } else if([proteoform.source].filter(filterSource(searchTerm)).length > 0){
            return true;
        }
        else{
            return false;
        }
    }

    private filterSites = (searchTerm: string) => (site: string) => {
        const searchTermRegex = new RegExp(searchTerm, "i");
        if(site.search(searchTermRegex) !== -1 ){
            return true;
        }else{
            return false;
        }
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
        width: "25%",
        marginLeft: 5,
        marginRight: 10,
        paddingLeft: 5,
        display: "flex",
        flexDirection: "row",
        wordBreak: "break-all", 
    },

    Sites: {
        width: "15%",
        marginRight: 10,
        wordBreak: "break-all",   
    },

    PTMEnzymes: {
        width: "35%",
        marginRight: 20,
        wordBreak: "break-all",  
    },

    Source: {
        width: "10%",
        marginRight: 20,
        wordBreak: "break-all",  
    },

    PMID: {
        width: "15%",
        marginRight: 20,
        wordBreak: "break-all", 
    }




    
    

})