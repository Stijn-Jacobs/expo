/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#include "ABI46_0_0YGConfig.h"

ABI46_0_0YGConfig::ABI46_0_0YGConfig(ABI46_0_0YGLogger logger) : cloneNodeCallback_{nullptr} {
  logger_.noContext = logger;
  loggerUsesContext_ = false;
}

void ABI46_0_0YGConfig::log(
    ABI46_0_0YGConfig* config,
    ABI46_0_0YGNode* node,
    ABI46_0_0YGLogLevel logLevel,
    void* logContext,
    const char* format,
    va_list args) {
  if (loggerUsesContext_) {
    logger_.withContext(config, node, logLevel, logContext, format, args);
  } else {
    logger_.noContext(config, node, logLevel, format, args);
  }
}

ABI46_0_0YGNodeRef ABI46_0_0YGConfig::cloneNode(
    ABI46_0_0YGNodeRef node,
    ABI46_0_0YGNodeRef owner,
    int childIndex,
    void* cloneContext) {
  ABI46_0_0YGNodeRef clone = nullptr;
  if (cloneNodeCallback_.noContext != nullptr) {
    clone = cloneNodeUsesContext_
        ? cloneNodeCallback_.withContext(node, owner, childIndex, cloneContext)
        : cloneNodeCallback_.noContext(node, owner, childIndex);
  }
  if (clone == nullptr) {
    clone = ABI46_0_0YGNodeClone(node);
  }
  return clone;
}
