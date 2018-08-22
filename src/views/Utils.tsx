import * as React from "react";
import * as intersperse from "intersperse";
import { Source } from "src/models/Source";
import { PTMEnzyme } from "src/models/PTMEnzyme";

export function buildSource(source: Source) {
        
    const sourceUrl = "#"
    
    return (
         <a href={sourceUrl} target="_" >
            {source.label}
         </a>
     )
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
    return (
        <div style={{display: "inline"}} >
            {interspersedPMIDs}
        </div>
    );
}

function comma() {
    return (<span key={Math.random()} >
        ,&nbsp;
    </span>);
}

export function buildPTMEnzyme(enzyme: PTMEnzyme){
    if(enzyme.pro_id !== ""){
        return (
            <div >
                <a href={"http://purl.obolibrary.org/obo/" + enzyme.pro_id} style={{marginRight:5}} >
                    {enzyme.pro_id}
                </a>

                {"(" + enzyme.label + ")" }
            </div>
        );
    }else{
        return (
            <div>

            </div>
        );
    }
}


