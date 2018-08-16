import {StyleSheet} from 'aphrodite';
export const CommonStyles = StyleSheet.create({
    page : {
      height: "100%",
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
      alignItems: "center",
      "flex-grow": "1",
      paddingTop: "20",
      overflow: "auto"
    },
  
    searchContainer : {
      display: "flex",
      flexDirection: "column",
      alignItems: "center",
      paddingTop: 100,
      paddingBottom: 100
    },
  
    title : {
      fontSize: "5em",
      marginTop: "0.1em"
    },
  
    grantContainer : {
      marginTop: 5,
      display: "flex",
      flexDirection: "row",
      alignItems: "center",
      fontSize: "1em"
    },
  
    grant1 : {
      marginLeft: 10,
      fontSize: "0.85em",
      
      ":link": {
          color: "#329CDA"
      },
      
      ":visited": {
          color: "#329CDA"
      }
    },
  
    info: {
      display: "flex",
      width: 680,
      marginTop: 30,
      flexDirection: "column",
      alignItems: "center",
      fontSize: "1em",
      color: "#606060ff"
    },
  
  
    filer: {
      alignSelf: "stretch"
    },

    sectionTitle: {
      fontSize: "1.2em",
      fontWeight: "normal"
    }  
  
  
  });