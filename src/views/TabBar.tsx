import * as React from 'react';
import { css,StyleSheet,minify } from 'aphrodite';

minify(false);

interface ITabBarProps {
    tabs: Tab[]
}

class TabBarState {
    public readonly selectedIndex: number
    constructor (selectedIndex: number = 0) {
        this.selectedIndex = selectedIndex;
    }
}

export class Tab {
    public readonly title: string;
    public readonly count: number;

    constructor(title: string, count: number){
        this.title = title;
        this.count = count;
    }

}

class TabBar extends React.Component<ITabBarProps,TabBarState> {
  
    constructor(props: ITabBarProps) {
        super(props);
        this.state = new TabBarState();
    }

    public render() {
    return (
        <div id="tab_bar" className={css(styles.tabbar)} >
            {this.props.tabs.map(this.buildTab)}
        </div>
    );
  }

  private buildTab = (tab: Tab, index: number) => {
    let visibility;
    if(this.state.selectedIndex === index) {
        visibility = styles.visible;
    }else{
        visibility = styles.invisible;
    }
    return <div className={css(styles.tab)} onClick={(event: any)=> {this.setState({...this.state,selectedIndex:index})}}  >
        <div id="title" className={css(styles.title)} >
            {tab.title}
        </div>
        <div id="selectionBar" className={css(styles.selectionBar,visibility)}>

        </div>
         <div id="count" className={css(styles.count)} >
            {tab.count}
         </div>
    </div>
  }

}

const styles = StyleSheet.create({
   tabbar : {
       display: "flex",
       flexDirection: "row",
       alignItems: "center"
   },
   tab: {
      display: "grid",
      gridTemplateColumns: "auto auto",
      gridTemplateRows: "auto min-content",
      gridTemplateAreas: '"one  three" "two  three"',
      ":hover" : {
          cursor: "pointer"
      } 
   },
   title: {
      gridArea: "one",
      padding: 5,
      marginLeft: 10,
   },
   selectionBar: {
       minHeight: 2,
       backgroundColor: "#329CDA",
       gridArea: "two"
   },
   count: {
       borderRadius: "50%",
       width: 15,
       height: 15,
       padding: 2,
       fontSize: "0.8em",
       backgroundColor: "#329CDA",
       color: "white",
       textAlign: "center",
       gridArea: "three",
       alignSelf: "center",
       marginLeft: 10,
       marginRight: 10
   },
   visible: {
       visibility: "visible"
   },
   invisible: {
       visibility: "hidden"
   }
});

export default TabBar;
