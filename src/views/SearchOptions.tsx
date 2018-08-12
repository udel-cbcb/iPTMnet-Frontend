import * as React from "react";
import { StyleSheet,css } from 'aphrodite';

class SearchOptions extends React.Component{
    public render(){
        return (
             <div id="div_advanced_search" className={css(styles.advancedSearch)} >
                <div id="div_ptm" className={css(styles.ptm)} >
                    <div id="div_ptm_header" className={css(styles.sectionHeaderContainer)} >
                        <div id="ptm_label" className={css(styles.headerLabel)} >
                            PTM type
                        </div>
                        <button id="btn_all_ptm" className={css(styles.selectorButton)} >
                            All
                        </button>
                        <button id="btn_none_ptm" className={css(styles.selectorButton, styles.noneButton)} >
                            None
                        </button>
                    </div>

                    <div id="ptm_type_selection" className={css(styles.ptmTypeSelection)}  >
                        
                        <div id="column_1" className={css(styles.column)} >
                            <label id="lbl_acetylation"  >
                                <input type="checkbox" className={css(styles.checkBox)} />
                                Acetylation
                            </label>
                            <label id="lbl_n_lycosylation"  >
                                <input type="checkbox" className={css(styles.checkBox)} />
                                N-Glycosylation
                            </label>
                            <label id="lbl_o_lycosylation"  >
                                <input type="checkbox" className={css(styles.checkBox)} />
                                O-Glycosylation
                            </label>
                            <label id="lbl_c_glycosylation"  >
                                <input type="checkbox" className={css(styles.checkBox)} />
                                C-Glycosylation
                            </label>
                        </div>

                        <div id="column_2" className={css(styles.column)} >
                            <label id="lbl_s_glycosylation"  >
                                <input type="checkbox" className={css(styles.checkBox)} />
                                S-Glycosylation
                            </label>
                            <label id="lbl_methylation"  >
                                <input type="checkbox" className={css(styles.checkBox)} />
                                Methylation
                            </label>
                            <label id="lbl_c_myristoylation"  >
                                <input type="checkbox" className={css(styles.checkBox)} />
                                Myristoylation
                            </label>
                            <label id="lbl_c_phosphorylation"  >
                                <input type="checkbox" className={css(styles.checkBox)} />
                                Phosphorylation
                            </label>
                        </div>

                        <div id="column_3" className={css(styles.column)} >
                            <label id="lbl_s_sumoylation"  >
                                <input type="checkbox" className={css(styles.checkBox)} />
                                Sumoylation
                            </label>
                            <label id="lbl_ubiquitination"  >
                                <input type="checkbox" className={css(styles.checkBox)} />
                                Ubiquitination
                            </label>
                            <label id="lbl_s_nitrosylation"  >
                                <input type="checkbox" className={css(styles.checkBox)} />
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
                                    />
                                    Enzyme or Substrate
                            </label>
                            <label id="lbl_enzyme">
                                <input id = "rb_enzyme"
                                    type="radio"
                                    name="role" 
                                    value="enzyme"
                                    className={css(styles.roleRadioButton)}
                                    />
                                    Enzyme
                            </label>
                            <label id="lbl_substrate">
                                <input id = "rb_substrate"
                                    type="radio"
                                    name="role" 
                                    value="substrate"
                                    className={css(styles.roleRadioButton)}
                                    />
                                    Substrate
                            </label>
                            <label id="lbl_enzyme_and_substrate">
                                <input id = "rb_enzyme_and_substrate"
                                    type="radio"
                                    name="role" 
                                    value="enzyme_and_substrate"
                                    className={css(styles.roleRadioButton)}
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
                            <button id="btn_all" className={css(styles.selectorButton)} >
                                All
                            </button>
                            <button id="btn_none" className={css(styles.selectorButton, styles.noneButton)} >
                                None
                            </button>
                        </div>

                        <div id="organism_selection" className={css(styles.ptmTypeSelection)}  >
                        
                            <div id="column_1" className={css(styles.column)} >
                                <label id="lbl_humans"  >
                                    <input type="checkbox" className={css(styles.checkBox)} />
                                    Human
                                </label>
                                <label id="lbl_Cow"  >
                                    <input type="checkbox" className={css(styles.checkBox)} />
                                    Cow
                                </label>
                                <label id="lbl_fruit_fly"  >
                                    <input type="checkbox" className={css(styles.checkBox)} />
                                    Fruit fly
                                </label>
                                <label id="lbl_fission_yeast"  >
                                    <input type="checkbox" className={css(styles.checkBox)} />
                                    Fission yeast
                                </label>
                            </div>

                            <div id="column_2" className={css(styles.column)} >
                                <label id="lbl_m_truncatula"  >
                                    <input type="checkbox" className={css(styles.checkBox)} />
                                    M. truncatula
                                </label>
                                <label id="lbl_mouse"  >
                                    <input type="checkbox" className={css(styles.checkBox)} />
                                    Mouse
                                </label>
                                <label id="lbl_chicken"  >
                                    <input type="checkbox" className={css(styles.checkBox)} />
                                    Chicken
                                </label>
                                <label id="lbl_c_elegans"  >
                                    <input type="checkbox" className={css(styles.checkBox)} />
                                    C. elegans
                                </label>
                            </div>

                            <div id="column_3" className={css(styles.column)} >
                                <label id="lbl_a_thaliana"  >
                                    <input type="checkbox" className={css(styles.checkBox)} />
                                    A. Thaliana
                                </label>
                                <label id="lbl_rice"  >
                                    <input type="checkbox" className={css(styles.checkBox)} />
                                    Rice (japonica)
                                </label>
                                <label id="lbl_rat"  >
                                    <input type="checkbox" className={css(styles.checkBox)} />
                                    Rat
                                </label>
                                <label id="lbl_zebrafish"  >
                                    <input type="checkbox" className={css(styles.checkBox)} />
                                    Zebrafish
                                </label>
                            </div>

                            <div id="column_4" className={css(styles.column)} >
                                <label id="lbl_bakers_yeast"  >
                                    <input type="checkbox" className={css(styles.checkBox)} />
                                    Bakers's Yeast
                                </label>
                                <label id="lbl_maize"  >
                                    <input type="checkbox" className={css(styles.checkBox)} />
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