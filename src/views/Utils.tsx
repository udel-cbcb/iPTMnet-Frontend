import * as React from "react";
import * as intersperse from "intersperse";
import { Source } from "src/models/Source";
import { PTMEnzyme } from "src/models/PTMEnzyme";
import { Enzyme } from "src/models/Enzyme";
import { css,StyleSheet } from "aphrodite";

export function buildSource(source: Source, index: number = 0) {
        
    const sourceUrl = "#"
    
    return (
         <a href={sourceUrl} target="_" key={index} >
            {source.label}
         </a>
     )
}

export function buildSources(sources: Source[]) {
    const builtSources = sources.map(buildSource);
    const interspersed = intersperse(builtSources,comma()).map((elem: any, index: number) => {
        return {...elem,key: index.toString()};
    })
    return (
        <div style={{display: "inline",wordBreak: "break-all"}} >
            {interspersed}
        </div>
    );
}

export function buildPMID(pmid: string, index: number) {
    return (
        <a href={"https://www.ncbi.nlm.nih.gov/pubmed" + pmid} key={index} >
            {pmid}
        </a>
    )
}

export function buildPMIDs(pmids: string[]){
    const builtPMIDs = pmids.map(buildPMID);
    const interspersedPMIDs = intersperse(builtPMIDs,comma())
    const interspersedPMIDsWithKeys = interspersedPMIDs.map((elem:any,index:number)=>{
        return {...elem,key:index.toString()}
    });
    return (
        <div style={{display: "inline",wordBreak: "break-all"}} >
            {interspersedPMIDsWithKeys}
        </div>
    );
}

export function comma() {
    return (<span key={""} >
        ,&nbsp;
    </span>);
}

export function buildPTMEnzyme(enzyme: PTMEnzyme,index: number = 0){
    if(enzyme.pro_id !== ""){
        return (
            <div key={index}>
                <a href={"http://purl.obolibrary.org/obo/" + enzyme.pro_id} style={{marginRight:5}} >
                    {enzyme.pro_id}
                </a>

                {"(" + enzyme.label + ")" }
            </div>
        );
    }else{
        return (
            <div key={index}>

            </div>
        );
    }
}

export function buildEnzymes(enzymes: Enzyme[]) {
    const builtEnzymes = enzymes.map(buildEnzyme);
    const interspersed = intersperse(builtEnzymes, comma()).map((elem: any, index: number)=>{
        return {...elem,key:index.toString()};
    })
    return interspersed;
}

export function buildEnzyme(enzyme: Enzyme,index: number = 0) {
    if(enzyme.id){
        return (
            <div key={index} style={{display: "inline"}} >
                <a href={"http://purl.obolibrary.org/obo/" + enzyme.id} style={{marginRight:5}} >
                    {enzyme.id}
                </a>

                {"(" + enzyme.name + ")" }
            </div>
        );
    }else{
        return (
            <div key={index}>

            </div>
        );
    }
}

export function renderScore(score: number) {

    return (<div className={css(styles.scoreContainer)} >
        {getScoreIcon(1,score)}
        {getScoreIcon(2,score)}
        {getScoreIcon(3,score)}
        {getScoreIcon(4,score)}
    </div>);        
}

export function getScoreIcon(index: number, score: number) {
    if(index <= score){
        return (
            <div className={css(styles.scoreItem)} >
                &#xf4b3;
            </div>
        )
    }else{
        return (
            <div className={css(styles.scoreItem)} >
                &#xf4b2;
            </div>
        )
    }
}
const styles = StyleSheet.create({
    scoreContainer: {
        display: "flex",
        flexDirection: "row",
        alignItems: "center",
    },

    scoreItem: {
        fontFamily: "Ionicons",
        marginLeft: 2.5,
        marginRight: 2.5,
        color: "#329CDA",
    }
})


