import * as React from 'react';
import { css,StyleSheet,minify } from 'aphrodite';
import Navbar from '../views/Navbar';
import Footer from '../views/Footer';
import { BatchPageState } from 'src/redux/states/BatchPageState';
import { Kinase } from 'src/models/Kinase';

minify(false);

class Batch extends React.Component<{},BatchPageState> {

  constructor(props:{}) {
    super(props);
    this.state = new BatchPageState();
  }

  public render() {
    return (
      <div id="div_page" className={css(styles.page)} >
        
        <div id="div_header" className={css(styles.header)} >
          <Navbar/>
        </div>

        <div id="div_body" className={css(styles.body)} >
          <div className={css(styles.title)} >
            iPTMnet Batch Retrieval
          </div>
          <div>
            Use this page to retrieve information from the iPTMnet on PTM Enzyme-Site relation, and PTM-dependent PPIs.
          </div>
          <div id="content" className={css(styles.content)} >
              <div id="input_section" className={css(styles.input_section)} >
                <div style={{
                  fontWeight: "bold",
                  fontSize: 18,
                  marginTop: 30
                }} >
                  1. Input
                </div>
                
                <textarea id="events_textarea" className={css(styles.events_textarea)} value={this.kinasesToText(this.state.kinases)} >
                 </textarea>

                <div id="div_buttons" className={css(styles.div_buttons)} >
                  <div className={css(styles.clearButton,styles.noselect)} onClick={this.onClearClicked()}>
                      Clear
                  </div>
                  <div className={css(styles.inputExamplesButton,styles.noselect)} onClick={this.onInputExamplesClicked()}>
                      Input Examples
                  </div>
                </div>

                <div style={{ 
                              alignSelf: "center",
                              marginTop: 30,
                              marginBottom: 30,
                              fontSize: 20  
                            }}>
                  or
                </div>

                <div id="div_file_chooser" className={css(styles.divFileChooser)} >
                  <div className={css(styles.btnChooseFile,styles.noselect)} >
                      Choose file
                  </div>
                  <div className={css(styles.fileName)} >
                      No file choosen
                  </div>
                </div>

                <div style={{
                  fontWeight: "bold",
                  fontSize: 18,
                  marginTop: 30
                }} >
                  2. Select Output
                </div>

                <label id="lbl_ptm_enzyme">
                  <input id = "rb_ptm_enzyme"
                      type="radio"
                      name="output" 
                      value="ptm_enzyme"
                      className={css(styles.outputRadioButton)}
                      />
                      PTM Enzymes
                </label>

                <label id="lbl_ptm_dep_ppi">
                  <input id = "rb_ptm_dep_ppi"
                      type="radio"
                      name="output" 
                      value="ptm_dep_ppi"
                      className={css(styles.outputRadioButton)}
                      />
                      PTM Dependent PPI
                </label>
                
                <div className={css(styles.btnSubmit,styles.noselect)} >
                  Submit
                </div>

              </div>
              
          </div>
          <div id="filer" className={css(styles.filer)} />

        </div>

        <Footer />
                 
      </div>
    ); 
  }

  private onInputExamplesClicked = () => (event: any) => {
    const newState = {...this.state,kinases: BatchPageState.defaultKinases()}
    this.setState(newState);
  }

  private onClearClicked = () => (event: any) => {
    const newState = {...this.state,kinases: []}
    this.setState(newState);
  }

  private kinasesToText(kinases: Kinase[]): string {
    let kinaseText = "";
    for (const kinase of kinases) {
      if (kinaseText === "") {
        kinaseText = kinase.substrate_ac + "," + kinase.residue + "," + kinase.position
      }else{
        kinaseText = kinaseText + "\n" + kinase.substrate_ac + "," + kinase.residue + "," + kinase.position
      }
    }
    return kinaseText;
  }
}

