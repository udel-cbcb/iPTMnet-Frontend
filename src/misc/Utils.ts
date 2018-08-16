import * as markjs from "mark.js"

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