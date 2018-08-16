import * as React from 'react';
import Navbar from '../views/Navbar';
import { InfoConnected } from '../views/Info';
import { css, StyleSheet } from 'aphrodite';
import { scrollToElement } from '../misc/Utils';
import SequenceViewer from '../views/SequenceViewer';

interface IEntryProps {
  id: string;
}

class Entry extends React.Component<IEntryProps,{}> {

  constructor(props: IEntryProps) {
    super(props);
    this.componentDidMount = this.componentDidMount.bind(this);
  }

  public componentDidMount() {
      document.title = "Report : " + this.props.id;
  }
  
  public render() {
    return (
      <div id="page" className={css(styles.page)} >
        <Navbar/>
        <div id="body" className={css(styles.body)} >
          <div id="sidebar_container" className={css(styles.sidebarContainer)} >
            <div id="sidebar" className={css(styles.sidebar)} >
              <div id="display" className={css(styles.display)} >
                  Display
              </div>
              <div id="option_protein_info" className={css(styles.option)} onClick={this.onOptionClick}  >
                Protein Information
              </div>

              <div id="option_sequence_viewer" className={css(styles.option)} onClick={this.onOptionClick}  >
                Interactive Sequence Viewer
              </div>

              <div id="option_substrate" className={css(styles.option)} onClick={this.onOptionClick}  >
                Substrate
              </div>

              <div id="option_proteoforms" className={css(styles.option)} onClick={this.onOptionClick}  >
                Proteoforms
              </div>

              <div id="option_ptm_dependent_ppi" className={css(styles.option)} onClick={this.onOptionClick}  >
                PTM Dependent PPI
              </div>

              <div id="option_proteoform_ppi" className={css(styles.option)} onClick={this.onOptionClick}  >
                Proteoform PPI
              </div>

              <div id="option_back_to_top" className={css(styles.option)} onClick={this.onOptionClick}  >
                Back to top
              </div>

            </div>
          </div>

          <div id="content" className={css(styles.content)}  >
            <InfoConnected/>
            <SequenceViewer/> 
          </div>
          
        </div> 
      </div>
    );
  }

  private onOptionClick = (event: any) => {
      if(event.target.id === "option_protein_info" || event.target.id === "option_back_to_top" ){
        scrollToElement("div_info")
      }else if(event.target.id === "option_sequence_viewer") {
        scrollToElement("sequence_viewer")
      }
  }



}

const styles = StyleSheet.create({
  page:{
    display: "flex",
    flexDirection: "column",
    "min-height": "100%"
  }, 
  
  body: {
    display: "flex",
    flexDirection: "row",
    flex: 1,
    "min-width": "100%",
    "max-width": "100%"
  },

  sidebarContainer: {
    display: "flex",
    flexDirection: "column",
    "min-width": "20%",
    "max-width": "20%"
  },

  content: {
    display: "flex",
    flexDirection: "column",
    "width": "80%",
    "max-width": "80%",
    paddingRight: 20
  },
 
  sidebar: {
    display: "flex",
    flexDirection: "column",
    margin: 20,
    backgroundColor: "#ecececff",
    marginRight: "10%"
  },

  display: {
    fontWeight: "bold",
    padding: 10
  },

  option: {
    paddingLeft: 25,
    paddingRight: 10,
    paddingTop: 10,
    paddingBottom: 10,
    fontSize: "0.85em",
    flex : 1,
    ":hover": {
        cursor: "pointer",
        backgroundColor: "#0000000D"
    },
    textDecoration: "none",
    color: "#000000"
  }
  
});

export default Entry;
