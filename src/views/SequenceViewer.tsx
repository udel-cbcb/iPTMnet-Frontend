import { CommonStyles } from "../misc/CommonStyles";
import { css, StyleSheet } from "aphrodite";
import * as React from "react";

class SequenceViewer extends React.Component {
    
    public render(){
        return (
            <div id="sequence_viewer" style={{marginTop:25}} >
                <div id="title" className={css(CommonStyles.sectionTitle)} >
                    Interactive Sequence View
                </div>
                <div id="msa_container" className={css(styles.msa_container)}  >

                </div>
            </div>
        )
    }
    
}

export const styles = StyleSheet.create({
    msa_container: {
        marginTop: 10,
        backgroundColor: "#f2f2f2",
        "height": "100px",
        width: "100%"
    }
})

export default SequenceViewer;
