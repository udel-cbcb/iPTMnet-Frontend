import * as React from "react";
import { SearchResultState } from "src/redux/states/SearchResultState";
import { RequestState } from "../redux/states/RequestState";
import { css, StyleSheet } from 'aphrodite';
import axios from "axios";
import { JsonConvert } from "json2typescript/src/json2typescript/json-convert";
import SearchResult from "src/models/SearchResult";
import { SearchResultData } from "src/models/SearchResultData";
import {WanderingCubes} from 'better-react-spinkit'
import { host_url } from "src/misc/Utils";


interface ISearchResultsProps {
    query: string
    isBrowse?: boolean,
    onDataLoaded?: ((count: number) => any);
}

export class SearchResultView extends React.Component<ISearchResultsProps,SearchResultState> {

    constructor(props: ISearchResultsProps){
        super(props)
        this.state = new SearchResultState();
    }

    public sleep(ms: number) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }

    public async componentDidMount() {
        this.refresh(this.props.query);
    }

    public async componentWillReceiveProps(nextProps: ISearchResultsProps) {
        console.log(nextProps.query)
        if(nextProps.query !== this.props.query){
            this.refresh(nextProps.query)
        }
    }

    public render() {
        
        let body;
        if(this.state.status === RequestState.NOTASKED){
            body = (
                <div>
                    Not asked
                </div>
            )
        }
        else if(this.state.status === RequestState.LOADING){
            body = this.renderLoading()
        }else if(this.state.status === RequestState.SUCCESS){
            body = this.renderTable(this.state.data.searchResults);
        }        
        else if(this.state.status === RequestState.ERROR){
            body = (
                <div>
                    {this.state.error}
                </div>
            )
        }
        else{
            body = (
                <div>
                    
                </div>
            )
        }
        return body
    }

    private renderLoading = () => {
        return (
            <div className={css(styles.loadingContainer)} >
                <div className={css(styles.loading)} >
                    <WanderingCubes color="#b3b3b3ff" size={40} cubeSize={16} duration="2s"
                    />
                </div>
                Loading results...
            </div>        
        )
    }

    private renderTable = (results: SearchResult[]) => {
        
        const header = this.renderHeader()
        const renderedRows = results.map(this.renderRow)
        return (
            <div id="div_search_table">
                {header}
                {renderedRows}
            </div>
        )
    }

    private renderHeader() {
        return (
          <div className={css(styles.searchResultRow,styles.searchResultHeader)} >
                     <div className={css(styles.iptm_id)} >
                        <input type="checkbox" style={{marginLeft: 10,marginRight: 10}} onClick={this.onSelectAllIDClicked}  />
                        iPTM ID
                     </div>

                     <div className={css(styles.protein_name)} >
                        Protein Name
                     </div>
                     
                     <div className={css(styles.gene_name)} >
                        Gene Name
                     </div>
                     
                     <div className={css(styles.organism)} >
                        Organism
                     </div>
                     
                     <div className={css(styles.substrate_role)} >
                        Substrate Role
                     </div>
                     
                     <div className={css(styles.enzyme_role)} >
                        Enzyme Role
                     </div>
                     
                     <div className={css(styles.ptm_dependent_ppi)} >
                          PTM-dependent PPI
                     </div>
                     
                     <div className={css(styles.sites)} >
                        Sites
                     </div>
                     
                     <div className={css(styles.isoforms)} >
                        Isoforms
                     </div>
          </div>
        )
    }
    
    private renderRow = (searchResult: SearchResult, index: number) => {

        const id_link = `https://research.bioinformatics.udel.edu/iptmnet/entry/${searchResult.iptm_id}/`
        const ipro_link = `http://pir.georgetown.edu/cgi-bin/ipcEntry?id=${searchResult.iptm_id}`
        const uniprot_link = `http://www.uniprot.org/uniprot/${searchResult.iptm_id}`
        const pro_link = `http://proteininformationresource.org/cgi-bin/pro/entry_pro?id=PR:${searchResult.iptm_id}`
        const sub_link =  `https://research.bioinformatics.udel.edu/iptmnet/entry/${searchResult.iptm_id}/#asSub`
        const enz_link = `https://research.bioinformatics.udel.edu/iptmnet/entry/${searchResult.iptm_id}/#asSub`

        let enzyme_role;
        if(searchResult.enzyme_role){
            enzyme_role = (
                <a href={enz_link} className={css(styles.sites_link)}> {searchResult.enzyme_num} substrates </a>
            )
        }else{
            enzyme_role = (
                <div>

                </div>
            )
        }

        let substrate_role;
        if(searchResult.substrate_role){
            substrate_role = (
                <a href={enz_link} className={css(styles.sites_link)}> {searchResult.substrate_num} enzymes </a>
            )
        }else{
            substrate_role = (
                <div>

                </div>
            )
        }

        let ptmppi_role;
        if(searchResult.ptm_dependent_ppi_role){
            ptmppi_role = (
                <a href={enz_link} className={css(styles.sites_link)}> {searchResult.ptm_dependent_ppi_num} interactants </a>
            )
        }else{
            ptmppi_role = (
                <div>

                </div>
            )
        }

        const is_checked = this.state.selectedIDs.indexOf(searchResult.iptm_id) > -1

        let backGroundStyle;
        
        if((index + 1)%2){
            backGroundStyle = styles.evenRowBackground
        }else{
            backGroundStyle = styles.oddRowBackground
        }

        return (
          <div className={css(styles.searchResultRow,backGroundStyle)} key={searchResult.iptm_id} >
                     <div className={css(styles.iptm_id)} >
                        <input type="checkbox" style={{marginLeft: 10,marginRight: 10}} checked={is_checked} onClick={this.onIDClicked(searchResult.iptm_id)} />
                        <div>
                            <a href={id_link} target="_blank" className={css(styles.iptm_id_link)} >iPTM:{searchResult.iptm_id}/ {searchResult.uniprot_ac}</a>
                            <div className={css(styles.iptm_id_decorations)}>
                                <a href={ipro_link} target="_blank" className={css(styles.PRO_link)} ><img src="/images/ipc_icon.png"></img></a>
                                <a href={uniprot_link} target="_blank" className={css(styles.PRO_link)} ><img src="/images/sp_icon.png"></img></a>
                                <a href={pro_link} target="_blank" className={css(styles.PRO_link)} >PRO</a>
                            </div>
                        </div>
                     </div>

                     <div className={css(styles.protein_name)} >
                        {searchResult.protein_name}
                     </div>
                     
                     <div className={css(styles.gene_name)} >
                        <div>
                            Name: {searchResult.gene_name}  
                        </div>
                        <div>
                            Synonyms: {searchResult.synonyms.join(", ")}
                        </div>

                     </div>
                     
                     <div className={css(styles.organism)} >
                        <div>{searchResult.organism.species}</div>
                        <div>({searchResult.organism.common_name})</div>                        
                     </div>
                     
                     <div className={css(styles.substrate_role)} >
                        {substrate_role}
                     </div>
                     
                     <div className={css(styles.enzyme_role)} >
                        {enzyme_role}
                     </div>
                     
                     <div className={css(styles.ptm_dependent_ppi)} >
                        {ptmppi_role}
                     </div>
                     
                     <div className={css(styles.sites)} >
                        <a href={sub_link} className={css(styles.sites_link)}> {searchResult.sites}</a>
                     </div>
                     
                     <div className={css(styles.isoforms)} >
                        <a href={sub_link} className={css(styles.isoform_link)}>{searchResult.isoforms}</a>
                     </div>

          </div>
        )
    }

    private refresh = (query: string) => {
        this.setState({...this.state,status: RequestState.LOADING})
        let url;
        if(this.props.isBrowse !== undefined && this.props.isBrowse){
            url = `${host_url()}/browse?${query}`
        }else{
            url = `${host_url()}/search?${query}`
        }
        
        axios.get(url).then((res)=> {
            if(res.status === 200){
                const jsonConvert: JsonConvert = new JsonConvert();
                const searchResults = jsonConvert.deserializeArray(res.data,SearchResult);
                const totalCount = res.headers.count;
                const searchResultData = new SearchResultData(totalCount,searchResults);
                const state = {...this.state,status:RequestState.SUCCESS,data:searchResultData}
                if(this.props.onDataLoaded !== undefined){
                    this.props.onDataLoaded(totalCount);
                }
                this.setState(state);
            }else{
                const err = res.statusText + ":" + res.data;
                const state = {...this.state,status:RequestState.ERROR,error: err}
                this.setState(state);
            }    
        }).catch((err)=>{
            console.log(err)
            this.setState({...this.state,status: RequestState.ERROR,error:err.toString()})
        });
    }

    private onSelectAllIDClicked = (event: any) => {
        const ids: string[] = []
        if(event.target.checked){
            this.state.data.searchResults.forEach((result) => {
                ids.push(result.iptm_id)
            })
        }                
        const newState = {...this.state,selectedIDs: ids}
        this.setState(newState)
    }

    private onIDClicked = (id: string) => (event: any) => {
        const ids = this.state.selectedIDs
        if(event.target.checked){
            ids.push(id)
        }else{
            const index = ids.indexOf(id, 0);
            if (index > -1) {
                ids.splice(index, 1);
            }
        }                
        const newState = {...this.state,selectedIDs: ids}
        this.setState(newState)
    }

}

