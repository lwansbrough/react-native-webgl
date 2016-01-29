import React, {
  findNodeHandle,
  requireNativeComponent,
  NativeAppEventEmitter
} from 'react-native';
import WebGLFakeCanvas from './WebGLFakeCanvas';
const { NativeModules } = React;

const WEBGL_VIEW_REF = 'webgl';

export default class WebGLView extends React.Component {
  
  static propTypes = {
  };
  
  constructor() {
    super();
    this.subscriptions = [];
  }
  
  setNativeProps(props) {
    this.refs[WEBGL_VIEW_REF].setNativeProps(props);
  }
  
  componentWillMount() {
    this.subscriptions.push(NativeAppEventEmitter.addListener('RNWebGLContextLost',
      (reactId) => {
        if (reactId === findNodeHandle(this)) {
          this.canvas.emit('webglcontextlost');
        }
      }
    ));
    NativeModules.WebGLViewManager.initialize();
  }
  
  componentWillUnmount() {
    this.subscriptions.forEach(sub => sub.remove());
  }
  
  getContext() {
    let context = JSON.parse(global.RNWebGLGetContext(findNodeHandle(this)));
    context.canvas = new WebGLFakeCanvas(context.canvas);
    return context;
  }
  
  render() {
    return <NativeWebGLView refs={WEBGL_VIEW_REF} {...this.props}/>;
  }
}

var NativeWebGLView = requireNativeComponent('WebGLView', WebGLView);
