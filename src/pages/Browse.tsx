import * as React from 'react';
import { css, StyleSheet } from 'aphrodite';
import Navbar from '../views/Navbar';
import Footer from 'src/views/Footer';
import { BrowsePageState } from 'src/redux/states/BrowsePageState';
import { Role } from 'src/models/Role';
import axios from "axios";
import Spinner from "react-spinkit"
import { RequestState } from "../redux/states/RequestState";
import { JsonConvert } from 'json2typescript/src/json2typescript/json-convert';
import SearchResult from '../models/SearchResult';
import { SearchResultData } from '../models/SearchResultData';

class Browse extends React.Component<{},BrowsePageState> {

  constructor(props: {}){
      super(props);
      this.state = new BrowsePageState();
  }


  public render() {
    return (
      <div id="page" className={css(styles.page)} >
        <Navbar/>
        <div id="body" className={css(styles.body)} >
          <div id="sidebar_container" className={css(styles.sidebarContainer)} >
            <div id="sidebar" className={css(styles.sidebar)} >
                <div className={css(styles.browseButton)} onClick={this.onBrowseClick} >
                    Browse
                </div>
                {this.renderPTMSelection()}
                {this.renderRoleSelection()}
                {this.renderMiscSelection()}
                {this.renderOrganismSelection()}
            </div>
          </div>

          <div id="content" className={css(styles.content)}  >
                {this.renderLoading()}
          </div>        
          
        </div>

        <div id="filer" style={{minHeight: "50px"}} >

        </div>

        <Footer /> 
      </div>
    );
  }

  private renderLoading = () => {
      return (
          <div className={css(styles.loading)} >
                <Spinner name="line-scale" color="#329CDA"/>
          </div>
      )
  }

  private renderPTMSelection = () => {
      return (
          <div id="div_ptm" className={css(styles.ptm)} >
              <div id="div_ptm_header" className={css(styles.sectionHeaderContainer)} >
                  <div id="ptm_label" className={css(styles.headerLabel)} >
                      PTM type
                  </div>
                  <div id="ptm_open" className={css(styles.dropdownButton)} onClick={this.onPTMDropdownClick}  >
                    {
                      this.state.isPTMExpanded? '\uf10d' : '\uf104'
                    }
                  </div>
              </div>

              <div id="ptm_buttons" className={css(this.state.isPTMExpanded? styles.ptmButtons: styles.hidden)} >
                <button id="btn_all_ptm" className={css(styles.selectorButton)} onClick={this.onPTMAllClick}  >
                    All
                </button>
                <button id="btn_none_ptm" className={css(styles.selectorButton, styles.noneButton)} onClick={this.onPTMNoneClick} >
                    None
                </button>  
              </div>
            
              <div id="ptm_type_selection" className={css(this.state.isPTMExpanded? styles.ptmTypeSelection: styles.hidden)}>
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
      );
  }

  private renderRoleSelection = () => {
    return (
        <div id="div_role" className={css(styles.role)} >
            <div id="div_role_header" className={css(styles.roleSectionHeaderContainer)} >
                <div id="role_label" className={css(styles.headerLabel)} >
                    Role
                </div>
                <div id="role_open" className={css(styles.dropdownButton)} onClick={this.onRoleDropdownClick}  >
                  {
                    this.state.isRoleExpanded? '\uf10d' : '\uf104'
                  }
                </div>
            </div>
          
            <div id="role_type_selection" className={css(this.state.isRoleExpanded? styles.roleTypeSelection: styles.hidden)}>
                <div id="ptm_column" className={css(styles.column)} >
                  <label id="lbl_enzyme_or_substrate">
                      <input id = "rb_enzyme_or_substrate"
                          type="radio"
                          name="role" 
                          value="enzyme_or_substrate"
                          className={css(styles.roleRadioButton)}
                          checked={this.isRoleSelected(Role.ENZYME_OR_SUBSTRATE)}
                          onClick={this.selectRole(Role.ENZYME_OR_SUBSTRATE)}
                          />
                          Enzyme or Substrate
                  </label>
                  <label id="lbl_enzyme">
                      <input id = "rb_enzyme"
                          type="radio"
                          name="role" 
                          value="enzyme"
                          className={css(styles.roleRadioButton)}
                          checked={this.isRoleSelected(Role.ENYZME)}
                          onClick={this.selectRole(Role.ENYZME)}
                          />
                          Enzyme
                  </label>
                  <label id="lbl_substrate">
                      <input id = "rb_substrate"
                          type="radio"
                          name="role" 
                          value="substrate"
                          className={css(styles.roleRadioButton)}
                          checked={this.isRoleSelected(Role.SUBSTRATE)}
                          onClick={this.selectRole(Role.SUBSTRATE)}
                          />
                          Substrate
                  </label>
                  <label id="lbl_enzyme_and_substrate">
                      <input id = "rb_enzyme_and_substrate"
                          type="radio"
                          name="role" 
                          value="enzyme_and_substrate"
                          className={css(styles.roleRadioButton)}
                          checked={this.isRoleSelected(Role.ENZYME_AND_SUBSTRATE)}
                          onClick={this.selectRole(Role.ENZYME_AND_SUBSTRATE)}
                          />
                          Enzyme and Substrate
                  </label>
                </div>                        
            </div>
        </div>
    );
  }

