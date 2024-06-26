/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "ABI46_0_0RNSVGLineManager.h"

#import "ABI46_0_0RNSVGLine.h"
#import "ABI46_0_0RCTConvert+RNSVG.h"

@implementation ABI46_0_0RNSVGLineManager

ABI46_0_0RCT_EXPORT_MODULE()

- (ABI46_0_0RNSVGRenderable *)node
{
  return [ABI46_0_0RNSVGLine new];
}

ABI46_0_0RCT_EXPORT_VIEW_PROPERTY(x1, ABI46_0_0RNSVGLength*)
ABI46_0_0RCT_EXPORT_VIEW_PROPERTY(y1, ABI46_0_0RNSVGLength*)
ABI46_0_0RCT_EXPORT_VIEW_PROPERTY(x2, ABI46_0_0RNSVGLength*)
ABI46_0_0RCT_EXPORT_VIEW_PROPERTY(y2, ABI46_0_0RNSVGLength*)

@end
