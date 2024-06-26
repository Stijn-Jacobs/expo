/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "ABI46_0_0RCTMountingTransactionObserverCoordinator.h"

#import "ABI46_0_0RCTMountingTransactionObserving.h"

using namespace ABI46_0_0facebook::ABI46_0_0React;

void ABI46_0_0RCTMountingTransactionObserverCoordinator::registerViewComponentDescriptor(
    ABI46_0_0RCTComponentViewDescriptor const &componentViewDescriptor,
    SurfaceId surfaceId)
{
  if (!componentViewDescriptor.observesMountingTransactionWillMount &&
      !componentViewDescriptor.observesMountingTransactionDidMount) {
    return;
  }

  auto &surfaceRegistry = registry_[surfaceId];
  assert(surfaceRegistry.count(componentViewDescriptor) == 0);
  surfaceRegistry.insert(componentViewDescriptor);
}

void ABI46_0_0RCTMountingTransactionObserverCoordinator::unregisterViewComponentDescriptor(
    ABI46_0_0RCTComponentViewDescriptor const &componentViewDescriptor,
    SurfaceId surfaceId)
{
  if (!componentViewDescriptor.observesMountingTransactionWillMount &&
      !componentViewDescriptor.observesMountingTransactionDidMount) {
    return;
  }

  auto &surfaceRegistry = registry_[surfaceId];
  assert(surfaceRegistry.count(componentViewDescriptor) == 1);
  surfaceRegistry.erase(componentViewDescriptor);
}

void ABI46_0_0RCTMountingTransactionObserverCoordinator::notifyObserversMountingTransactionWillMount(
    MountingTransaction const &transaction,
    SurfaceTelemetry const &surfaceTelemetry) const
{
  auto surfaceId = transaction.getSurfaceId();
  auto surfaceRegistryIterator = registry_.find(surfaceId);
  if (surfaceRegistryIterator == registry_.end()) {
    return;
  }
  auto &surfaceRegistry = surfaceRegistryIterator->second;
  for (auto const &componentViewDescriptor : surfaceRegistry) {
    if (componentViewDescriptor.observesMountingTransactionWillMount) {
      [(id<ABI46_0_0RCTMountingTransactionObserving>)componentViewDescriptor.view mountingTransactionWillMount:transaction
                                                                                 withSurfaceTelemetry:surfaceTelemetry];
    }
  }
}

void ABI46_0_0RCTMountingTransactionObserverCoordinator::notifyObserversMountingTransactionDidMount(
    MountingTransaction const &transaction,
    SurfaceTelemetry const &surfaceTelemetry) const
{
  auto surfaceId = transaction.getSurfaceId();
  auto surfaceRegistryIterator = registry_.find(surfaceId);
  if (surfaceRegistryIterator == registry_.end()) {
    return;
  }
  auto &surfaceRegistry = surfaceRegistryIterator->second;
  for (auto const &componentViewDescriptor : surfaceRegistry) {
    if (componentViewDescriptor.observesMountingTransactionDidMount) {
      [(id<ABI46_0_0RCTMountingTransactionObserving>)componentViewDescriptor.view mountingTransactionDidMount:transaction
                                                                                withSurfaceTelemetry:surfaceTelemetry];
    }
  }
}