  private renderMiscSelection = () => {
    return (
        <div id="div_misc" className={css(styles.misc)} >
                      
            <div id="role_type_selection" className={css(styles.miscTypeSelection)}>
                <div id="ptm_column" className={css(styles.column)} >
                            <label id="lbl_all_entries">
                                <input id = "rb_all_entries"
                                    type="radio"
                                    name="role" 
                                    value="enzyme_or_substrate"
                                    className={css(styles.roleRadioButton)}
                                    checked={this.isRoleSelected(Role.ENZYME_OR_SUBSTRATE)}
                                    onClick={this.selectRole(Role.ENZYME_OR_SUBSTRATE)}
                                    />
                                    All entries
                            </label>
                            <label id="lbl_overlapping_ptms">
                                <input id = "rb_overlapping_ptms"
                                    type="radio"
                                    name="role" 
                                    value="enzyme"
                                    className={css(styles.roleRadioButton)}
                                    checked={this.isRoleSelected(Role.ENYZME)}
                                    onClick={this.selectRole(Role.ENYZME)}
                                    />
                                    Overlapping PTMs
                            </label>
                            <label id="lbl_ptm_dependent_interaction">
                                <input id = "rb_ptm_dependent_interaction"
                                    type="radio"
                                    name="role" 
                                    value="substrate"
                                    className={css(styles.roleRadioButton)}
                                    checked={this.isRoleSelected(Role.SUBSTRATE)}
                                    onClick={this.selectRole(Role.SUBSTRATE)}
                                    />
                                    PTM Dependent Interactions
                            </label>
                </div>                        
            </div>
        </div>
    );
  }
  
