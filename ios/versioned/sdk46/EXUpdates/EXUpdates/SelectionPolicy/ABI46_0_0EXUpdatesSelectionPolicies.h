//  Copyright © 2021 650 Industries. All rights reserved.

#import <ABI46_0_0EXUpdates/ABI46_0_0EXUpdatesUpdate.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Utilities for ABI46_0_0EXUpdatesSelectionPolicy and related classes
 */
@interface ABI46_0_0EXUpdatesSelectionPolicies : NSObject

+ (BOOL)doesUpdate:(ABI46_0_0EXUpdatesUpdate *)update matchFilters:(nullable NSDictionary *)filters;

@end

NS_ASSUME_NONNULL_END
