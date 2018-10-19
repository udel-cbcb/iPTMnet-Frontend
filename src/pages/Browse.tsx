import * as React from 'react';
import { css, StyleSheet } from 'aphrodite';
import Navbar from '../views/Navbar';
import Footer from 'src/views/Footer';
import { BrowsePageState } from 'src/redux/states/BrowsePageState';
import { Role, roleFromString, roleToString } from 'src/models/Role';
import { SearchResultView } from 'src/views/SearchResult';
import Pagination from "react-js-pagination";
import {parse} from "query-string";

interface IBrowseProps {
    query: string;
    history: any;
}

class Browse extends React.Component<IBrowseProps,BrowsePageState> {

  constructor(props: IBrowseProps){
      super(props);  
      this.state = new BrowsePageState();
      this.state = this.updateStateFromProps(this.state,this.props);
  }

  public async componentWillReceiveProps(nextProps: IBrowseProps) {
     this.setState(this.updateStateFromProps(this.state,nextProps));
  }

  public updateStateFromProps = (prevState:BrowsePageState, props: IBrowseProps) => {
    const state = {...prevState,
        selectedRole: this.extract_role(props.query),
        start_index: this.extract_start_index(props.query),
        end_index: this.extract_end_index(props.query)    
    }
    return state;
  }

