#import "ABI46_0_0RNGestureHandlerModule.h"

#import <ABI46_0_0React/ABI46_0_0RCTLog.h>
#import <ABI46_0_0React/ABI46_0_0RCTViewManager.h>
#import <ABI46_0_0React/ABI46_0_0RCTComponent.h>
#import <ABI46_0_0React/ABI46_0_0RCTUIManager.h>
#import <ABI46_0_0React/ABI46_0_0RCTUIManagerUtils.h>
#import <ABI46_0_0React/ABI46_0_0RCTUIManagerObserverCoordinator.h>

#ifdef ABI46_0_0RN_FABRIC_ENABLED
#import <ABI46_0_0React/ABI46_0_0RCTBridge.h>
#import <ABI46_0_0ReactCommon/ABI46_0_0RCTTurboModule.h>
#import <ABI46_0_0React/ABI46_0_0RCTBridge+Private.h>
#import <ABI46_0_0ReactCommon/CallInvoker.h>
#import <ABI46_0_0React/ABI46_0_0RCTUtils.h>
#import <ABI46_0_0React/ABI46_0_0RCTSurfacePresenter.h>

#import <react/renderer/uimanager/primitives.h>
#endif // ABI46_0_0RN_FABRIC_ENABLED

#import "ABI46_0_0RNGestureHandlerState.h"
#import "ABI46_0_0RNGestureHandlerDirection.h"
#import "ABI46_0_0RNGestureHandler.h"
#import "ABI46_0_0RNGestureHandlerManager.h"

#import "ABI46_0_0RNGestureHandlerButton.h"
#import "ABI46_0_0RNGestureHandlerStateManager.h"

#ifdef ABI46_0_0RN_FABRIC_ENABLED
using namespace ABI46_0_0facebook;
using namespace ABI46_0_0React;
#endif // ABI46_0_0RN_FABRIC_ENABLED

#ifdef ABI46_0_0RN_FABRIC_ENABLED
@interface ABI46_0_0RNGestureHandlerModule () <ABI46_0_0RCTSurfacePresenterObserver, ABI46_0_0RNGestureHandlerStateManager>

@end
#else
@interface ABI46_0_0RNGestureHandlerModule () <ABI46_0_0RCTUIManagerObserver, ABI46_0_0RNGestureHandlerStateManager>

@end
#endif // ABI46_0_0RN_FABRIC_ENABLED

typedef void (^GestureHandlerOperation)(ABI46_0_0RNGestureHandlerManager *manager);

@implementation ABI46_0_0RNGestureHandlerModule
{
    ABI46_0_0RNGestureHandlerManager *_manager;

    // Oparations called after views have been updated.
    NSMutableArray<GestureHandlerOperation> *_operations;
}

ABI46_0_0RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

- (void)invalidate
{
    ABI46_0_0RNGestureHandlerManager *handlerManager = _manager;
    dispatch_async(dispatch_get_main_queue(), ^{
        [handlerManager dropAllGestureHandlers];
    });
    
    _manager = nil;
    
#ifdef ABI46_0_0RN_FABRIC_ENABLED
    [self.bridge.surfacePresenter removeObserver:self];
#else
    [self.bridge.uiManager.observerCoordinator removeObserver:self];
#endif // ABI46_0_0RN_FABRIC_ENABLED
}

- (dispatch_queue_t)methodQueue
{
    // This module needs to be on the same queue as the UIManager to avoid
    // having to lock `_operations` and `_preOperations` since `uiManagerWillFlushUIBlocks`
    // will be called from that queue.

    // This is required as this module rely on having all the view nodes created before
    // gesture handlers can be associated with them
    return ABI46_0_0RCTGetUIManagerQueue();
}

