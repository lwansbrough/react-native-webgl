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

@interface WebGLView : UIView <GLKViewDelegate>

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) GLKView *glkView;

- (id)initWithContext:(EAGLContext *)context;
- (id)initWithFrame:(CGRect)frame context:(EAGLContext *)context;

- (EAGLContext*)getContext;

@end
