/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#include "ABI46_0_0DebugStringConvertibleItem.h"

#include <utility>

namespace ABI46_0_0facebook {
namespace ABI46_0_0React {

#if ABI46_0_0RN_DEBUG_STRING_CONVERTIBLE

DebugStringConvertibleItem::DebugStringConvertibleItem(
    std::string name,
    std::string value,
    SharedDebugStringConvertibleList props,
    SharedDebugStringConvertibleList children)
    : name_(std::move(name)),
      value_(std::move(value)),
      debugProps_(std::move(props)),
      children_(std::move(children)) {}

std::string DebugStringConvertibleItem::getDebugName() const {
  return name_;
}

std::string DebugStringConvertibleItem::getDebugValue() const {
  return value_;
}

SharedDebugStringConvertibleList DebugStringConvertibleItem::getDebugProps()
    const {
  return debugProps_;
}

SharedDebugStringConvertibleList DebugStringConvertibleItem::getDebugChildren()
    const {
  return children_;
}

#endif

} // namespace ABI46_0_0React
} // namespace ABI46_0_0facebook
