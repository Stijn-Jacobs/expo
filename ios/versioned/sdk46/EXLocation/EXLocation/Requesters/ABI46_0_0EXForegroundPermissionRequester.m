// Copyright 2016-present 650 Industries. All rights reserved.

#import <ABI46_0_0EXLocation/ABI46_0_0EXForegroundPermissionRequester.h>
#import <ABI46_0_0ExpoModulesCore/ABI46_0_0EXUtilities.h>

#import <objc/message.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

static SEL whenInUseAuthorizationSelector;

@implementation ABI46_0_0EXForegroundPermissionRequester

+ (NSString *)permissionType
{
  return @"locationForeground";
}

+ (void)load
{
  whenInUseAuthorizationSelector = NSSelectorFromString([@"request" stringByAppendingString:@"WhenInUseAuthorization"]);
}

- (void)requestLocationPermissions
{
  if ([ABI46_0_0EXBaseLocationRequester isConfiguredForWhenInUseAuthorization] && [self.locationManager  respondsToSelector:whenInUseAuthorizationSelector]) {
    ((void (*)(id, SEL))objc_msgSend)(self.locationManager, whenInUseAuthorizationSelector);
  } else {
    self.reject(@"ERR_LOCATION_INFO_PLIST", @"The `NSLocationWhenInUseUsageDescription` key must be present in Info.plist to be able to use geolocation.", nil);
    
    self.resolve = nil;
    self.reject = nil;
  }
}

- (NSDictionary *)parsePermissions:(CLAuthorizationStatus)systemStatus
{
  ABI46_0_0EXPermissionStatus status;

  switch (systemStatus) {
    case kCLAuthorizationStatusAuthorizedWhenInUse:
    case kCLAuthorizationStatusAuthorizedAlways: {
      status = ABI46_0_0EXPermissionStatusGranted;
      break;
    }
    case kCLAuthorizationStatusDenied:
    case kCLAuthorizationStatusRestricted: {
      status = ABI46_0_0EXPermissionStatusDenied;
      break;
    }
    case kCLAuthorizationStatusNotDetermined:
    default: {
      status = ABI46_0_0EXPermissionStatusUndetermined;
      break;
    }
  }
  
  return @{ @"status": @(status) };
}

@end
