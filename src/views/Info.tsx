import * as React from 'react';
import { css,StyleSheet,minify } from 'aphrodite';
import { InfoState } from 'src/redux/states/InfoState';
import { RequestState } from '../redux/states/RequestState';
import Error from './Error';
import { State } from 'src/redux/state';
import { Dispatch, bindActionCreators } from 'redux';
import { connect } from 'react-redux';


minify(false);

interface IInfoProps {
    info: InfoState;
}

class Info extends React.Component<IInfoProps,{}> {

    constructor(props: IInfoProps) {
        super(props);
    }  

    public render() {
        if(this.props.info.status === RequestState.SUCCESS){
            return (
                <div id="div_info" className={css(styles.divInfo)}>
                    <h2 id="entry_header" className={css(styles.entryHeader)}  >
                        {`iPTMnet Report for ${this.props.info.data.uniprot_ac} ${this.props.info.data.gene_name} `}
                    </h2>
                    {this.renderInfoTable()}
                    {this.renderProTable()}                        
                </div>
            );
        }else{
            return (
                <div id="div_info" className={css(styles.divInfo)}>
                    <h2 id="entry_header" className={css(styles.entryHeader)}  >
                        {`iPTMnet Report for error `}
                    </h2>
                    <div>
                        <Error id="error" ></Error>
                    </div>
                </div>
            );
        }
    }
    
    private renderInfoTable() {
        return (
            <div id="info_table" className={css(styles.geneInfoTable)} >
                {/*uniprot_ac*/ }
                <div className={css(styles.tableRow)}>
                    <span className={css(styles.tableKey)}>
                        UniProt AC / UniProt ID
                    </span>
                    <span className={css(styles.tableValue)} >
                        <a href={`http://www.uniprot.org/uniprot/${this.props.info.data.uniprot_ac}`} target="_">
                            {this.props.info.data.uniprot_ac}
                        </a>
                        {` / ${this.props.info.data.uniprot_id}`}
                    </span>
                </div>

                {/*protein_name*/ }
                <div className={css(styles.tableRow)}>
                    <span className={css(styles.tableKey)}>
                        Protein Name
                    </span>
                    <span className={css(styles.tableValue)} >
                        {this.props.info.data.protein_name.replace(";","")}
                    </span>
                </div>

                {/*Gene name*/ }
                <div className={css(styles.tableRow)}>
                    <span className={css(styles.tableKey)}>
                        Gene Name
                    </span>
                    <span className={css(styles.tableValue)} >
                        {`Name: ${this.props.info.data.gene_name}`}
                        <br/>
                        {`Synonymns: ${this.props.info.data.synonyms.join(", ")}`}
                    </span>
                </div>

                {/*organism*/ }
                <div className={css(styles.tableRow)}>
                    <span className={css(styles.tableKey)}>
                        Organism
                    </span>
                    <span className={css(styles.tableValue)} >
                        {this.props.info.data.organism.common_name}
                    </span>
                </div>
            </div>
        );       
    }

    private renderProTable() {
        if(this.props.info.data.pro){
            return (
                <div id="info_table" className={css(styles.proInfoTable)} >
                    {/*pro id*/ }
                    <div className={css(styles.tableRow)}>
                        <span className={css(styles.tableKey)}>
                            PRO ID
                        </span>
                        <span className={css(styles.tableValue)} >
                            <a href={`http://purl.obolibrary.org/obo/PR_${this.props.info.data.pro.id}`} target="_">
                                {this.props.info.data.pro.id}
                            </a>
                        </span>
                    </div>

                    {/*pro name*/ }
                    <div className={css(styles.tableRow)}>
                        <span className={css(styles.tableKey)}>
                            PRO Name
                        </span>
                        <span className={css(styles.tableValue)} >
                            {this.props.info.data.pro.name}
                        </span>
                    </div>

                    {/*Definition*/ }
                    <div className={css(styles.tableRow)}>
                        <span className={css(styles.tableKey)}>
                            Definition
                        </span>
                        <span className={css(styles.tableValue)} >
                            {`${this.props.info.data.pro.definition}`}
                        </span>
                    </div>

                    {/*short label*/ }
                    <div className={css(styles.tableRow)}>
                        <span className={css(styles.tableKey)}>
                            Short Label
                        </span>
                        <span className={css(styles.tableValue)} >
                            {this.props.info.data.pro.short_label}
                        </span>
                    </div>

                    {/*category*/ }
                    <div className={css(styles.tableRow)}>
                        <span className={css(styles.tableKey)}>
                            Category
                        </span>
                        <span className={css(styles.tableValue)} >
                            {this.props.info.data.pro.category}
                        </span>
                    </div>


                </div>             
            );
        }else{
            return (<div></div>);
        }
    }

}

const styles = StyleSheet.create({
  divInfo: {
      display: "flex",
      flexDirection: "column"
  },

  entryHeader: {
    borderBottomWidth: 1,
    borderBottomStyle: "solid",
    borderBottomColor: "rgb(225, 225, 232)",
    paddingBottom: 10,
    fontSize: "2.5em",
    fontWeight: "normal",
    alignSelf: "stretch"
  },

  geneInfoTable: {
    marginTop : 20,
    fontSize: "0.9em",
    display: "flex",
    flexDirection: "column"
  },

  proInfoTable: {
    marginTop : 40,
    fontSize: "0.9em",
    display: "flex",
    flexDirection: "column"
  },

  tableRow: {
    display: "flex",
    flexDirection: "row"
  },

  tableKey: {
    flex: 1.5,
    borderBottomWidth: 1,
    borderBottomStyle: "solid",
    borderBottomColor: "rgb(225,225,232)"  
  },

  tableValue: {
    flex: 8,
    borderLeftWidth: 1,
    borderLeftStyle: "solid",
    borderLeftColor: "rgb(225,225,232)",
    borderBottomWidth: 1,
    borderBottomStyle: "solid",
    borderBottomColor : "rgb(225,225,232)",
    padding: "0.2em",
    paddingLeft: "1.0em" 
  }

});

const mapStateToProps = (state: State) => ({
    info: state.entryPage.info,
});
  
const mapDispatchToProps = (dispatch: Dispatch) => bindActionCreators({}, dispatch);
  
export const InfoConnected = connect(mapStateToProps, mapDispatchToProps)(Info);

export default Info;
