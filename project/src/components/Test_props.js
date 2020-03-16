import React, { Component } from 'react';
 
class Test_props extends Component {
  render(){
    return(
      <div>
        <p>vlaue which is passed by Test_comp</p>
        <p>{this.props.text}</p>
      </div>
    )
  }
}
 
export default Test_props;