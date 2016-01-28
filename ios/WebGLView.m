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

- (void)setUpWithContext:(EAGLContext *)context {
  if (self.reactTag) {
    self.glkView = [[GLKView alloc] initWithFrame:self.bounds context:context];
    self.glkView.delegate = self;
    self.glkView.enableSetNeedsDisplay = NO;
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(render:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
  }
}

- (id)initWithContext:(EAGLContext *)context {
  if (self = [super init]) {
    [self setUpWithContext:context];
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame context:(EAGLContext *)context {
  if (self = [super initWithFrame:frame]) {
    [self setUpWithContext:context];
  }
  return self;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
  glClearColor(1.0, 0.0, 0.0, 1.0);
  glClear(GL_COLOR_BUFFER_BIT);
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.glkView.bounds = self.bounds;
  [self addSubview:self.glkView];
}

- (void)render:(CADisplayLink*)displayLink {
  [self.glkView display];
}

- (NSDictionary *)getContext {
  return [[NSDictionary alloc] init];
}

@end
