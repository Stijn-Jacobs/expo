/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#pragma once

#include <functional>

#include <ABI46_0_0React/ABI46_0_0renderer/core/StateData.h>

namespace ABI46_0_0facebook {
namespace ABI46_0_0React {

class ShadowNodeFamily;
using SharedShadowNodeFamily = std::shared_ptr<ShadowNodeFamily const>;

class StateUpdate {
 public:
  using Callback =
      std::function<StateData::Shared(StateData::Shared const &data)>;
  using FailureCallback = std::function<void()>;

  SharedShadowNodeFamily family;
  Callback callback;
};

} // namespace ABI46_0_0React
} // namespace ABI46_0_0facebook