const styles = StyleSheet.create({
    loadingContainer: {
        alignSelf: "center",
        marginTop: "auto",
        marginBottom: "auto",
        display: "flex",
        flexDirection:"column",
        height: 140,
        alignItems: "center",
        color: "#b3b3b3ff",
        fontWeight: "bold"
    },

    loading: {
        alignSelf: "center",
        marginTop: "auto",
        marginBottom: "auto"
    },

    searchResultHeader: {
        backgroundColor: "#f6f6f6",
        fontWeight: "bold"
    },

    searchResultRow: {
        display: "flex",
        flexDirection: "row",
        alignItems: "center",
        paddingTop: 10,
        paddingBottom: 10,
        fontSize: "0.8em",
        ":hover": {
          backgroundColor: "#f6f6f6"
        }
    },

    evenRowBackground: {
        backgroundColor: "#ffffff"
    },

    oddRowBackground: {
        backgroundColor: "#f9f9f9ff"
    },

    bold: {
        fontWeight: "bold"
    },
  
    iptm_id: {
        display: "flex",
        flexDirection: "row",
        flex: 2.5 
    },

    iptm_id_link: {
        fontWeight: "bold",
        color: "#428bca",
        ":link": {
            textDecoration: "none"    
        },
        ":hover": {
            textDecoration: "underline"
        }
    },

    iptm_id_decorations: {
        display: "flex",
        flexDirection: "row",
        alignItems: "center",
        marginTop: 5
    },

    PRO_link: {
        color: "green",
        textAlign: "center",
        fontSize: "0.8em",
        marginLeft: 5,
        ":link": {
            textDecoration: "none"
        },
        ":hover": {
            backgroundColor: "lightgray",
        }
    },

    protein_name: {
    flex: 2,
    marginRight: 10,
    marginLeft: 8
    },

    gene_name: {
    flex: 2,
    marginRight: 10,
    marginLeft: 8
    },

    organism: {
        flex: 1.5,
        marginRight: "20",
        paddingLeft: "5"
    },

    organism_names: {
        display: "flex",
        flexDirection: "column",
        alignItems: "center"
    },

    substrate_role: {
    flex: 1,
    marginRight: 20,
    paddingLeft: 10
    },

    enzyme_role: {
    flex: 1,
    marginRight: 20,
    },

    ptm_dependent_ppi: {
    flex: 1.5,
    marginRight: 20,
    },

    sites: {
        flex: 0.5,
        marginRight: 20,
    },

    sites_link: {
        color: "#428bca",
        ":link" : {
            color: "#428bca",
            textDecoration: "none"
        },
        ":visited" : {
            color: "#428bca",
            textDecoration: "none"
        }
    },

    isoforms: {
        flex: 0.5,
        marginRight: 20,
    },

    isoform_link: {
        color: "#428bca",
        ":link" : {
            color: "#428bca",
            textDecoration: "none"
        },
        ":visited" : {
            color: "#428bca",
            textDecoration: "none"
        }
    },

})