#ifdef ABI46_0_0RN_FABRIC_ENABLED
void decorateRuntime(jsi::Runtime &runtime)
{
  auto isFormsStackingContext = jsi::Function::createFromHostFunction(
      runtime,
      jsi::PropNameID::forAscii(runtime, "isFormsStackingContext"),
      1,
      [](jsi::Runtime &runtime,
         const jsi::Value &thisValue,
         const jsi::Value *arguments,
         size_t count) -> jsi::Value
      {
        if (!arguments[0].isObject())
        {
          return jsi::Value::null();
        }

        auto shadowNode = arguments[0].asObject(runtime).getHostObject<ShadowNodeWrapper>(runtime)->shadowNode;
        bool isFormsStackingContext = shadowNode->getTraits().check(ShadowNodeTraits::FormsStackingContext);

        return jsi::Value(isFormsStackingContext);
      });
  runtime.global().setProperty(runtime, "isFormsStackingContext", std::move(isFormsStackingContext));
}
#endif // ABI46_0_0RN_FABRIC_ENABLED

- (void)setBridge:(ABI46_0_0RCTBridge *)bridge
{
    [super setBridge:bridge];

    _manager = [[ABI46_0_0RNGestureHandlerManager alloc]
                initWithUIManager:bridge.uiManager
                eventDispatcher:bridge.eventDispatcher];
    _operations = [NSMutableArray new];

#ifdef ABI46_0_0RN_FABRIC_ENABLED
    [bridge.surfacePresenter addObserver:self];
#else
    [bridge.uiManager.observerCoordinator addObserver:self];
#endif // ABI46_0_0RN_FABRIC_ENABLED
}

#ifdef ABI46_0_0RN_FABRIC_ENABLED
ABI46_0_0RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(install) {
    ABI46_0_0RCTCxxBridge *cxxBridge = (ABI46_0_0RCTCxxBridge *)self.bridge;
    auto runtime = (jsi::Runtime *)cxxBridge.runtime;
    decorateRuntime(*runtime);
    return @true;
}
#endif // ABI46_0_0RN_FABRIC_ENABLED

ABI46_0_0RCT_EXPORT_METHOD(createGestureHandler:(nonnull NSString *)handlerName tag:(nonnull NSNumber *)handlerTag config:(NSDictionary *)config)
{
    [self addOperationBlock:^(ABI46_0_0RNGestureHandlerManager *manager) {
        [manager createGestureHandler:handlerName tag:handlerTag config:config];
    }];
}

ABI46_0_0RCT_EXPORT_METHOD(attachGestureHandler:(nonnull NSNumber *)handlerTag toViewWithTag:(nonnull NSNumber *)viewTag actionType:(nonnull NSNumber *)actionType)
{
    [self addOperationBlock:^(ABI46_0_0RNGestureHandlerManager *manager) {
        [manager attachGestureHandler:handlerTag toViewWithTag:viewTag withActionType:(ABI46_0_0RNGestureHandlerActionType)[actionType integerValue]];
    }];
}

ABI46_0_0RCT_EXPORT_METHOD(updateGestureHandler:(nonnull NSNumber *)handlerTag config:(NSDictionary *)config)
{
    [self addOperationBlock:^(ABI46_0_0RNGestureHandlerManager *manager) {
        [manager updateGestureHandler:handlerTag config:config];
    }];
}

ABI46_0_0RCT_EXPORT_METHOD(dropGestureHandler:(nonnull NSNumber *)handlerTag)
{
    [self addOperationBlock:^(ABI46_0_0RNGestureHandlerManager *manager) {
        [manager dropGestureHandler:handlerTag];
    }];
}

ABI46_0_0RCT_EXPORT_METHOD(handleSetJSResponder:(nonnull NSNumber *)viewTag blockNativeResponder:(nonnull NSNumber *)blockNativeResponder)
{
    [self addOperationBlock:^(ABI46_0_0RNGestureHandlerManager *manager) {
        [manager handleSetJSResponder:viewTag blockNativeResponder:blockNativeResponder];
    }];
}

ABI46_0_0RCT_EXPORT_METHOD(handleClearJSResponder)
{
    [self addOperationBlock:^(ABI46_0_0RNGestureHandlerManager *manager) {
        [manager handleClearJSResponder];
    }];
}

ABI46_0_0RCT_EXPORT_METHOD(flushOperations)
{
    if (_operations.count == 0) {
        return;
    }

    NSArray<GestureHandlerOperation> *operations = _operations;
    _operations = [NSMutableArray new];

    [self.bridge.uiManager addUIBlock:^(__unused ABI46_0_0RCTUIManager *manager, __unused NSDictionary<NSNumber *, UIView *> *viewRegistry) {
        for (GestureHandlerOperation operation in operations) {
            operation(self->_manager);
        }
    }];
}

