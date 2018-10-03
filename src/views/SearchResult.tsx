import * as React from "react";
import { SearchResultState } from "src/redux/states/SearchResultState";
import { RequestState } from "../redux/states/RequestState";
import { css, StyleSheet } from 'aphrodite';
import axios from "axios";
import { JsonConvert } from "json2typescript/src/json2typescript/json-convert";
import SearchResult from "src/models/SearchResult";
import { SearchResultData } from "src/models/SearchResultData";
import {CubeGrid} from 'better-react-spinkit'

interface ISearchResultsProps {
    url: string
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
        this.refresh();
    }

    public async componentWillReceiveProps(nextProps: ISearchResultsProps) {
        if(nextProps.url !== this.props.url){
            this.refresh();
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
            <div className={css(styles.loading)} >
                 <CubeGrid color="#329CDA"
                       size={60}
                       />
            </div>
        )
    }

    private renderTable = (results: SearchResult[]) => {
        
        const header = this.renderHeader()
        const renderedRows = results.map(this.renderRow)

        return (
            <div>
                {header}
                {renderedRows}
            </div>
        )
    }

    private renderHeader() {
        return (
          <div className={css(styles.searchResultRow,styles.bold)} >
                     <div className={css(styles.iptm_id)} >
                        <input type="checkbox" style={{marginLeft: 10,marginRight: 10}}  />
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
    
    private renderRow(searchResult: SearchResult) {
        return (
          <div className={css(styles.searchResultRow)} >
                     <div className={css(styles.iptm_id)} >
                        <input type="checkbox" style={{marginLeft: 10,marginRight: 10}}  />
                        {searchResult.iptm_id}
                     </div>

                     <div className={css(styles.protein_name)} >
                        {searchResult.protein_name}
                     </div>
                     
                     <div className={css(styles.gene_name)} >
                        {searchResult.gene_name}
                     </div>
                     
                     <div className={css(styles.organism)} >
                        {searchResult.organism.common_name}
                     </div>
                     
                     <div className={css(styles.substrate_role)} >
                        {searchResult.substrate_role}
                     </div>
                     
                     <div className={css(styles.enzyme_role)} >
                        {searchResult.enzyme_role}
                     </div>
                     
                     <div className={css(styles.ptm_dependent_ppi)} >
                          PTM-dependent PPI
                     </div>
                     
                     <div className={css(styles.sites)} >
                        {searchResult.sites}
                     </div>
                     
                     <div className={css(styles.isoforms)} >
                        {searchResult.isoforms}
                     </div>

          </div>
        )
    }

    private refresh = () => {
        this.setState({...this.state,status: RequestState.LOADING})
        axios.get(`https://research.bioinformatics.udel.edu/iptmnet/api/browse?term_type=All&role=Enzyme%20or%20Substrate&start_index=0&end_index=28`).then((res)=> {
            if(res.status === 200){
                const jsonConvert: JsonConvert = new JsonConvert();
                const searchResults = jsonConvert.deserializeArray(res.data,SearchResult);
                const totalCount = res.headers.count;
                const searchResultData = new SearchResultData(totalCount,searchResults);
                const state = {...this.state,status:RequestState.SUCCESS,data:searchResultData}
                this.setState(state);
            }else{
                const err = res.statusText + ":" + res.data;
                const state = {...this.state,status:RequestState.ERROR,error: err}
                this.setState(state);
            }    
        }).catch((err)=>{
            this.setState({...this.state,status: RequestState.ERROR,error:err.toString()})
        });
    }

}

const styles = StyleSheet.create({
    loading: {
        alignSelf: "center",
        marginTop: "auto",
        marginBottom: "auto"
    },

    searchResultRow: {
        display: "flex",
        flexDirection: "row",
        alignItems: "center",
        paddingTop: 10,
        paddingBottom: 10,
        fontSize: "0.9em",
        ":hover": {
          backgroundColor: "#ededed"
        }
    },

    bold: {
        fontWeight: "bold"
    },
  
    iptm_id: {
    display: "flex",
    flexDirection: "row",
    flex: 2 
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

    isoforms: {
    flex: 0.5,
    marginRight: 20,
    },

})