import * as React from "react";
import { State } from "src/redux/state";
import { connect } from "react-redux";
import { RequestState} from "src/redux/states/RequestState";
import ReactTable from "react-table";
import 'react-table/react-table.css'
import { BatchEnzyme } from "src/models/BatchEnzyme";
import { buildSources, renderScore, buildPMIDs } from "src/views/Utils";
import { css,StyleSheet} from 'aphrodite';
import Navbar from "src/views/Navbar";
import Footer from "src/views/Footer";

interface IBatchResultEnzymeProps {
    status: RequestState
    error: string
    with_enzyme: BatchEnzyme[]
    without_enzyme: BatchEnzyme[] 
}

export class BatchResultEnzyme extends React.Component<IBatchResultEnzymeProps> {
    
    constructor(props: IBatchResultEnzymeProps) {
       super(props);
    }
    
    public render() {

        let content;
        
        if(this.props.status === RequestState.SUCCESS){
            content = this.renderSuccess();
        }
        else if(this.props.status === RequestState.LOADING) {
            content = this.renderLoading();
        }else if(this.props.status === RequestState.ERROR) {
            content = this.renderError();
        }else {
            content = (<div>
                Nothing here
            </div>);
        }

        return (
            <div id="page" className={css(styles.page)}  >
                <div id="div_header" >
                    <Navbar/>
                </div>
                <div id="content" className={css(styles.content)} >
                    {content}
                </div>
                <Footer />
            </div>
        );
    }

    private renderSuccess = () => {
        return (
            <div >
                <h3>
                    PTM with Enzyme
                </h3>
                <div className={css(styles.table)} >
                    <ReactTable className="-striped -highlight"
                        data={this.props.with_enzyme}
                        pageSize={this.props.with_enzyme.length}
                        columns={columns}
                        showPagination={false}
                        minRows={undefined}
                    />
                </div>
                <h3>
                    PTM without Enzyme
                </h3>
                <div className={css(styles.table)} >
                    <ReactTable className="-striped -highlight"
                        data={this.props.without_enzyme}
                        pageSize={this.props.without_enzyme.length}
                        columns={columns}
                        showPagination={false}
                        minRows={undefined}
                    />
                </div>
            </div>
        );
    }

    private renderLoading = () => {
        return (
            <div>
                
            </div>
        );
    }

    private renderError = () => {
        return (
            <div>
                
            </div>
        );
    }
}

const mapStateToProps = (state: State) => ({
    status: state.batchPage.enzymes.status,
    with_enzyme: state.batchPage.enzymes.data.filter((enzyme)=>{
        return enzyme.enzyme.uniprot_id !== "";
    }),
    without_enzyme: state.batchPage.enzymes.data.filter((enzyme) => {
        return enzyme.enzyme.uniprot_id === "";
    }),
    error: state.batchPage.enzymes.error
});
    
export const BatchResultEnzymeConnected = connect(mapStateToProps,{})(BatchResultEnzyme);

const styles = StyleSheet.create({
    page : {
      minHeight: "100vh",
      display: "grid",
      alignItems: "center",
      flex: "1",
      backgroundColor: "#ffffffff",
      gridTemplateRows: "min-content 1fr min-content",
      "align-items": "start",
    },

    table : {
        marginTop: "20px",
        marginBottom: "40px",
        fontSize: "0.8em", 
        "overflow-wrap": "break-word"
    },

    content: {
        marginLeft: 10,
        marginRight: 10,
    },

    column: {
        wordBreak: "break-all",
        whiteSpace: "unset"
    }

})

const columns = [
    {
      accessor: 'ptm_type',
      Header: 'PTM Type'
    },
    {
      id: "substrate",  
      accessor: (enzyme : BatchEnzyme)  => {
          return enzyme.substrate;
      },
      Header: 'Substrate',
      Cell: (props: any) => {
          return (
              <div>
                  <a href="#">{props.value.uniprot_id}</a> ({props.value.name})
              </div>
          );
      }
    },
    {
      accessor: 'site',
      Header: 'Site'
    },
    {
      id: "enzyme",  
      accessor: (enzyme : BatchEnzyme)  => {
          return enzyme.enzyme;
      },
      Header: 'Enzyme',
      className: css(styles.column),
      minWidth: 150,
      Cell: (props: any) => {
          let content;
          if(props.value.uniprot_id === ""){
                content = (<div>

                </div>);
          }else{
                content = (
                    <div className={css(styles.column)} >
                        <a href="#">{props.value.uniprot_id}</a> ({props.value.name})
                    </div>
                ); 
          }
          return (
              <div> 
                {content}
              </div>
          );
      }
    },
    {
      accessor: 'score',
      Header: 'Score',
      Cell: (props: any) => {
          return (
              <div>
                  {renderScore(props.value)}
              </div>
          );
      }
    },
    {
      accessor: 'source',
      Header: 'Source',
      minWidth: 150,
      className: css(styles.column),
      Cell: (props: any) => {
          return (
              <div>
                  {buildSources(props.value)}
              </div>
          );
      }
    },
    {
      accessor: 'pmids',
      Header: 'PMID',
      Cell: (props: any) => {
          return (
              <div style={{display: "inline-block"}} >
                  {buildPMIDs(props.value)}
              </div>
          );
      }
    },
  
  ];



