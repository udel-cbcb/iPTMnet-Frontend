import * as React from "react";
import { State } from "src/redux/state";
import { connect } from "react-redux";
import { RequestState} from "src/redux/states/RequestState";

interface IBatchResultEnzymeProps {
    status: RequestState
    error: string
    data: any 
}

export class BatchResultEnzyme extends React.Component<IBatchResultEnzymeProps> {
    
    constructor(props: IBatchResultEnzymeProps) {
       super(props);
    }
    
    public render() {

        let content;
        
        if(this.props.status === RequestState.SUCCESS){
            content = this.renderSuccess();
        }
        else if(this.props.status === RequestState.LOADING) {
            content = this.renderLoading();
        }else if(this.props.status === RequestState.ERROR) {
            content = this.renderError();
        }else {
            content = (<div>
                Nothing here
            </div>);
        }

        return (
            <div>
                {content}
            </div>
        );
    }

    private renderSuccess = () => {
        return (
            <div>

            </div>
        );
    }

    private renderLoading = () => {
        return (
            <div>
                
            </div>
        );
    }

    private renderError = () => {
        return (
            <div>
                
            </div>
        );
    }

}



const mapStateToProps = (state: State) => ({
    status: state.batchPage.enzymes.status,
    data: state.batchPage.enzymes.data,
    error: state.batchPage.enzymes.error
});
    
export const BatchResultEnzymeConnected = connect(mapStateToProps,{})(BatchResultEnzyme);



