import * as React from "react";
import { State } from "src/redux/state";
import { connect } from "react-redux";
import { RequestState} from "src/redux/states/RequestState";
import ReactTable from "react-table";
import 'react-table/react-table.css'
import { buildPMIDs, buildSource } from "src/views/Utils";
import { css,StyleSheet} from 'aphrodite';
import Navbar from "src/views/Navbar";
import Footer from "src/views/Footer";
import { BatchPTMPPI } from "src/models/BatchPTMPPI";
import TabBar, { Tab } from "src/views/TabBar";

interface IBatchResultPPIProps {
    status: RequestState
    error: string
    with_interacant: BatchPTMPPI[]
    without_interactant: BatchPTMPPI[] 
}

export class BatchResultPPI extends React.Component<IBatchResultPPIProps> {
    
    constructor(props: IBatchResultPPIProps) {
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

        const tabs = [
            new Tab("PTM Dependent PPIs",this.props.with_interacant.length),
            new Tab("Sites without interactants",this.props.without_interactant.length),
            new Tab("Input site not found in iPTMnet",0)
        ]

        return (
            <div >
                <div className={css(styles.tabBarContainer)} >
                    <TabBar tabs={tabs} />
                </div>

                <div className={css(styles.table)} >
                    <ReactTable className="-striped -highlight"
                        data={this.props.with_interacant}
                        pageSize={this.props.with_interacant.length}
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
    status: state.batchPage.ppi.status,
    with_interacant: state.batchPage.ppi.data.filter((enzyme)=>{
        return enzyme.interactant.uniprot_id !== "";
    }),
    without_interactant: state.batchPage.ppi.data.filter((enzyme) => {
        return enzyme.interactant.uniprot_id === "";
    }),
    error: state.batchPage.ppi.error
});
    
export const BatchResultPPIConnected = connect(mapStateToProps,{})(BatchResultPPI);

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
    },

    tabBarContainer: {
        display: "flex",
        flexDirection: "row",
        marginTop: 20
    }

})

const columns = [
    {
      accessor: 'ptm_type',
      Header: 'PTM Type'
    },
    {
      id: "substrate",  
      accessor: (enzyme : BatchPTMPPI)  => {
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
      id: "interactant",  
      accessor: (enzyme : BatchPTMPPI)  => {
          return enzyme.interactant;
      },
      Header: 'Interactant',
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
      accessor: 'source',
      Header: 'Source',
      minWidth: 150,
      className: css(styles.column),
      Cell: (props: any) => {
          return (
              <div>
                  {buildSource(props.value)}
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



