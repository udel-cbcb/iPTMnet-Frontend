import * as React from 'react';
import { css, StyleSheet } from 'aphrodite';
import Navbar from '../views/Navbar';
import Footer from 'src/views/Footer';

class Browse extends React.Component {
  public render() {
    return (
      <div id="page" className={css(styles.page)} >
        <Navbar/>
        <div id="body" className={css(styles.body)} >
          <div id="sidebar_container" className={css(styles.sidebarContainer)} >
            <div id="sidebar" className={css(styles.sidebar)} >
            <div id="div_ptm" className={css(styles.ptm)} >
                    <div id="div_ptm_header" className={css(styles.sectionHeaderContainer)} >
                        <div id="ptm_label" className={css(styles.headerLabel)} >
                            PTM type
                        </div>
                    </div>

                    <button id="btn_all_ptm" className={css(styles.selectorButton)} onClick={this.onPTMAllClick}  >
                            All
                        </button>
                    <button id="btn_none_ptm" className={css(styles.selectorButton, styles.noneButton)} onClick={this.onPTMNoneClick} >
                        None
                    </button>

                    <div id="ptm_type_selection" className={css(styles.ptmTypeSelection)}  >
                                               

                        <div id="ptm_column" className={css(styles.column)} >
                            <label id="lbl_acetylation"  >
                                <input type="checkbox" className={css(styles.checkBox)} checked={this.isPTMSelected("Acetylation")} 
                                    onClick={this.onPTMClick("Acetylation")}
                                />
                                Acetylation
                            </label>
                            <label id="lbl_n_lycosylation"  >
                                <input type="checkbox" className={css(styles.checkBox)} checked={this.isPTMSelected("N-Glycosylation")}
                                    onClick={this.onPTMClick("N-Glycosylation")}
                                />
                                N-Glycosylation
                            </label>
                            <label id="lbl_o_lycosylation"  >
                                <input type="checkbox" className={css(styles.checkBox)} checked={this.isPTMSelected("O-Glycosylation")}
                                    onClick={this.onPTMClick("O-Glycosylation")}
                                />
                                O-Glycosylation
                            </label>
                            <label id="lbl_c_glycosylation"  >
                                <input type="checkbox" className={css(styles.checkBox)} checked={this.isPTMSelected("C-Glycosylation")}
                                    onClick={this.onPTMClick("C-Glycosylation")}
                                />
                                C-Glycosylation
                            </label>

                            <label id="lbl_s_glycosylation"  >
                                <input type="checkbox" className={css(styles.checkBox)} checked={this.isPTMSelected("S-Glycosylation")} 
                                    onClick={this.onPTMClick("S-Glycosylation")}
                                />
                                S-Glycosylation
                            </label>
                            <label id="lbl_methylation"  >
                                <input type="checkbox" className={css(styles.checkBox)} checked={this.isPTMSelected("Methylation")}
                                    onClick={this.onPTMClick("Methylation")}
                                />
                                Methylation
                            </label>
                            <label id="lbl_c_myristoylation"  >
                                <input type="checkbox" className={css(styles.checkBox)} checked={this.isPTMSelected("Myristoylation")}
                                    onClick={this.onPTMClick("Myristoylation")}
                                />
                                Myristoylation
                            </label>
                            <label id="lbl_c_phosphorylation"  >
                                <input type="checkbox" className={css(styles.checkBox)} checked={this.isPTMSelected("Phosphorylation")}
                                    onClick={this.onPTMClick("Phosphorylation")}
                                />
                                Phosphorylation
                            </label>

                            <label id="lbl_s_sumoylation"  >
                                <input type="checkbox" className={css(styles.checkBox)} checked={this.isPTMSelected("Sumoylation")}
                                    onClick={this.onPTMClick("Sumoylation")}
                                />
                                Sumoylation
                            </label>
                            <label id="lbl_ubiquitination"  >
                                <input type="checkbox" className={css(styles.checkBox)} checked={this.isPTMSelected("Ubiquitination")}
                                    onClick={this.onPTMClick("Ubiquitination")}
                                />
                                Ubiquitination
                            </label>
                            <label id="lbl_s_nitrosylation"  >
                                <input type="checkbox" className={css(styles.checkBox)} checked={this.isPTMSelected("S-Nitrosylation")}
                                    onClick={this.onPTMClick("S-Nitrosylation")}
                                />
                                S-Nitrosylation
                            </label>

                        </div>                        
                    </div>
                </div>
            </div>
          </div>

          <div id="content" className={css(styles.content)}  >
            
          </div>        
          
        </div>

        <div id="filer" style={{minHeight: "50px"}} >

        </div>

        <Footer /> 
      </div>
    );
  }

  private isPTMSelected = (ptmName: string) => {
    return false;
}

private onPTMAllClick = () => {
    return false;
}

private onPTMClick = (ptmName: string) => () => {
    console.log(ptmName);
}

private onPTMNoneClick = () => {
    console.log("clicked");   
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
    position: "fixed",
    margin: 20,
    "min-width": "15%",
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
  },

  column: {
    display: "flex",
    flexDirection: "column",
    alignSelf: "stretch"
  },

  checkBox: {
    marginTop: 15,
    marginRight: 10
  },

  ptm : {
    display: "flex",
    flexDirection: "column",
    alignSelf: "stretch"
  },

  ptmTypeSelection: {
    display: "flex",
    flexDirection: "row",
    marginLeft: "5px",
    marginRight: "5px",
    marginTop: "5px",
    alignSelf: "stretch",
    justifyContent: "space-between"
  },

  sectionHeaderContainer : {
    display: "flex",
    flexDirection: "row",
    alignSelf: "stretch"
  },

  headerLabel : {
    fontWeight: "bold",
    color: "##232323ff",
    alignSelf: "stretch"
  },

  selectorButton : {
      marginLeft: "auto",
      fontSize: "0.85em",
      paddingTop: 2,
      paddingBottom: 2,
      paddingLeft: 15,
      paddingRight: 15,
      backgroundColor: "transparent",
      color: "#606060ff",
      borderStyle: "solid",
      borderRadius: 50,
      borderWidth: 1,
      borderColor: "#329CDA",
      ":hover": {
          cursor: "pointer",
          backgroundColor: "#329CDA",
          color: "#fbfbfb"
      },
      ":focus": {
          outline: "none"
      }
  },

  noneButton: {
      marginLeft: "20px"
  },
  
});


export default Browse;
