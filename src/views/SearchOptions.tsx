import * as React from "react";
import { StyleSheet,css } from 'aphrodite';
import store from "../redux/store";
import * as HomePageActions from '../redux/actions/HomePageActions';
import { Role } from "../models/Role";

interface ISearchOptionProps {
    readonly selectedPTMs: string[],
    readonly selectedOrganisms: string[],
    readonly selectedRole: Role
}

class SearchOptions extends React.Component<ISearchOptionProps,{}> {

    constructor(props: ISearchOptionProps){
        super(props)
    }
    
    public render(){
        return (
             <div id="div_advanced_search" className={css(styles.advancedSearch)} >
                <div id="div_ptm" className={css(styles.ptm)} >
                    <div id="div_ptm_header" className={css(styles.sectionHeaderContainer)} >
                        <div id="ptm_label" className={css(styles.headerLabel)} >
                            PTM type
                        </div>
                        <button id="btn_all_ptm" className={css(styles.selectorButton)} onClick={this.onPTMAllClick}  >
                            All
                        </button>
                        <button id="btn_none_ptm" className={css(styles.selectorButton, styles.noneButton)} onClick={this.onPTMNoneClick} >
                            None
                        </button>
                    </div>

                    <div id="ptm_type_selection" className={css(styles.ptmTypeSelection)}  >
                        
                        <div id="column_1" className={css(styles.column)} >
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
                        </div>

                        <div id="column_2" className={css(styles.column)} >
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
                        </div>

                        <div id="column_3" className={css(styles.column)} >
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

                    <div id="div_role_container" className={css(styles.roleContainer)} >
                        <div id="role_label" className={css(styles.roleLabel)} >
                               Role 
                        </div>
                        <div id="div_role_selections" className={css(styles.roleSelections)}  >
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


                    <div id="div_organisms_container" className={css(styles.organismsContainer)}  >
                        <div id="organisms_header" className={css(styles.sectionHeaderContainer)}  >
                            <div id="label" className={css(styles.headerLabel)} >
                                Organism
                            </div>
                            <button id="btn_all" className={css(styles.selectorButton)} onClick={this.onOrganismsAllClick} >
                                All
                            </button>
                            <button id="btn_none" className={css(styles.selectorButton, styles.noneButton)} onClick={this.onOrganismsNoneClick}  >
                                None
                            </button>
                        </div>

                        <div id="organism_selection" className={css(styles.ptmTypeSelection)}  >
                        
                            <div id="column_1" className={css(styles.column)} >
                                <label id="lbl_humans"  >
                                    <input type="checkbox" className={css(styles.checkBox)} checked={this.isOrganismSelected("9606")}
                                        onClick={this.onOrganismClick("9606")}
                                    />
                                    Human
                                </label>
                                <label id="lbl_Cow"  >
                                    <input type="checkbox" className={css(styles.checkBox)}  checked={this.isOrganismSelected("9913")}
                                        onClick={this.onOrganismClick("9913")}
                                    />
                                    Cow
                                </label>
                                <label id="lbl_fruit_fly"  >
                                    <input type="checkbox" className={css(styles.checkBox)} checked={this.isOrganismSelected("7215")}
                                        onClick={this.onOrganismClick("7215")}
                                    />
                                    Fruit fly
                                </label>
                                <label id="lbl_fission_yeast"  >
                                    <input type="checkbox" className={css(styles.checkBox)} checked={this.isOrganismSelected("4896")} 
                                        onClick={this.onOrganismClick("4896")}
                                    />
                                    Fission yeast
                                </label>
                            </div>

                            <div id="column_2" className={css(styles.column)} >
                                <label id="lbl_m_truncatula"  >
                                    <input type="checkbox" className={css(styles.checkBox)} checked={this.isOrganismSelected("3880")}
                                        onClick={this.onOrganismClick("3880")}
                                    />
                                    M. truncatula
                                </label>
                                <label id="lbl_mouse"  >
                                    <input type="checkbox" className={css(styles.checkBox)} checked={this.isOrganismSelected("10090")}
                                        onClick={this.onOrganismClick("10090")}
                                    />
                                    Mouse
                                </label>
                                <label id="lbl_chicken"  >
                                    <input type="checkbox" className={css(styles.checkBox)} checked={this.isOrganismSelected("9031")}
                                        onClick={this.onOrganismClick("9031")}
                                    />
                                    Chicken
                                </label>
                                <label id="lbl_c_elegans"  >
                                    <input type="checkbox" className={css(styles.checkBox)} checked={this.isOrganismSelected("124036")}
                                        onClick={this.onOrganismClick("124036")}
                                    />
                                    C. elegans
                                </label>
                            </div>

                            <div id="column_3" className={css(styles.column)} >
                                <label id="lbl_a_thaliana"  >
                                    <input type="checkbox" className={css(styles.checkBox)} checked={this.isOrganismSelected("344310")}
                                        onClick={this.onOrganismClick("344310")}
                                    />
                                    A. Thaliana
                                </label>
                                <label id="lbl_rice"  >
                                    <input type="checkbox" className={css(styles.checkBox)} checked={this.isOrganismSelected("35790")}
                                        onClick={this.onOrganismClick("35790")}
                                    />
                                    Rice (japonica)
                                </label>
                                <label id="lbl_rat"  >
                                    <input type="checkbox" className={css(styles.checkBox)} checked={this.isOrganismSelected("10114")}
                                        onClick={this.onOrganismClick("10114")}
                                    />
                                    Rat
                                </label>
                                <label id="lbl_zebrafish"  >
                                    <input type="checkbox" className={css(styles.checkBox)} checked={this.isOrganismSelected("7955")}
                                        onClick={this.onOrganismClick("7955")}
                                    />
                                    Zebrafish
                                </label>
                            </div>

                            <div id="column_4" className={css(styles.column)} >
                                <label id="lbl_bakers_yeast"  >
                                    <input type="checkbox" className={css(styles.checkBox)} checked={this.isOrganismSelected("4932")}
                                        onClick={this.onOrganismClick("4932")}
                                    />
                                    Bakers's Yeast
                                </label>
                                <label id="lbl_maize"  >
                                    <input type="checkbox" className={css(styles.checkBox)} checked={this.isOrganismSelected("4577")}
                                        onClick={this.onOrganismClick("4577")}
                                    />
                                    Maize
                                </label>
                            </div>
                        
                        </div>
                        
                        <div id="div_organism_taxon_codes" className={css(styles.inputTaxonCodesContainer)} >
                            <input id="input_taxon_codes" className={css(styles.inputTaxonCodes)} placeholder="Enter organism taxon codes seperated by comma"  />
                        </div>

                    </div>

                </div>
             </div>           
        );
    };

