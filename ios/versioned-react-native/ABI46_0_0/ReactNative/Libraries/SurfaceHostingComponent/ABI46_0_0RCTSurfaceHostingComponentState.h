/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import <UIKit/UIKit.h>

#import <ABI46_0_0React/ABI46_0_0RCTSurfaceStage.h>

@interface ABI46_0_0RCTSurfaceHostingComponentState: NSObject

@property (nonatomic, readonly, assign) CGSize intrinsicSize;
@property (nonatomic, readonly, assign) ABI46_0_0RCTSurfaceStage stage;

+ (instancetype)newWithStage:(ABI46_0_0RCTSurfaceStage)stage
               intrinsicSize:(CGSize)intrinsicSize;

@end
