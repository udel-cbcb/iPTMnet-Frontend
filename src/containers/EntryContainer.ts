import { State } from "src/redux/state";
import { Dispatch, bindActionCreators } from "redux";
import { connect } from 'react-redux';
import Entry from "../pages/Entry";

const mapStateToProps = (state: State) => ({
    id: state.entryPage.id,
  });
  
const mapDispatchToProps = (dispatch: Dispatch) => bindActionCreators({}, dispatch);
  
export const EntryPageConnected = connect(mapStateToProps, mapDispatchToProps)(Entry);