    private isPTMSelected = (ptmName: string) => {
        if(this.props.selectedPTMs.indexOf(ptmName) > -1){
            return true;
        }else{
            return false;
        }
    }

    private onPTMAllClick = () => {
        (store.dispatch as any)(HomePageActions.selectAllPTMTypes())
    }

    private onPTMClick = (ptmName: string) => () => {
        if(this.props.selectedPTMs.indexOf(ptmName) > -1){
            (store.dispatch as any)(HomePageActions.deselectPTMType(ptmName)) 
        }else{
            (store.dispatch as any)(HomePageActions.selectPTMType(ptmName))
        }
    }

    private onPTMNoneClick = () => {
        (store.dispatch as any)(HomePageActions.deselectAllPTMTypes())
    }

    private isRoleSelected = (role: Role) => {
        if(this.props.selectedRole === role){
            return true;
        }else{
            return false;
        }
    }

    private onOrganismsAllClick = () => {
        (store.dispatch as any)(HomePageActions.selectAllOrganisms())
    }

    private onOrganismsNoneClick = () => {
        (store.dispatch as any)(HomePageActions.deselectAllOrganisms())
    }

    private isOrganismSelected(organism: string) {
        if(this.props.selectedOrganisms.indexOf(organism) > -1){
            return true;
        }else{
            return false;
        }
    }

    private onOrganismClick = (organism: string) => () => {
        if(this.props.selectedOrganisms.indexOf(organism) > -1){
            (store.dispatch as any)(HomePageActions.deselectOrganism(organism)) 
        }else{
            (store.dispatch as any)(HomePageActions.selectOrganism(organism))
        }
    }

    private selectRole = (role: Role) => () => {
        (store.dispatch as any)(HomePageActions.selectRole(role))
    }

}

const styles = StyleSheet.create({
    advancedSearch : {
        display: "flex",
        flexDirection: "column",
        alignSelf: "stretch",
        marginTop: "20px",
        marginLeft: "5px",
        marginRight: "5px",
        fontSize: "0.95em"  
    },

    ptm : {
        display: "flex",
        flexDirection: "column",
        alignSelf: "stretch"
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

    ptmTypeSelection: {
        display: "flex",
        flexDirection: "row",
        marginLeft: "5px",
        marginRight: "5px",
        marginTop: "5px",
        alignSelf: "stretch",
        justifyContent: "space-between"
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

    roleContainer : {
        display: "flex",
        flexDirection: "column",
        alignSelf: "stretch",
        marginTop: "20px"
    },

    roleLabel : {
        fontWeight: "bold",
        color: "#232323ff",
        alignSelf: "stretch"
    },

    roleSelections: {
        display: "flex",
        flexDirection: "row",
        justifyContent: "space-between",
        marginLeft: 5,
        marginRight: 5,
        alignSelf: "stretch",
        alignItems: "center"
    },

    roleRadioButton : {
        marginTop: 10,
        marginRight: 10
    },

    organismsContainer: {
        display: "flex",
        flexDirection: "column",
        alignSelf: "stretch",
        marginTop: "25px"
    },

    inputTaxonCodesContainer: {
        display: "flex",
        flexDirection: "row",
        alignSelf: "stretch",
        marginTop: 20,
        marginLeft: 10,
        marginRight: 10 
    },

    inputTaxonCodes : {
        width: "100%",
        height: 35,
        paddingLeft: 10,
        paddingRight: 10 
    }
   

})

export default SearchOptions;