import { CommonStyles } from "../misc/CommonStyles";
import { css, StyleSheet } from "aphrodite";
import * as React from "react";
import { SequenceViewerState } from "../redux/states/SequenceViewerState";
import { RequestState } from "../redux/states/RequestState";
import axios from "axios";
import { JsonConvert } from "json2typescript";
import { Alignment } from "../models/Alignment";
import { AlignmentItem } from "src/models/AlignmentItem";

interface ISequenceViewerProps {
    id: string
}

class SequenceViewer extends React.Component<ISequenceViewerProps,SequenceViewerState> {
    
    constructor(props: ISequenceViewerProps){
        super(props);
        this.state = new SequenceViewerState();
    }

    public async componentDidMount() {
        this.setState(new SequenceViewerState(RequestState.LOADING,[]))
        axios.get(`https://research.bioinformatics.udel.edu/iptmnet/api/${this.props.id}/msa`).then((res)=> {
            if(res.status === 200){
                const jsonConvert: JsonConvert = new JsonConvert();
                const proteoforoms = jsonConvert.deserializeArray(res.data,Alignment);
                const state = new SequenceViewerState(RequestState.SUCCESS,proteoforoms,"");
                this.setState(state);
            }else{
                const error = res.statusText + ":" + res.data;
                this.setState(new SequenceViewerState(RequestState.ERROR,[],error));
            }    
        }).catch((err)=>{
            console.log(err)
            this.setState(new SequenceViewerState(RequestState.ERROR,[],err.toString()))
        });
    }

    public render(){
        return (
            <div id="sequence_viewer" style={{marginTop:25}} >
                <div id="title" className={css(CommonStyles.sectionTitle)} >
                    Interactive Sequence View
                </div>
                <div id="msa_container" className={css(styles.msa_container)}  >
                    <div id="labels" className={css(styles.labels)} >
                        <div id="ruler_space" className={css(styles.rulerSpace)} >

                        </div>
                        {this.state.data.map(this.buildLabel(this.state.selectedRow))}
                    </div>
                    <div id="sequences" className={css(styles.sequences)}  >
                        <div id="ruler_space" className={css(styles.rulerSpace)} >

                        </div>

                        {this.state.data.map(this.buildSequence)}
                        
                    </div>
                </div>
            </div>
        )
    }

    private buildLabel = (selectedRow: number) => (alignment: Alignment, index: number) => {
        return (
            <div id={"label_" + alignment.id} className={this.buildLabelItemStyle(selectedRow,index)}  >
                 {alignment.id}
            </div>
        )
    }

    private buildLabelItemStyle = (selectedRow: number, currentRow: number) => {
        if(selectedRow === currentRow) {
            return css(styles.labelItem,styles.labelItemSelected)
        }else{
            return css(styles.labelItem)
        }
    }

    private buildSequence = (alignment: Alignment, index: number) => {
        return (
            <div id={"seq_" + alignment.id} className={css(styles.sequence)}  >
                 {alignment.sequence.map(this.buildSequenceItem(index))}
            </div>
        )
    }


    private buildSequenceItem = (rowIndex: number) => (alignmentItem: AlignmentItem , index: number) => {
        return (
            <div id={rowIndex.toString() + index.toString()} className={this.buildSequenceItemStyle(alignmentItem)} onMouseEnter={this.onSequenceHover(rowIndex)}  >
                 {alignmentItem.site}
            </div>
        )
    }

    private buildSequenceItemStyle = (alignmentItem: AlignmentItem) => {
        if(alignmentItem.decorations.length === 0){
            return css(styles.sequenceItem,styles.sequenceItemHoverEmpty)
        }else if(alignmentItem.decorations.length > 1){
            return css(styles.sequenceItem,styles.sequenceItemMultipleDecorations)
        }else{
            const decoration  = alignmentItem.decorations[0]; 
            const ptm_type = decoration.ptm_type.trim().toLowerCase();
            if( ptm_type !== ""){
                switch(ptm_type) {
                    case "phosphorylation": {
                        return css(styles.sequenceItem,styles.sequenceItemPhosporylation)
                    }
                    case "acetylation": {
                        return css(styles.sequenceItem,styles.sequenceItemAcetylation)
                    }
                    case "n-glycosylation": {
                        return css(styles.sequenceItem,styles.sequenceItemNGylcosylation)
                    }
                    case "o-glycosylation": {
                        return css(styles.sequenceItem,styles.sequenceItemOGylcosylation)
                    }
                    case "s-glycosylation": {
                        return css(styles.sequenceItem,styles.sequenceItemSGylcosylation)
                    }
                    case "c-glycosylation": {
                        return css(styles.sequenceItem,styles.sequenceItemCGylcosylation)
                    }
                    case "methylation": {
                        return css(styles.sequenceItem,styles.sequenceItemMethylation)
                    }
                    case "ubiquitination": {
                        return css(styles.sequenceItem,styles.sequenceItemUbiquitination)
                    }
                    case "myristoylation": {
                        return css(styles.sequenceItem,styles.sequenceItemMyristoylation)
                    }
                    case "s-nitrosylation": {
                        return css(styles.sequenceItem,styles.sequenceItemSnitrosylation)
                    }
                    default: {
                        return css(styles.sequenceItem,styles.sequenceItemHoverEmpty)
                    }
                }
            } else if(decoration.is_conserved){
                return css(styles.sequenceItem,styles.sequenceItemConserved)
            }            
            else{
                return css(styles.sequenceItem,styles.sequenceItemHoverEmpty)
            }
        }
    }


