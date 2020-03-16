import React from 'react';
import ReactDOM from 'react-dom';
 
import Test_comp from './components/test_comp';
 
const title = 'Is it working? hot module replacement...';
 
ReactDOM.render(
  <Test_comp />,
  document.getElementById('root')
);