- (void)setGestureState:(int)state forHandler:(int)handlerTag
{
  ABI46_0_0RNGestureHandler *handler = [_manager handlerWithTag:@(handlerTag)];

  if (handler != nil) {
    if (state == 1) { // FAILED
      handler.recognizer.state = UIGestureRecognizerStateFailed;
    } else if (state == 2) { // BEGAN
      handler.recognizer.state = UIGestureRecognizerStatePossible;
    } else if (state == 3) { // CANCELLED
      handler.recognizer.state = UIGestureRecognizerStateCancelled;
    } else if (state == 4) { // ACTIVE
      [handler stopActivationBlocker];
      handler.recognizer.state = UIGestureRecognizerStateBegan;
    } else if (state == 5) { // ENDED
      handler.recognizer.state = UIGestureRecognizerStateEnded;
    }
  }
  
  // if the gesture was set to finish, cancel all pointers it was tracking
  if (state == 1 || state == 3 || state == 5) {
    [handler.pointerTracker cancelPointers];
  }
  
  // do not send state change event when activating because it bypasses
  // shouldRequireFailureOfGestureRecognizer
  if (state != 4) {
    [handler handleGesture:handler.recognizer];
  }
}

#pragma mark -- Batch handling

- (void)addOperationBlock:(GestureHandlerOperation)operation
{
    [_operations addObject:operation];
}

#pragma mark - ABI46_0_0RCTSurfacePresenterObserver

#ifdef ABI46_0_0RN_FABRIC_ENABLED

- (void)didMountComponentsWithRootTag:(NSInteger)rootTag
{
    ABI46_0_0RCTAssertMainQueue();
    
    if (_operations.count == 0) {
        return;
    }

    NSArray<GestureHandlerOperation> *operations = _operations;
    _operations = [NSMutableArray new];

    for (GestureHandlerOperation operation in operations) {
        operation(self->_manager);
    }
}

#else

#pragma mark - ABI46_0_0RCTUIManagerObserver

- (void)uiManagerWillFlushUIBlocks:(ABI46_0_0RCTUIManager *)uiManager
{
  [self uiManagerWillPerformMounting:uiManager];
}

- (void)uiManagerWillPerformMounting:(ABI46_0_0RCTUIManager *)uiManager
{
    if (_operations.count == 0) {
        return;
    }

    NSArray<GestureHandlerOperation> *operations = _operations;
    _operations = [NSMutableArray new];

    [uiManager addUIBlock:^(__unused ABI46_0_0RCTUIManager *manager, __unused NSDictionary<NSNumber *, UIView *> *viewRegistry) {
        for (GestureHandlerOperation operation in operations) {
            operation(self->_manager);
        }
    }];
}

#endif // ABI46_0_0RN_FABRIC_ENABLED

#pragma mark Events

- (NSArray<NSString *> *)supportedEvents
{
    return @[@"onGestureHandlerEvent", @"onGestureHandlerStateChange"];
}

#pragma mark Module Constants

- (NSDictionary *)constantsToExport
{
    return @{ @"State": @{
                      @"UNDETERMINED": @(ABI46_0_0RNGestureHandlerStateUndetermined),
                      @"BEGAN": @(ABI46_0_0RNGestureHandlerStateBegan),
                      @"ACTIVE": @(ABI46_0_0RNGestureHandlerStateActive),
                      @"CANCELLED": @(ABI46_0_0RNGestureHandlerStateCancelled),
                      @"FAILED": @(ABI46_0_0RNGestureHandlerStateFailed),
                      @"END": @(ABI46_0_0RNGestureHandlerStateEnd)
                      },
              @"Direction": @{
                      @"RIGHT": @(ABI46_0_0RNGestureHandlerDirectionRight),
                      @"LEFT": @(ABI46_0_0RNGestureHandlerDirectionLeft),
                      @"UP": @(ABI46_0_0RNGestureHandlerDirectionUp),
                      @"DOWN": @(ABI46_0_0RNGestureHandlerDirectionDown)
                      }
              };
}



@end
