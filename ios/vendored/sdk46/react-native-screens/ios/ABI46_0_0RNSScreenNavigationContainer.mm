#import "ABI46_0_0RNSScreenNavigationContainer.h"
#import "ABI46_0_0RNSScreen.h"
#import "ABI46_0_0RNSScreenContainer.h"

#ifdef RN_FABRIC_ENABLED
#import <react/renderer/components/rnscreens/ComponentDescriptors.h>
#import <react/renderer/components/rnscreens/Props.h>
#import "ABI46_0_0RCTFabricComponentsPlugins.h"
#endif

@implementation ABI46_0_0RNScreensContainerNavigationController

@end

@implementation ABI46_0_0RNSScreenNavigationContainerView

- (void)setupController
{
  self.controller = [[ABI46_0_0RNScreensContainerNavigationController alloc] init];
  [(ABI46_0_0RNScreensContainerNavigationController *)self.controller setNavigationBarHidden:YES animated:NO];
  [self addSubview:self.controller.view];
}

- (void)updateContainer
{
  for (ABI46_0_0RNSScreenView *screen in self.ABI46_0_0ReactSubviews) {
    if (screen.activityState == ABI46_0_0RNSActivityStateOnTop) {
      // there should never be more than one screen with `ABI46_0_0RNSActivityStateOnTop`
      // since this component should be used for `tabs` and `drawer` navigators
      [(ABI46_0_0RNScreensContainerNavigationController *)self.controller setViewControllers:@[ screen.controller ] animated:NO];
      [screen notifyFinishTransitioning];
    }
  }

  [self maybeDismissVC];
}

#pragma mark-- Fabric specific
#ifdef RN_FABRIC_ENABLED
+ (ABI46_0_0facebook::ABI46_0_0React::ComponentDescriptorProvider)componentDescriptorProvider
{
  return ABI46_0_0facebook::ABI46_0_0React::concreteComponentDescriptorProvider<
      ABI46_0_0facebook::ABI46_0_0React::ABI46_0_0RNSScreenNavigationContainerComponentDescriptor>();
}
#endif

@end

#ifdef RN_FABRIC_ENABLED
Class<ABI46_0_0RCTComponentViewProtocol> ABI46_0_0RNSScreenNavigationContainerCls(void)
{
  return ABI46_0_0RNSScreenNavigationContainerView.class;
}
#endif

@implementation ABI46_0_0RNSScreenNavigationContainerManager

ABI46_0_0RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [[ABI46_0_0RNSScreenNavigationContainerView alloc] init];
}

@end
