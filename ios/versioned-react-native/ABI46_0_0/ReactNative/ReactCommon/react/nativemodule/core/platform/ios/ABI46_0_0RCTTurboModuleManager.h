/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#pragma once

#import <memory>

#import "ABI46_0_0RCTTurboModule.h"

#import <ABI46_0_0ReactCommon/ABI46_0_0RuntimeExecutor.h>

@protocol ABI46_0_0RCTTurboModuleManagerDelegate <NSObject>

@optional
- (NSArray<NSString *> *)getEagerInitModuleNames;
- (NSArray<NSString *> *)getEagerInitMainQueueModuleNames;

/**
 * Given a module name, return its actual class. If not provided, basic ObjC class lookup is performed.
 */
- (Class)getModuleClassFromName:(const char *)name;

/**
 * Given a module class, provide an instance for it. If not provided, default initializer is used.
 */
- (id<ABI46_0_0RCTTurboModule>)getModuleInstanceFromClass:(Class)moduleClass;

/**
 * Create an instance of a TurboModule without relying on any ObjC++ module instance.
 */
- (std::shared_ptr<ABI46_0_0facebook::ABI46_0_0React::TurboModule>)getTurboModule:(const std::string &)name
                                                      jsInvoker:
                                                          (std::shared_ptr<ABI46_0_0facebook::ABI46_0_0React::CallInvoker>)jsInvoker;

@end

@interface ABI46_0_0RCTTurboModuleManager : NSObject <ABI46_0_0RCTTurboModuleRegistry>

- (instancetype)initWithBridge:(ABI46_0_0RCTBridge *)bridge
                      delegate:(id<ABI46_0_0RCTTurboModuleManagerDelegate>)delegate
                     jsInvoker:(std::shared_ptr<ABI46_0_0facebook::ABI46_0_0React::CallInvoker>)jsInvoker;

- (void)installJSBindingWithRuntimeExecutor:(ABI46_0_0facebook::ABI46_0_0React::RuntimeExecutor)runtimeExecutor;

- (void)invalidate;

@end
