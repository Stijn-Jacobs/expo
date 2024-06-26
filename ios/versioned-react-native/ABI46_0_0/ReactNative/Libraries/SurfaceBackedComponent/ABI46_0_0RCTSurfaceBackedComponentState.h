/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import <UIKit/UIKit.h>

@protocol ABI46_0_0RCTSurfaceProtocol;

@interface ABI46_0_0RCTSurfaceBackedComponentState: NSObject

@property (atomic, readonly, strong) id<ABI46_0_0RCTSurfaceProtocol> surface;

+ (instancetype)newWithSurface:(id<ABI46_0_0RCTSurfaceProtocol>)surface;

@end
