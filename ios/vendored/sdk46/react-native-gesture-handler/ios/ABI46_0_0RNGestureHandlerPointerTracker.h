#import <Foundation/Foundation.h>

#import "ABI46_0_0RNGHTouchEventType.h"

#define MAX_POINTERS_COUNT 12

@class ABI46_0_0RNGestureHandler;

@interface ABI46_0_0RNGestureHandlerPointerTracker : NSObject

@property (nonatomic) ABI46_0_0RNGHTouchEventType eventType;
@property (nonatomic) NSArray<NSDictionary *> *changedPointersData;
@property (nonatomic) NSArray<NSDictionary *> *allPointersData;
@property (nonatomic) int trackedPointersCount;

- (id)initWithGestureHandler:(ABI46_0_0RNGestureHandler*)gestureHandler;

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)reset;
- (void)cancelPointers;

@end
