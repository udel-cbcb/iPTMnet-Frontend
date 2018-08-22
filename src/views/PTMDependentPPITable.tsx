import { css,StyleSheet } from "aphrodite";
import * as React from "react";
import axios from "axios";
import { PTMDependentPPIState } from "src/redux/states/PTMDependentPPIState";
import { JsonConvert } from "json2typescript/src/json2typescript/json-convert";
import { RequestState } from "../redux/states/RequestState";
import { ChangeEvent } from "react";
import { PTMDependentPPI } from '../models/PTMDependentPPI';
import { buildSource } from "src/views/Utils";
import { filterEntity, filterSource } from "../misc/Utils";

interface IPTMDependentPPIProps {
    id: string
}

export class PTMDependentPPITable extends React.Component<IPTMDependentPPIProps,PTMDependentPPIState> {

    constructor(props: IPTMDependentPPIProps){
        super(props);
        this.state = new PTMDependentPPIState();
    }

    public async componentDidMount() {
        this.setState(new PTMDependentPPIState(RequestState.LOADING,[]))
        axios.get(`https://research.bioinformatics.udel.edu/iptmnet/api/${this.props.id}/ptmppi`).then((res)=> {
            if(res.status === 200){
                const jsonConvert: JsonConvert = new JsonConvert();
                const ptmDependentPPI = jsonConvert.deserializeArray(res.data,PTMDependentPPI);
                const state = new PTMDependentPPIState(RequestState.SUCCESS,ptmDependentPPI,"");
                this.setState(state);
            }else{
                const error = res.statusText + ":" + res.data;
                this.setState(new PTMDependentPPIState(RequestState.ERROR,[],error));
            }    
        }).catch((err)=>{
            this.setState(new PTMDependentPPIState(RequestState.ERROR,[],err))
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
            <div id="ptmdependentppis_container"  className={css(styles.ptmdependentppisContainer)}  >
                <div id="label_container" className={css(styles.labelContainer)}  >
                    <span id="label" className={css(styles.label)}  >
                        PTM-depenent PPI
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

    private renderTable = (ptmDependentPPI: PTMDependentPPI[]) => {
        
        let filteredPTMDependentPPI = []
        if(this.state.searchTerm.trim().length > 0){
            filteredPTMDependentPPI = ptmDependentPPI.filter(this.filterPTMDependentPPI(this.state.searchTerm))
        }else{
            filteredPTMDependentPPI = this.state.data;
        }   
        
        const rows = filteredPTMDependentPPI.map(this.renderRow);
        
        return (
            <div id="ptmdependentppi_table" className={css(styles.ptmdependentppiTable)} >
                <div id="table_header" className={css(styles.header)}  >
                    <div id="ptm_type" className={css(styles.PTMType)} >
                        <div style={{marginLeft: 0}} >
                            PTM type
                        </div>
                    </div>
                    <div id="substrate" className={css(styles.Substrate)}  >
                        Substrate
                    </div>
                    <div id="site" className={css(styles.Site)}  >
                        Site
                    </div>
                    <div id="interactant" className={css(styles.Interactant)}  >
                        Interactant
                    </div>
                    <div id="association_type" className={css(styles.AssociationType)}  >
                        Association Type
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

    private renderRow = (ptmDependentPPI: PTMDependentPPI, index: number) => {
        return (
            <div id="table_row" className={css(styles.row)} key={index} >
                  <div id="ptm_type" className={css(styles.PTMType)} >
                        <input type="checkbox" style={{marginRight: 10}} />
                        {ptmDependentPPI.ptm_type}
                    </div>
                    <div id="substrate" className={css(styles.Substrate)}  >
                        <a 
                            href={"https://www.uniprot.org/uniprot/" + ptmDependentPPI.substrate.uniprot_id}
                            target="blank"
                        >
                        {ptmDependentPPI.substrate.uniprot_id}  
                        </a>
                        &nbsp;{"(" + ptmDependentPPI.substrate.name + ")"}
                    </div>
                    <div id="site" className={css(styles.Site)}  >
                        {ptmDependentPPI.site}
                    </div>
                    <div id="interactant" className={css(styles.Interactant)}  >
                        <a 
                            href={"https://www.uniprot.org/uniprot/" + ptmDependentPPI.interactant.uniprot_id}
                            target="blank"
                        >
                        {ptmDependentPPI.interactant.uniprot_id}  
                        </a>
                        &nbsp;{"(" + ptmDependentPPI.interactant.name + ")"}
                    </div>
                    <div id="association_type" className={css(styles.AssociationType)}  >
                        {ptmDependentPPI.association_type}
                    </div>
                    <div id="source" className={css(styles.Source)}  >
                        {buildSource(ptmDependentPPI.source)}
                    </div>
                    <div id="PMID" className={css(styles.PMID)}  >
                        <a 
                            href={"https://www.ncbi.nlm.nih.gov/pubmed/" + ptmDependentPPI.pmid}
                            target="blank"
                        >
                        {ptmDependentPPI.pmid}  
                        </a>
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

    private filterPTMDependentPPI = (searchTerm : string) => (ptmdependentppi: PTMDependentPPI, index: number, ptmdependentppis: PTMDependentPPI[]) => {
        const searchTermRegex = new RegExp(searchTerm, "i");
        if(ptmdependentppi.ptm_type.search(searchTermRegex) !== -1){
            return true;
        } else if(ptmdependentppi.association_type.search(searchTermRegex) !== -1 ){
            return true;
        } else if(ptmdependentppi.pmid.search(searchTermRegex) !== -1 ){
            return true;
        } else if(ptmdependentppi.site.search(searchTermRegex) !== -1){
            return true;
        } else if(filterEntity(ptmdependentppi.interactant,searchTerm)){
            return true;
        } else if(filterEntity(ptmdependentppi.substrate,searchTerm)){
            return true;
        } else if([ptmdependentppi.source].filter(filterSource(searchTerm)).length > 0){
            return true;
        }
        else{
            return false;
        }
    }
    
    
}


const styles = StyleSheet.create({
    
    ptmdependentppisContainer: {
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
    
    ptmdependentppiTable: {
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

    PTMType: {
        flex : 1,
        marginLeft: 10,
        marginRight: 10,
        display: "flex",
        flexDirection: "row" 
    },

    Substrate: {
        flex: 1,
        marginRight: 10
    },


    Site: {
        flex: 1,
        marginRight: 10
    },

    Interactant: {
        flex: 1,
        marginRight: 10
    },

    AssociationType: {
        flex: 1,
        marginRight: 10
    },

    Source: {
        flex: 1,
        marginRight: 10
    },

    PMID: {
        flex: 1,
        marginRight: 10
    }







    
    

})