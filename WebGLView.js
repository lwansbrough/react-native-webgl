import React, { findNodeHandle, requireNativeComponent } from 'react-native';
const { NativeModules } = React;

const WEBGL_VIEW_REF = 'webgl';

export default class WebGLView extends React.Component {
  
  static propTypes = {
    
  };
  
  componentWillMount() {
    NativeModules.WebGLViewManager.initialize();
  }
  
  setNativeProps(props) {
    this.refs[WEBGL_VIEW_REF].setNativeProps(props);
  }
  
  getContext() {
    return JSON.parse(global.RNWebGLGetContext(findNodeHandle(this)));
  }
  
  render() {
    return <NativeWebGLView refs={WEBGL_VIEW_REF} {...this.props}/>;
  }
}

var NativeWebGLView = requireNativeComponent('WebGLView', WebGLView);
