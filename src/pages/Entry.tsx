import * as React from 'react';
import Navbar from '../views/Navbar';

interface IEntryProps {
  id: string;
}

class Entry extends React.Component<IEntryProps,{}> {

  constructor(props: IEntryProps) {
    super(props);
  }

  public render() {
    return (
      <div>
        <Navbar/>
        <div>
          {this.props.id}  
        </div> 
      </div>
    );
  }
}

export default Entry;
