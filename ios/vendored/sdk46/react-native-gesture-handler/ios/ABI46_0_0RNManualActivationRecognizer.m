#import "ABI46_0_0RNManualActivationRecognizer.h"
#import "ABI46_0_0RNGestureHandler.h"

@implementation ABI46_0_0RNManualActivationRecognizer {
  ABI46_0_0RNGestureHandler *_handler;
  int _activePointers;
}

- (id)initWithGestureHandler:(ABI46_0_0RNGestureHandler *)gestureHandler
{
  if ((self = [super initWithTarget:self action:@selector(handleGesture:)])) {
    _handler = gestureHandler;
    self.delegate = self;
    _activePointers = 0;
  }
  return self;
}

- (void)handleGesture:(UIGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.state = UIGestureRecognizerStateEnded;
        [self reset];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [super touchesBegan:touches withEvent:event];

  _activePointers += touches.count;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [super touchesEnded:touches withEvent:event];
  
  _activePointers -= touches.count;
  
  if (_activePointers == 0) {
    self.state = UIGestureRecognizerStateBegan;
  }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [super touchesCancelled:touches withEvent:event];
  
  _activePointers = 0;
  [self reset];
}

- (void)reset
{
  self.enabled = YES;
  [super reset];
}

- (void)fail
{
  self.enabled = NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
  return YES;
}

- (BOOL)shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
  ABI46_0_0RNGestureHandler *handler = [ABI46_0_0RNGestureHandler findGestureHandlerByRecognizer:otherGestureRecognizer];
  if (handler != nil) {
    if (handler.tag == _handler.tag) {
      return YES;
    }
  }
  
  return NO;
}

@end
