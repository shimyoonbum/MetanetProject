import React, { Component } from 'react';
 
import Test_props from './Test_props';
 
class Test_comp extends Component {
  render(){
    let testText = 'test props...';
    return(
      <div>
        <h1>test component</h1>
        <Test_props text={testText} />
      </div>
    )
  }
}
 
export default Test_comp;