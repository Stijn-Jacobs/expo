#pragma once

#include <ABI46_0_0jsi/ABI46_0_0jsi.h>
#include <string>
#include <utility>

using namespace ABI46_0_0facebook;

namespace ABI46_0_0reanimated {

class EventHandlerRegistry;

class WorkletEventHandler {
  friend EventHandlerRegistry;

 private:
  unsigned long id;
  std::string eventName;
  jsi::Function handler;

 public:
  WorkletEventHandler(
      unsigned long id,
      std::string eventName,
      jsi::Function &&handler)
      : id(id), eventName(eventName), handler(std::move(handler)) {}
  void process(jsi::Runtime &rt, const jsi::Value &eventValue);
};

} // namespace reanimated