  private renderOrganismSelection = () => {
    return (
        <div id="div_misc" className={css(styles.misc)} >
            <div id="organism_type_selection" className={css(styles.miscTypeSelection)}>
                <div id="organisms" className={css(styles.column)}>
                  <label id="lbl_metazoa"  >
                      <input type="checkbox" className={css(styles.checkBox)} checked={this.isPTMSelected("Metazoa")}
                          onClick={this.onPTMClick("Metazoa")}
                      />
                      Metazoa
                  </label>

                  <div id="metazoa_selections" className={css(styles.organismColumn)}  >
                    <label id="lbl_human"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isPTMSelected("Metazoa")}
                            onClick={this.onPTMClick("Metazoa")}
                        />
                        Human
                    </label>
                    <label id="lbl_cow"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isPTMSelected("Metazoa")}
                            onClick={this.onPTMClick("Metazoa")}
                        />
                        Cow
                    </label>
                    <label id="lbl_mouse"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isPTMSelected("Metazoa")}
                            onClick={this.onPTMClick("Metazoa")}
                        />
                        Mouse
                    </label>
                    <label id="lbl_Rat"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isPTMSelected("Metazoa")}
                            onClick={this.onPTMClick("Metazoa")}
                        />
                        Rat
                    </label>
                    <label id="lbl_chicken"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isPTMSelected("Metazoa")}
                            onClick={this.onPTMClick("Metazoa")}
                        />
                        Chicken
                    </label>

                    <label id="lbl_Zebrafish"  >
                      <input type="checkbox" className={css(styles.checkBox)} checked={this.isPTMSelected("Fungi")}
                          onClick={this.onPTMClick("Fungi")}
                      />
                      Zebrafish
                    </label>

                    <label id="lbl_fruitfly"  >
                        <input type="checkbox" className={css(styles.checkBox)} checked={this.isPTMSelected("Plant")}
                            onClick={this.onPTMClick("Plant")}
                        />
                        Fruitfly
                    </label>

                    <label id="lbl_c_elegans"  >
                        <input type="checkbox" className={css(styles.checkBox)} checked={this.isPTMSelected("Plant")}
                            onClick={this.onPTMClick("Plant")}
                        />
                        C. elegans
                    </label>  

                  </div>  

                  <label id="lbl_fungi"  >
                      <input type="checkbox" className={css(styles.checkBox)} checked={this.isPTMSelected("Metazoa")}
                          onClick={this.onPTMClick("Metazoa")}
                      />
                      Fungi
                  </label>

                  <div id="fungi_selections" className={css(styles.organismColumn)}  >
                    <label id="lbl_bakers_yeast"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isPTMSelected("Metazoa")}
                            onClick={this.onPTMClick("Metazoa")}
                        />
                        Baker's yeast
                    </label>
                    <label id="lbl_fission_yeast"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isPTMSelected("Metazoa")}
                            onClick={this.onPTMClick("Metazoa")}
                        />
                        Fission yeast
                    </label>
                  </div>  


                  <label id="lbl_plant"  >
                      <input type="checkbox" className={css(styles.checkBox)} checked={this.isPTMSelected("Metazoa")}
                          onClick={this.onPTMClick("Metazoa")}
                      />
                      Plant
                  </label>

                  <div id="plant_selections" className={css(styles.organismColumn)}  >
                    <label id="lbl_a_thaliana"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isPTMSelected("Metazoa")}
                            onClick={this.onPTMClick("Metazoa")}
                        />
                        A. thaliana
                    </label>
                    <label id="lbl_maize"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isPTMSelected("Metazoa")}
                            onClick={this.onPTMClick("Metazoa")}
                        />
                        Maize
                    </label>
                    <label id="lbl_m_truncatula"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isPTMSelected("Metazoa")}
                            onClick={this.onPTMClick("Metazoa")}
                        />
                        M. truncatula
                    </label>
                    <label id="lbl_rice_japonica"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isPTMSelected("Metazoa")}
                            onClick={this.onPTMClick("Metazoa")}
                        />
                        Rice (japonica)
                    </label>
                    <label id="lbl_rice_indica"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isPTMSelected("Metazoa")}
                            onClick={this.onPTMClick("Metazoa")}
                        />
                        Rice (indica)
                    </label>                    
                  </div>  

                              
                </div>

            </div>
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
  
  private onPTMDropdownClick = () => {
    const newState = {...this.state,isPTMExpanded: !this.state.isPTMExpanded}
    this.setState(newState);  
  }

  private onRoleDropdownClick = () => {
    const newState = {...this.state,isRoleExpanded: !this.state.isRoleExpanded}
    this.setState(newState);  
  }

  private isRoleSelected = (role: Role) => {
    if(this.state.selectedRole === role){
        return true;
    }else{
        return false;
    } 
  }

  private selectRole = (role: Role) => () => {
    const newState = {...this.state, selectedRole: role}
    this.setState(newState)
  }

  private onBrowseClick = () => {
    this.refreshPage(this.state)
  }

  private refreshPage = (prevState: BrowsePageState) => {
    this.setState({...prevState,status: RequestState.LOADING})
    axios.get(`https://research.bioinformatics.udel.edu/iptmnet/api/browse?term_type=All&role=Enzyme%20or%20Substrate&start_index=0&end_index=100`).then((res)=> {
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
    margin: 20,
    "min-width": "15%",
    marginRight: "10%"
  },

  loading: {
    alignSelf: "center",
    marginTop: "auto",
    marginBottom: "auto"
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

  organismCheckBox: {
    marginTop: 10,
    marginRight: 10
  },

  ptm : {
    display: "flex",
    flexDirection: "column",
    alignSelf: "stretch",
    backgroundColor: "#fcfcfc",
    paddingLeft: 10,
    paddingRight: 10,
    paddingTop: 10,
    paddingBottom: 10,
    borderStyle: "solid",
    borderWidth: 1,
    borderColor: "#efefef",
    borderRadius: 5
  },

  role : {
    display: "flex",
    flexDirection: "column",
    alignSelf: "stretch",
    backgroundColor: "#fcfcfc",
    paddingLeft: 10,
    paddingRight: 10,
    paddingTop: 10,
    paddingBottom: 10,
    borderStyle: "solid",
    borderWidth: 1,
    borderColor: "#efefef",
    borderRadius: 5,
    marginTop: 10
  },

  misc : {
    display: "flex",
    flexDirection: "column",
    alignSelf: "stretch",
    backgroundColor: "#fcfcfc",
    paddingLeft: 10,
    paddingRight: 10,
    paddingTop: 5,
    paddingBottom: 5,
    borderStyle: "solid",
    borderWidth: 1,
    borderColor: "#efefef",
    borderRadius: 5,
    marginTop: 10
  },


  dropdownButton: {
    textAlign: "center",
    verticalAlign: "middle",
    lineHeight: "1.2em",
    fontFamily: "Ionicons",
    fontSize: "1.2em",
    marginLeft: "auto",
    borderStyle: "solid",
    borderRadius: "50%",
    width: "1.2em",
    height: "1.2em",
    borderWidth: 1,
    borderColor: "#b0b0b0ff",
    color: "#000000",
    ":hover": {
      cursor: "pointer",
      backgroundColor: "#329CDA",
      color: "#fbfbfb"
    },
    
  },

  ptmTypeSelection: {
    display: "flex",
    flexDirection: "row",
    marginLeft: "5px",
    marginRight: "5px",
    marginTop: "0px",
    alignSelf: "stretch",
    justifyContent: "space-between",
    fontSize: "0.80em"
  },


  roleTypeSelection: {
    display: "flex",
    flexDirection: "row",
    marginLeft: "5px",
    marginRight: "5px",
    marginTop: "0px",
    alignSelf: "stretch",
    justifyContent: "space-between",
    fontSize: "0.80em"
  },

  miscTypeSelection: {
    display: "flex",
    flexDirection: "row",
    marginLeft: "5px",
    marginRight: "5px",
    marginTop: "0px",
    alignSelf: "stretch",
    justifyContent: "space-between",
    fontSize: "0.80em"
  },

  sectionHeaderContainer : {
    display: "flex",
    flexDirection: "row",
    alignSelf: "stretch",
    alignItems: "center",
    marginBottom: 10
  },

  roleSectionHeaderContainer : {
    display: "flex",
    flexDirection: "row",
    alignSelf: "stretch",
    alignItems: "center",
    marginBottom: 0
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

  ptmButtons: {
    display: "flex",
    flexDirection: "row",
    padding: 0
  },

  hidden: {
    display: "none"
  },

  roleRadioButton : {
    marginTop: 10,
    marginRight: 10
  },

  organismColumn: {
    display: "flex",
    flexDirection: "column",
    alignSelf: "stretch",
    marginLeft: 40
  },
 
  browseButton: {
      marginTop: 5,
      marginBottom: 10,
      paddingTop: 10,
      paddingBottom: 10,
      marginLeft: "auto",
      textAlign: "center",
      fontWeight: "bold",
      backgroundColor: "#fcfcfc",
      color: "#606060ff",
      borderStyle: "solid",
      borderRadius: 50,
      borderWidth: 1,
      borderColor: "#efefef",
      ":hover": {
          cursor: "pointer",
          backgroundColor: "#329CDA",
          color: "#fbfbfb"
      },
      ":focus": {
          outline: "none"
      } 
  }
  
});


export default Browse;