  public render() {
    const page_indicator_info =  `${this.state.start_index + 1} - ${this.state.end_index} of ${this.state.count} results for in iPTMnet` 
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
                <div id="summary" className={css(styles.summary)} >
                    <div style={{marginRight:"auto"}} >
                        {page_indicator_info} 
                    </div>
                    <div id="pagination_container" style={{marginLeft:"auto",marginRight:20}} >
                    <Pagination
                    activePage={this.getActivePageNumber()}
                    itemsCountPerPage={28}
                    totalItemsCount={this.state.count}
                    pageRangeDisplayed={5}
                    onChange={this.onPageChange}
                    innerClass={css(styles.pagination_ul)}
                    itemClass={css(styles.pagination_li)}
                    linkClass={css(styles.pagination_a)}
                    activeClass={css(styles.pagination_active_li)}
                    activeLinkClass={css(styles.pagination_active_a)}
                    prevPageText='prev'
                    nextPageText='next'
                    firstPageText='first'
                    lastPageText='last'   
                    />
                    </div>
                </div>
                <SearchResultView query={this.props.query} isBrowse={true} onDataLoaded={this.onDataLoaded} />
          </div>        
          
        </div>

        <div id="filer" style={{minHeight: "50px"}} >

        </div>

        <Footer /> 
      </div>
    );
  }

  private onDataLoaded = (data_count: number) => {
        this.setState({...this.state,count: data_count})
  }

  private getActivePageNumber = () => {
    const active_page = this.state.end_index/28  
    return active_page;
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
                                    checked={false}
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
                                    checked={false}
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
                                    checked={false}
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
                      <input type="checkbox" className={css(styles.checkBox)} checked={this.isMetazoaSelected()}
                          onClick={this.onMetazoaClicked()}
                      />
                      Metazoa
                  </label>

                  <div id="metazoa_selections" className={css(styles.organismColumn)}  >
                    <label id="lbl_human"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isOrganismSelected(9606)}
                            onClick={this.onOrganismClicked(9606)}
                        />
                        Human
                    </label>
                    <label id="lbl_cow"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isOrganismSelected(9913)}
                            onClick={this.onOrganismClicked(9913)}
                        />
                        Cow
                    </label>
                    <label id="lbl_mouse"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isOrganismSelected(10090)}
                            onClick={this.onOrganismClicked(10090)}
                        />
                        Mouse
                    </label>
                    <label id="lbl_Rat"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isOrganismSelected(10116)}
                            onClick={this.onOrganismClicked(10116)}
                        />
                        Rat
                    </label>
                    <label id="lbl_chicken"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isOrganismSelected(9031)}
                            onClick={this.onOrganismClicked(9031)}
                        />
                        Chicken
                    </label>

                    <label id="lbl_Zebrafish"  >
                      <input type="checkbox" className={css(styles.checkBox)} checked={this.isOrganismSelected(7955)}
                          onClick={this.onOrganismClicked(7955)}
                      />
                      Zebrafish
                    </label>

                    <label id="lbl_fruitfly"  >
                        <input type="checkbox" className={css(styles.checkBox)} checked={this.isOrganismSelected(7227)}
                            onClick={this.onOrganismClicked(7227)}
                        />
                        Fruitfly
                    </label>

                    <label id="lbl_c_elegans"  >
                        <input type="checkbox" className={css(styles.checkBox)} checked={this.isOrganismSelected(6239)}
                            onClick={this.onOrganismClicked(6239)}
                        />
                        C. elegans
                    </label>  

                  </div>  

                  <label id="lbl_fungi"  >
                      <input type="checkbox" className={css(styles.checkBox)} checked={this.isFungiSelected()}
                          onClick={this.onFungiClicked()}
                      />
                      Fungi
                  </label>

                  <div id="fungi_selections" className={css(styles.organismColumn)}  >
                    <label id="lbl_bakers_yeast"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isOrganismSelected(4932)}
                            onClick={this.onOrganismClicked(4932)}
                        />
                        Baker's yeast
                    </label>
                    <label id="lbl_fission_yeast"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isOrganismSelected(4896)}
                            onClick={this.onOrganismClicked(4896)}
                        />
                        Fission yeast
                    </label>
                  </div>  


                  <label id="lbl_plant"  >
                      <input type="checkbox" className={css(styles.checkBox)} checked={this.isPlantSelected()}
                          onClick={this.onPlantClicked()}
                      />
                      Plant
                  </label>

                  <div id="plant_selections" className={css(styles.organismColumn)}  >
                    <label id="lbl_a_thaliana"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isOrganismSelected(3702)}
                            onClick={this.onOrganismClicked(3702)}
                        />
                        A. thaliana
                    </label>
                    <label id="lbl_maize"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isOrganismSelected(4577)}
                            onClick={this.onOrganismClicked(4577)}
                        />
                        Maize
                    </label>
                    <label id="lbl_m_truncatula"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isOrganismSelected(3880)}
                            onClick={this.onOrganismClicked(3880)}
                        />
                        M. truncatula
                    </label>
                    <label id="lbl_rice_japonica"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isOrganismSelected(39947)}
                            onClick={this.onOrganismClicked(39947)}
                        />
                        Rice (japonica)
                    </label>
                    <label id="lbl_rice_indica"  >
                        <input type="checkbox" className={css(styles.organismCheckBox)} checked={this.isOrganismSelected(39946)}
                            onClick={this.onOrganismClicked(39946)}
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
      return this.state.selectedPTMs.indexOf(ptmName) !== -1;
  }

  private onPTMAllClick = () => {
    const newState = {...this.state, selectedPTMs: ["Acetylation",
                                                    "N-Glycosylation",
                                                    "O-Glycosylation",
                                                    "C-Glycosylation",
                                                    "S-Glycosylation",
                                                    "Methylation",
                                                    "Myristoylation",
                                                    "Phosphorylation",
                                                    "Sumoylation",
                                                    "Ubiquitination",
                                                    "S-Nitrosylation"
                                                ]}
    this.setState(newState)  
    return false;
  }

  private onPTMClick = (ptmName: string) => () => {
      const ptmsCopy = this.state.selectedPTMs.slice();
      const index = ptmsCopy.indexOf(ptmName);
      if(index !== -1){
        ptmsCopy.splice(index,1)
      }else{
        ptmsCopy.push(ptmName)
      }
      const newState = {...this.state, selectedPTMs: ptmsCopy}
      this.setState(newState)
  }

  private onPTMNoneClick = () => {
    const newState = {...this.state, selectedPTMs: []}
    this.setState(newState)   
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
  
  private onMetazoaClicked = () => () => {
      if(this.isMetazoaSelected()){
        const organismsCopy = this.state.selectedOrganisms.slice() 
        this.removeIfExist(organismsCopy,[9606,9913,10090,10116,9031,7955,7227,6239])
        const newState = {...this.state, selectedOrganisms: organismsCopy}
        this.setState(newState)
      }else {
        const organismsCopy = this.state.selectedOrganisms.slice() 
        this.insertIfNotExist(organismsCopy,[9606,9913,10090,10116,9031,7955,7227,6239])
        const newState = {...this.state, selectedOrganisms: organismsCopy}
        this.setState(newState)
      }
    
  }

  private isMetazoaSelected = () => {
    const codes: number[] = [9606,9913,10090,10116,9031,7955,7227,6239]
    for(const code of codes) {
        const index = this.state.selectedOrganisms.indexOf(+code);
        if( index === -1 ){
             return false;
        }
    }
    return true;

  }

  private isFungiSelected = () => {
    const codes: number[] = [4932,4896]
    for(const code of codes) {
        const index = this.state.selectedOrganisms.indexOf(+code);
        if( index === -1 ){
             return false;
        }
    }
    return true;
  }

  private onFungiClicked = () => () => {
      if(this.isFungiSelected()){
        const organismsCopy = this.state.selectedOrganisms.slice() 
        this.removeIfExist(organismsCopy,[4932,4896])
        const newState = {...this.state, selectedOrganisms: organismsCopy}
        this.setState(newState)
      }else{
        const organismsCopy = this.state.selectedOrganisms.slice() 
        this.insertIfNotExist(organismsCopy,[4932,4896])
        const newState = {...this.state, selectedOrganisms: organismsCopy}
        this.setState(newState)
      } 
  }

  private isPlantSelected = () => {
    const codes: number[] = [3702,4577,3880,39947,39946]
    for(const code of codes) {
        const index = this.state.selectedOrganisms.indexOf(+code);
        if( index === -1 ){
             return false;
        }
    }
    return true;
  }

  private onPlantClicked = () => () => {
    if(this.isPlantSelected()){
      const organismsCopy = this.state.selectedOrganisms.slice() 
      this.removeIfExist(organismsCopy,[3702,4577,3880,39947,39946])
      const newState = {...this.state, selectedOrganisms: organismsCopy}
      this.setState(newState)
    }else{
      const organismsCopy = this.state.selectedOrganisms.slice() 
      this.insertIfNotExist(organismsCopy,[3702,4577,3880,39947,39946])
      const newState = {...this.state, selectedOrganisms: organismsCopy}
      this.setState(newState)
    } 
  }


  private isOrganismSelected = (taxon_code: number) => {
    return this.state.selectedOrganisms.indexOf(taxon_code) !== -1;
  }

  private onOrganismClicked = (taxon_code: number) => () => {
        const organismsCopy = this.state.selectedOrganisms.slice();
        const index = organismsCopy.indexOf(taxon_code);
        if(index !== -1){
            organismsCopy.splice(index,1)
        }else{
            organismsCopy.push(taxon_code)
        }
        const newState = {...this.state, selectedOrganisms: organismsCopy}
        this.setState(newState)  
  }

  private insertIfNotExist = (selectedOrganisms: number[], organisms: number[]) => {
      for(const organism of organisms) {
         const index = selectedOrganisms.indexOf(organism);
         if(index === -1){
            selectedOrganisms.push(organism)
         }
      }
  }

  private removeIfExist = (selectedOrganisms: number[], organisms: number[]) => {
    for(const organism of organisms) {
       const index = selectedOrganisms.indexOf(organism);
       if(index !== -1){
          selectedOrganisms.splice(index,1)
       }
    }
}

  private onPageChange = (pageNumber: number) => {
    const start_index = (pageNumber - 1) * 28 ;
    const end_index = start_index + 28;
    const query = this.build_query(this.state.selectedRole,start_index,end_index,this.state.selectedPTMs,this.state.selectedOrganisms);
    const url = query;
    this.props.history.push(url);
}

  private onBrowseClick = () => {
    const query = this.build_query(this.state.selectedRole,this.state.start_index,this.state.end_index,this.state.selectedPTMs,this.state.selectedOrganisms);
    this.props.history.push(query);
  }

  private build_query(role: Role,start_index: number, end_index: number, ptms: string[], organisms: number[]) {
      const role_str = roleToString(role);
      const organism_str = this.organismsToString(organisms);
      const ptm_str = this.ptmsToString(ptms);
      return `term_type=All&role=${role_str}${ptm_str}${organism_str}&start_index=${start_index}&end_index=${end_index}`;
  }

  private organismsToString(organisms: number[]) {
      let query_str = "";
      for (const organism of organisms) {
         query_str = query_str + `&organism=${organism}`
      }
      return query_str;
  }

  private ptmsToString(ptms: string[]) {
    let query_str = "";
    for (const ptm of ptms) {
       query_str = query_str + `&ptm_type=${ptm}`
    }
    return query_str;
}

  private extract_start_index(query: string): number {
    const parsed = parse(query);
    const value = Number(parsed.start_index);
    if(isNaN(value)) {
        return 0
    }else{
        return value;
    }   
  }

  private extract_end_index(query: string): number {
    const parsed = parse(query);
    const value = Number(parsed.end_index);
    if(isNaN(value)) {
        return 0
    }else{
        return value;
    }    
  }

  private extract_role(query: string): Role {
    const parsed = parse(query);
    const role = roleFromString(String(parsed.role));  
    return role;
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
      backgroundColor: "#329CDA",
      color: "#fbfbfb",
      borderStyle: "solid",
      borderRadius: 50,
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

  summary: {
    display: "flex",
    flexDirection: "row",
    marginTop: 40,
    marginBottom: 20,
    alignItems: "center"
  },

  pagination_ul : {
    display: "flex",
    flexDirection: "row",
    paddingLeft: 0,
    margin: "20px 0px",
    borderStyle: "solid",
    borderColor: "#c4c4c4",
    borderRadius: "5px",
    borderWidth: "1px",
    fontSize: "0.8em"
  },

  pagination_a : {
    ":link": {
      textDecoration: "none",
      color: "#000000"
    },
  },

  pagination_active_a : {
    ":link": {
      textDecoration: "none",
      color: "white"
    },
    ":hover": {
        textDecoration: "none",
        color: "black"
    },
  },

  pagination_li: {
    display: "inline",
    paddingTop: "5px",
    paddingLeft: "10px",
    paddingRight: "10px",
    paddingBottom: "5px",
    borderRightStyle: "solid",
    borderRightWidth: "1px",
    borderColor: "#c4c4c4",
    ":hover": {
        cursor: "pointer",
        backgroundColor: "#e6e6e6ff",
        color: "#ffffff"
    },
  },

  pagination_active_li: {
    display: "inline",
    backgroundColor: "#329CDA",
    color: "white",
    paddingTop: "5px",
    paddingLeft: "10px",
    paddingRight: "10px",
    paddingBottom: "5px",
    borderRightStyle: "solid",
    borderRightWidth: "1px",
    borderColor: "#c4c4c4",
    ":hover": {
        cursor: "pointer",
        backgroundColor: "#e6e6e6ff",
        color: "#ffffff"
    },
  }


  
});


export default Browse;