    private onSequenceHover = (rowIndex: number) => (event: any) => {
        this.setState({...this.state,selectedRow: rowIndex})
    }
    
}

export const styles = StyleSheet.create({
    msa_container: {
        display: "flex",
        flexDirection: "row",
        "align-items": "top"    
    },

    labels: {
        flex: 1,
        backgroundColor: "#f9f9f9"
    },

    labelItem: {
        display: "flex",
            alignItems: "center",
            minHeight: 25,
            fontSize: "0.70em",
            paddingLeft: 25,
            hover: {
                cursor: "pointer",
                backgroundColor: "#329CDA",
                color: "#FFFFFF"
        }
    },

    labelItemSelected: {
        color: "#FFFFFF",
        backgroundColor: "#329CDA"
    },

    sequences: {
        flex: 5,
        paddingLeft: 10,
        paddingBottom: 10,
        overflowX: "auto",
        overflowY: "hidden",
    },
    
    rulerSpace: {
        display: "flex",
        flexDirection: "row",
        alignItems: "center",
        backgroundColor: "#f9f9f9",
        minHeight: 25,
        fontSize: "0.70em",
        paddingLeft: 25 
    },

    sequence: {
        display: "flex",
        flexDirection: "row",
        paddingLeft: 10
    },
    

    sequenceItem: {
        minWidth: 10,
        fontSize: "0.70em",
        minHeight: 25,
        alignItems: "center",
        textAlign: "center",
        verticalAlign: "center",
        lineHeight: "25px"
    },

    sequenceItemHoverEmpty: {
        ":hover": {
            cursor: "pointer",
            backgroundColor: "#329CDA",
            color: "#ffffff"
        },
    },
    
    sequenceItemMultipleDecorations: {
        color: "#FFFFFF",
        backgroundColor: "#f7c23d",
        ":hover": {
            cursor: "pointer",
            backgroundColor: "#329CDA",
            color: "#ffffff"
        },
    },

    sequenceItemPhosporylation: {
        color: "#FFFFFF",
        backgroundColor: "#f4428c",
        ":hover": {
            cursor: "pointer",
            filter: "brightness(80%)",
            color: "#ffffff"
        },
    },

    sequenceItemAcetylation: {
        color: "#FFFFFF",
        backgroundColor: "#bf42f4",
        ":hover": {
            cursor: "pointer",
            filter: "brightness(80%)",
            color: "#ffffff"
        },
    },

    sequenceItemNGylcosylation: {
        color: "#FFFFFF",
        backgroundColor: "#0bbc64",
        ":hover": {
            cursor: "pointer",
            filter: "brightness(80%)",
            color: "#ffffff"
        },
    },

    sequenceItemOGylcosylation: {
        color: "#FFFFFF",
        backgroundColor: "#0bbc64",
        ":hover": {
            cursor: "pointer",
            filter: "brightness(80%)",
            color: "#ffffff"
        },
    },

    sequenceItemSGylcosylation: {
        color: "#FFFFFF",
        backgroundColor: "#0bbc64",
        ":hover": {
            cursor: "pointer",
            filter: "brightness(80%)",
            color: "#ffffff"
        },
    },

    sequenceItemCGylcosylation: {
        color: "#FFFFFF",
        backgroundColor: "#0bbc64",
        ":hover": {
            cursor: "pointer",
            filter: "brightness(80%)",
            color: "#ffffff"
        },
    },

    sequenceItemMethylation: {
        color: "#FFFFFF",
        backgroundColor: "#42cef4",
        ":hover": {
            cursor: "pointer",
            filter: "brightness(80%)",
            color: "#ffffff"
        },
    },
    
    sequenceItemUbiquitination: {
        color: "#FFFFFF",
        backgroundColor: "#415cf4",
        ":hover": {
            cursor: "pointer",
            filter: "brightness(80%)",
            color: "#ffffff"
        },
    },

    sequenceItemMyristoylation: {
        color: "#FFFFFF",
        backgroundColor: "#058252",
        ":hover": {
            cursor: "pointer",
            filter: "brightness(80%)",
            color: "#ffffff"
        },
    },

    sequenceItemSnitrosylation: {
        color: "#FFFFFF",
        backgroundColor: "#821704",
        ":hover": {
            cursor: "pointer",
            filter: "brightness(80%)",
            color: "#ffffff"
        },
    },

    sequenceItemConserved: {
        color: "#FFFFFF",
        backgroundColor: "#cecccc",
        ":hover": {
            cursor: "pointer",
            filter: "brightness(80%)",
            color: "#ffffff"
        },
    }


})

export default SequenceViewer;
