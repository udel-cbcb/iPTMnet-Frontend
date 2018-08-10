import * as React from 'react';

interface IEntryProps {
  id: string;
}

class Error extends React.Component<IEntryProps,{}> {

  constructor(props: IEntryProps) {
    super(props);
  }

  public render() {
    return (
      <div>
        <div>  
        </div> 
      </div>
    );
  }
}

export default Error;
