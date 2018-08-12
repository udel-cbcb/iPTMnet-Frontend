import * as React from 'react';
import { css, StyleSheet } from 'aphrodite';

class Footer extends React.Component {
    
    public render() {
        return (
            <div id="footer" className={css(styles.footer)}  >
                <div id="div_ud" className={css(styles.ud)}>
                    <a href="http://bioinformatics.udel.edu/" className={css(styles.link)} target="_"  >
                        University of Delaware
                    </a>
                    <div style={{marginTop: 5}} >
                        15 Innovation Way, Suite 205
                    </div>
                    <div style={{marginTop: 5}} >
                        Newark, DE 19711, USA
                    </div>
                </div>

                <div id="div_georgetown" className={css(styles.georgetown)}>
                    <a href="http://gumc.georgetown.edu/" className={css(styles.link)} target="_"  >
                        Georgetown University Medical Center
                    </a>
                    <div style={{marginTop: 5}} >
                        3300 Whitehaven Street, NW, Suite 1200
                    </div>
                    <div style={{marginTop: 5}} >
                        Washington, DC 20007, USA
                    </div>
                </div>

            </div>
        );
    }

}

const styles = StyleSheet.create({
    footer: {
        alignSelf: "stretch",
        backgroundColor: "#f2f2f2",
        display: "flex",
        flexDirection: "row",
        alignItems: "center",
        color: "#6c6c6cff",
        padding: 10 
    },

    ud: {
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        margin: "auto",
        marginRight: 20,
        marginTop: 10,
        marginBottom: 10
    },

    link: {
        ":link": {
            color: "#6c6c6cff"
        },
        ":visited": {
            color: "#6c6c6cff"
        }
    },

    georgetown : {
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        margin: "auto",
        marginLeft: 20,
        marginTop: 10,
        marginBottom: 10
    }


});


export default Footer;