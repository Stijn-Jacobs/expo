#pragma once

#include <memory>
#include <utility>

#include <ABI46_0_0jsi/ABI46_0_0jsi.h>

#include "JsiSkHostObjects.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"

#include <SkImageInfo.h>

#pragma clang diagnostic pop

namespace ABI46_0_0RNSkia {

    using namespace ABI46_0_0facebook;

    class JsiSkImageInfo : public JsiSkWrappingSharedPtrHostObject<SkImageInfo> {
    public:
        JsiSkImageInfo(std::shared_ptr<ABI46_0_0RNSkPlatformContext> context, const SkImageInfo &imageInfo)
                : JsiSkWrappingSharedPtrHostObject<SkImageInfo>(
                std::move(context), std::make_shared<SkImageInfo>(imageInfo)){}

        /**
        Returns the underlying object from a host object of this type
       */
        static std::shared_ptr<SkImageInfo> fromValue(jsi::Runtime &runtime,
                                                  const jsi::Value &obj) {
            const auto& object = obj.asObject(runtime);
            if (object.isHostObject(runtime)) {
                return object
                        .asHostObject<JsiSkImageInfo>(runtime)
                        ->getObject();
            } else {
                auto width = object.getProperty(runtime, "width").asNumber();
                auto height = object.getProperty(runtime, "height").asNumber();
                auto colorType = static_cast<SkColorType>(object.getProperty(runtime, "colorType").asNumber());
                auto alphaType = static_cast<SkAlphaType>(object.getProperty(runtime, "alphaType").asNumber());
                // TODO: color space not supported yet
                return std::make_shared<SkImageInfo>(SkImageInfo::Make(width, height, colorType, alphaType));
            }
        }

        /**
        Returns the jsi object from a host object of this type
       */
        static jsi::Value toValue(jsi::Runtime &runtime,
                                  std::shared_ptr<ABI46_0_0RNSkPlatformContext> context,
                                  const SkImageInfo &imageInfo) {
            return jsi::Object::createFromHostObject(
                    runtime, std::make_shared<JsiSkImageInfo>(std::move(context), imageInfo));
        }
    };
} // namespace ABI46_0_0RNSkia
