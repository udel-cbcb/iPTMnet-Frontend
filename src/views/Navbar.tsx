import * as React from 'react';
import { css,StyleSheet,minify } from 'aphrodite';
import { Link } from 'react-router-dom'

minify(false);

class Navbar extends React.Component {
  public render() {
    return (
        <div id="nav_bar_container" className={css(styles.navbar_container)} >
            <div id="nav_bar" className={css(styles.navbar)}>

                <Link id="nav_home" to="/" className={css(styles.navbarItem)} >
                    iPTMnet
                </Link>

                <div id="seperator" className={css(styles.seperator)} />

                <Link id="nav_browse" to="/browse" className={css(styles.navbarItem)} >
                    Browse
                </Link>

                <div id="seperator" className={css(styles.seperator)} />         
                
                <Link id="nav_stats" to="/statistics" className={css(styles.navbarItem)} >
                    Statistics
                </Link>
                
                <div id="seperator" className={css(styles.seperator)} />
                
                <Link id="nav_api" to="/api" className={css(styles.navbarItem)} >
                    API
                </Link>
                
                <div id="seperator" className={css(styles.seperator)} />

                <a id="nav_help"
                   href="https://research.bioinformatics.udel.edu/iptmnet/static/iptmnet/files/iPTMnet_Help.pdf"
                   target="_"
                   className={css(styles.navbarItem)} >
                    Help
                </a>

                <div id="seperator" className={css(styles.seperator)} />

                <Link id="nav_license" to="/license" className={css(styles.navbarItem)} >
                    License
                </Link>
                
                <div id="seperator" className={css(styles.seperator)} />

                <Link id="nav_citation" to="/citation" className={css(styles.navbarItem)} >
                    Citation
                </Link>

                <div id="seperator" className={css(styles.seperator)} />  

                <Link id="nav_about" to="/about" className={css(styles.navbarItem)} >
                    About
                </Link>

                <div id="seperator" className={css(styles.seperator)} />
            
            </div>
        </div>
    );
  }
}

const styles = StyleSheet.create({
  navbar: {
    height: 40,
    backgroundColor: "#329CDA",
    display: "flex",
    flexDirection: "row",
    alignItems: "center",
    fontSize: "1em"
  },

  navbar_container: {
    position: "sticky",
    top: 0,
    boxShadow: "0px 4px 8px #83838354"
  },

  navbarItem : {
    color: "#FFFFFF",
    paddingLeft: 40,
    paddingRight: 40,
    lineHeight: '40px',
    fontSize: "1em",
    textDecoration: "none",
    ':hover': {
        cursor: "pointer",
        backgroundColor: "#00000017"
    }
  },

  seperator : {
    height: "50%",
    width : "1px",
    backgroundColor: "#FFFFFF"
  }

});

export default Navbar;
