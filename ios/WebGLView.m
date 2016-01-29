//
//  WebGLView.m
//  RNWebGL
//
//  Created by Lochlan Wansbrough on 2016-01-28.
//  Copyright © 2016 Lochlan Wansbrough. All rights reserved.
//

#import "WebGLView.h"
#import <QuartzCore/QuartzCore.h>

@implementation WebGLView

- (void)setUp {
  if (self.reactTag) {
    webGLContext = [[WebGLContext alloc] init];
    glkView = [[GLKView alloc] initWithFrame:self.bounds context:[webGLContext context]];
    glkView.delegate = self;
    glkView.enableSetNeedsDisplay = NO;
    
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(render:)];
    [displayLink setFrameInterval:1];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
  }
}

- (id)init {
  if (self = [super init]) {
    [self setUp];
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self setUp];
  }
  return self;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
  glClearColor(1.0, 0.0, 0.0, 1.0);
  glClear(GL_COLOR_BUFFER_BIT);
}

- (void)layoutSubviews {
  [super layoutSubviews];
  glkView.bounds = self.bounds;
  [webGLContext resizeToWidth:glkView.bounds.size.width height:glkView.bounds.size.height];
  [self addSubview:glkView];
}

- (void)render:(CADisplayLink*)displayLink {
  if (isPaused) { return; }
  [glkView display];
}

- (NSDictionary *)getContext {
  
  
  NSMutableDictionary *canvas = [[NSMutableDictionary alloc] init];
  [canvas setObject:[NSNumber numberWithFloat:self.bounds.size.height] forKey:@"height"];
  [canvas setObject:[NSNumber numberWithFloat:self.bounds.size.width] forKey:@"width"];
  
  NSMutableDictionary *context = [[NSMutableDictionary alloc] init];
  [context setValue:canvas forKey:@"canvas"];
  return context;
}

@end
