import * as markjs from "mark.js"
import { Entity } from '../models/Entity';
import { Source } from "src/models/Source";
import { Enzyme } from "src/models/Enzyme";

export function extractSearchTerm(query_string: string): string {
    return query_string.substring(query_string.indexOf("=")+1,query_string.indexOf("&"));
}

export function highLight(word: string, div_name: string) {
    setTimeout(()=>{
        const context = document.getElementById(div_name);
        if(context !== null){
            const instance = new markjs(context);
            instance.mark(word);
        }        
    },0);
}

export function scrollToElement(elementName: string) {
    const elem = document.getElementById(elementName);
    if(elem){
        elem.scrollIntoView();
    }
}

export function filterEntity(entity: Entity, searchTerm: string) : boolean {
    const searchTermRegex = new RegExp(searchTerm, "i");
    if(entity.name.search(searchTermRegex) !== -1 ){
        return true;
    }else if(entity.uniprot_id.search(searchTermRegex) !== -1 ){
        return true;
    }else{
        return false;
    }
}

export const filterSource = (searchTerm: string) => (source: Source, index: number, sources: Source[]) => {
    const searchTermRegex = new RegExp(searchTerm, "i");
    if(source.label.search(searchTermRegex) !== -1 ){
        return true;
    }else if(source.name.search(searchTermRegex) !== -1 ){
        return true;
    }
    else{
        return false;
    }
}

export const filterPMIDS = (searchTerm: string) => (pmid: string, index: number, pmids: string[]) => {
    const searchTermRegex = new RegExp(searchTerm, "i");
    if(pmid.search(searchTermRegex) !== -1 ){
        return true;
    }else{
        return false;
    }
}

export const filterEnzyme = (searchTerm: string) => (enzyme: Enzyme, index: number, enzymes: Enzyme[]) => {
    const searchTermRegex = new RegExp(searchTerm, "i");
    if(enzyme.id && enzyme.id.search(searchTermRegex) !== -1 ){
        return true;
    }else if(enzyme.name && enzyme.name.search(searchTermRegex) !== -1 ){
        return true;
    }else if(enzyme.enz_type && enzyme.enz_type.search(searchTermRegex) !== -1 ){
        return true;
    }
    else{
        return false;
    }
}

