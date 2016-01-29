import { EventEmitter } from 'events';

export default class WebGLFakeCanvas {
  constructor(props) {
    this.height = props.height;
    this.width = props.width;
    this.events = new EventEmitter();
  }
  
  emit(name, data) {
    this.events.emit(name, data);
  }
  
  addEventListener(name, callback) {
    this.events.addListener(name, callback);
  }
  
  removeEventListener(name, callback) {
    this.events.removeListener(name, callback);
  }
}
