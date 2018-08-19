import { css,StyleSheet } from "aphrodite";
import * as React from "react";
import axios from "axios";
import { ProteoformTableState } from "src/redux/states/ProteoformTableState";
import { JsonConvert } from "json2typescript/src/json2typescript/json-convert";
import { Proteoform } from "../models/Proteoform";
import { RequestState } from "../redux/states/RequestState";
import { PTMEnzyme } from "src/models/PTMEnzyme";
import { Source } from "src/models/Source";
import * as intersperse from "intersperse";
import { ChangeEvent } from "react";

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
                        <input type="checkbox" style={{marginRight: 10}} />
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
                    <input type="checkbox" style={{marginRight: 10}} />
                    {this.buildProteoformID(proteoform.pro_id)}
                    {" (" + proteoform.label + ")" }
                </div>
                <div id="Sites" className={css(styles.Sites)} >
                    {proteoform.sites.join(", ")}
                </div>
                <div id="PTM Enzymes" className={css(styles.PTMEnzymes)} >
                    {this.buildPTMEnzyme(proteoform.ptm_enzyme)}
                </div>
                <div id="Source" className={css(styles.Source)} >
                    {this.buildSource(proteoform.source)}
                </div>
                <div id="PMID" className={css(styles.PMID)} >
                    {this.buildPMIDs(proteoform.pmids)}
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

    private buildPTMEnzyme = (enzyme: PTMEnzyme) => {
        if(enzyme.pro_id !== ""){
            return (
                <div >
                    <a href={"http://purl.obolibrary.org/obo/" + enzyme.pro_id} style={{marginRight:5}} >
                        {enzyme.pro_id}
                    </a>

                    {"(" + enzyme.label + ")" }
                </div>
            );
        }else{
            return (
                <div>

                </div>
            );
        }
    }

    private buildSource = (source: Source) => {
        
        const sourceUrl = "#"
        
        return (
             <a href={sourceUrl} target="_" >
                {source.label}
             </a>
         )
    }

    private buildPMIDs = (pmids: string[]) => {
        const builtPMIDs = pmids.map(this.buildPMID);
        const interspersedPMIDs = intersperse(builtPMIDs,this.comma())
        return (
            <div style={{display: "inline"}} >
                {interspersedPMIDs}
            </div>
        );
    }

    private comma() {
        return (<span key={Math.random()} >
            ,&nbsp;
        </span>);
    }

    private buildPMID = (pmid: string, index: number) => {
        return (
            <a href={"https://www.ncbi.nlm.nih.gov/pubmed" + pmid} key={index} >
                {pmid}
            </a>
        )
    }


    private onSearch = (event: ChangeEvent<HTMLInputElement>) => {
        const newState = {...this.state,searchTerm: event.target.value}
        this.setState(newState);
    }

    private filterProteoforms = (searchTerm : string) => (proteoform: Proteoform, index: number, proteoforms: Proteoform[]) => {
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
        }else if(proteoform.pmids.filter(this.filterPMIDS(searchTerm)).length> 0){
            return true;
        } else if([proteoform.source].filter(this.filterSource(searchTerm)).length > 0){
            return true;
        }
        else{
            return false;
        }
    }

    private filterSites = (searchTerm: string) => (site: string, index: number, sites: string[]) => {
        const searchTermRegex = new RegExp(searchTerm, "i");
        if(site.search(searchTermRegex) !== -1 ){
            return true;
        }else{
            return false;
        }
    }

    private filterPMIDS = (searchTerm: string) => (pmid: string, index: number, pmids: string[]) => {
        const searchTermRegex = new RegExp(searchTerm, "i");
        if(pmid.search(searchTermRegex) !== -1 ){
            return true;
        }else{
            return false;
        }
    }


    private filterSource = (searchTerm: string) => (source: Source, index: number, sources: Source[]) => {
        const searchTermRegex = new RegExp(searchTerm, "i");
        if(source.label.search(searchTermRegex) !== -1 ){
            return true;
        }else if(source.name.search(searchTermRegex) !== -1 ){
            return true;
        }
        else{
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
        flex : 2,
        marginLeft: 5,
        marginRight: 20,
        paddingLeft: 5,
        display: "flex",
        flexDirection: "row" 
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