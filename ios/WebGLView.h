//
//  WebGLView.h
//  RNWebGL
//
//  Created by Lochlan Wansbrough on 2016-01-28.
//  Copyright © 2016 Lochlan Wansbrough. All rights reserved.
//

#import <GLKit/GLKit.h>
#import <UIKit/UIKit.h>
#import "UIView+React.h"
#import "WebGLContext.h"

@interface WebGLView : UIView <GLKViewDelegate> {
  WebGLContext *webGLContext;
  CADisplayLink *displayLink;
  GLKView *glkView;
  
  BOOL isPaused;
}

- (WebGLContext*)getContext;

@end