const styles = StyleSheet.create({
  page : {
    minHeight: "100%",
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    flex: "1",
    backgroundColor: "#ffffffff"
  },

  header : {
    display: "flex",
    flexDirection: "column",
    alignSelf: "stretch"
  },

  body: {
    display: "flex",
    flexDirection: "column",
    "flex-grow": "1",
    paddingTop: "20",
    overflow: "auto",
    paddingLeft: 30,
    paddingRight: 30,
    alignSelf: "stretch"
  },

  title: {
    marginTop: 40,
    fontSize: 24,
    fontWeight: "bold",
    alignSelf: "flex-start",
    marginBottom: 10
  },

  content: {
    display: "flex",
    flexDirection: "row"
  },

  input_section: {
    display: "flex",
    flexDirection: "column",
    minWidth: "20%"
  },

  events_textarea: {
    marginTop: 10,
    minHeight: 200,
    minWidth: "80%"
  },

  div_buttons: {
    display: "flex",
    flexDirection: "row",
    marginTop: 10
  },

  filer: {
    alignSelf: "stretch"
  },

  clearButton: {
    paddingLeft: 10,
    paddingRight: 10,
    paddingTop: 5,
    paddingBottom: 5,
    marginLeft: "5",
    textAlign: "center",
    fontSize: 14,
    backgroundColor: "#329CDA",
    color: "#fbfbfb",
    borderStyle: "solid",
    borderRadius: 20,
    borderWidth: 1,
    borderColor: "#efefef",
    ":hover": {
        cursor: "pointer",
        backgroundColor: "#2594d7ff",
        color: "#fbfbfb"
    },
    ":focus": {
        outline: "none"
    }
  },

  inputExamplesButton: {
    paddingLeft: 10,
    paddingRight: 10,
    paddingTop: 5,
    paddingBottom: 5,
    marginLeft: "auto",
    marginRight: 5,
    textAlign: "center",
    fontSize: 14,
    backgroundColor: "#329CDA",
    color: "#fbfbfb",
    borderStyle: "solid",
    borderRadius: 20,
    borderWidth: 1,
    borderColor: "#efefef",
    ":hover": {
        cursor: "pointer",
        backgroundColor: "#2594d7ff",
        color: "#fbfbfb"
    },
    ":focus": {
        outline: "none"
    }
  },

  divFileChooser: {
    display: "flex",
    flexDirection: "row",
    marginTop: 10
  },

  btnChooseFile: {
    paddingLeft: 10,
    paddingRight: 10,
    paddingTop: 5,
    paddingBottom: 5,
    marginLeft: "5",
    textAlign: "center",
    fontSize: 14,
    backgroundColor: "#329CDA",
    color: "#fbfbfb",
    borderStyle: "solid",
    borderRadius: 20,
    borderWidth: 1,
    borderColor: "#efefef",
    ":hover": {
        cursor: "pointer",
        backgroundColor: "#2594d7ff",
        color: "#fbfbfb"
    },
    ":focus": {
        outline: "none"
    }
  },

  fileName: {
    marginTop: "auto",
    marginBottom: "auto",
    marginLeft: 20,
    fontSize: 14,
    color: "#999999ff"
  },

  outputRadioButton: {
    marginLeft: 20,
    marginTop: 10
  },

  btnSubmit: {
    paddingLeft: 15,
    paddingRight: 15,
    paddingTop: 10,
    paddingBottom: 10,
    marginTop: 30,
    marginLeft: "auto",
    marginRight: "auto",
    textAlign: "center",
    fontSize: 18,
    backgroundColor: "#329CDA",
    color: "#fbfbfb",
    borderStyle: "solid",
    borderRadius: 25,
    borderWidth: 1,
    borderColor: "#efefef",
    ":hover": {
        cursor: "pointer",
        backgroundColor: "#2594d7ff",
        color: "#fbfbfb"
    },
    ":focus": {
        outline: "none"
    }
  },

  noselect: {
    "-webkit-touch-callout": "none", /* iOS Safari */
      "-webkit-user-select": "none", /* Safari */
       "-khtml-user-select": "none", /* Konqueror HTML */
         "-moz-user-select": "none", /* Firefox */
          "-ms-user-select": "none", /* Internet Explorer/Edge */
              "user-select": "none", /* Non-prefixed version, currently
                                    supported by Chrome and Opera */
}


});

export default Batch;