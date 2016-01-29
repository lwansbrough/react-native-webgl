//
//  WebGLManager.m
//  WebGLManager
//
//  Created by Lochlan Wansbrough on 2016-01-24.
//  Copyright © 2016 Lochlan Wansbrough. All rights reserved.
//
#import "WebGLViewManager.h"

#import <GLKit/GLKit.h>
#import "RCTLog.h"
#import "RCTBridge.h"
#import "RCTBridge+Private.h"
#import "RCTJSCExecutor.h"
#import "RCTUtils.h"
#import "UIView+React.h"
#import "WebGLView.h"
#import "RCTUIManager.h"
#import "RCTLog.h"

@interface WebGLViewManager()

@end

@implementation WebGLViewManager

RCT_EXPORT_MODULE()

- (UIView *)viewWithProps:(__unused NSDictionary *)props
{
  return [self view];
}

- (UIView *)view
{
  WebGLView *view = [[WebGLView alloc] init];
  return view;
}

- (RCTJSCExecutor *) getJSCExecutor {
  __strong id jsExecutor = [self.bridge valueForKey:@"javaScriptExecutor"];
  if ([jsExecutor isKindOfClass:[RCTJSCExecutor class]]) {
    return jsExecutor;
  }
  return nil;
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(initialize) {
  WebGLViewManager *strongSelf = self;
  __weak RCTJSCExecutor *weakJSCExecutor = [self getJSCExecutor];
  
  [weakJSCExecutor addSynchronousHookWithName:@"RNWebGLGetContext" usingBlock:^NSString* (NSNumber *reactTag){
    RCTJSCExecutor *strongJSCExecutor = weakJSCExecutor;
    if (!strongJSCExecutor.valid) {
      return nil;
    }
    __block NSString *contextJSON = nil;
    dispatch_sync(dispatch_get_main_queue(), ^{
      __strong id view = [strongSelf.bridge.uiManager viewForReactTag:reactTag];
      if (![view isKindOfClass:[WebGLView class]]) {
        RCTLog(@"Invalid view returned from registry, expecting WebGLView, got: %@", view);
      }
      contextJSON = RCTJSONStringify([((WebGLView*)view) getContext], NULL);
    });
    return contextJSON;
  }];
}

@end
