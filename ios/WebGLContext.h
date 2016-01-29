//
//  WebGLContext.h
//  RNWebGL
//
//  Created by Lochlan Wansbrough on 2016-01-28.
//  Copyright © 2016 Lochlan Wansbrough. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/glext.h>

@interface WebGLContext : NSObject {
  int msaaSamples;
  BOOL msaaEnabled;
  BOOL preserveDrawingBuffer;
  GLuint viewFrameBuffer, viewRenderBuffer;
  GLuint msaaFrameBuffer, msaaRenderBuffer;
  GLuint boundFrameBuffer, boundRenderBuffer;
  GLuint depthStencilBuffer;
  GLuint bufferHeight, bufferWidth;
  short height, width;
  EAGLContext *context;
}

@property (nonatomic) BOOL needsPresenting;

- (void)resizeAuxiliaryBuffers;
- (void)resizeToWidth:(short)newWidth height:(short)newHeight;
- (void)bindFramebuffer:(GLuint)framebuffer toTarget:(GLuint)target;
- (void)bindRenderbuffer:(GLuint)framebuffer toTarget:(GLuint)target;
- (void)create;
- (void)prepare;
- (void)clear;
- (EAGLContext *)context;

@end
