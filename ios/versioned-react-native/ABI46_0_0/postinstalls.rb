# @generated by expotools

if pod_name.start_with?('ABI46_0_0React') || pod_name == 'ABI46_0_0ExpoKit'
  target_installation_result.native_target.build_configurations.each do |config|
    config.build_settings['OTHER_CFLAGS'] = %w[
      -DkNeverRequested=ABI46_0_0ReactkNeverRequested
      -DkNeverProgressed=ABI46_0_0ReactkNeverProgressed
      -DkSMCalloutViewRepositionDelayForUIScrollView=ABI46_0_0ReactkSMCalloutViewRepositionDelayForUIScrollView
      -DregionAsJSON=ABI46_0_0ReactregionAsJSON
      -DunionRect=ABI46_0_0ReactunionRect
      -DJSNoBytecodeFileFormatVersion=ABI46_0_0ReactJSNoBytecodeFileFormatVersion
      -DJSSamplingProfilerEnabled=ABI46_0_0ReactJSSamplingProfilerEnabled
      -DRECONNECT_DELAY_MS=ABI46_0_0ReactRECONNECT_DELAY_MS
      -DMAX_DELTA_TIME=ABI46_0_0ReactMAX_DELTA_TIME
      -DgCurrentGenerationCount=ABI46_0_0ReactgCurrentGenerationCount
      -DgPrintSkips=ABI46_0_0ReactgPrintSkips
      -DgPrintChanges=ABI46_0_0ReactgPrintChanges
      -DlayoutNodeInternal=ABI46_0_0ReactlayoutNodeInternal
      -DgDepth=ABI46_0_0ReactgDepth
      -DgPrintTree=ABI46_0_0ReactgPrintTree
      -DisUndefined=ABI46_0_0ReactisUndefined
      -DgNodeInstanceCount=ABI46_0_0ReactgNodeInstanceCount
    ]
    config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)']
    config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] << 'ABI46_0_0RCT_DEV=1'
    config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] << 'ABI46_0_0RCT_ENABLE_INSPECTOR=0'
    config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] << 'ABI46_0_0RCT_DEV_SETTINGS_ENABLE_PACKAGER_CONNECTION=0'
    # Enable Google Maps support
    config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] << 'ABI46_0_0HAVE_GOOGLE_MAPS=1'
    config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] << 'ABI46_0_0HAVE_GOOGLE_MAPS_UTILS=1'
  end
end
