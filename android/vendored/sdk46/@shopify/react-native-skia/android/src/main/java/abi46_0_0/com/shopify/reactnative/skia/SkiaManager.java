package abi46_0_0.com.shopify.reactnative.skia;

import com.facebook.jni.HybridData;
import com.facebook.proguard.annotations.DoNotStrip;
import abi46_0_0.com.facebook.react.bridge.ReactContext;
import abi46_0_0.com.facebook.react.turbomodule.core.CallInvokerHolderImpl;

@DoNotStrip
public class SkiaManager {

    @DoNotStrip
    private HybridData mHybridData;

    @DoNotStrip
    private ReactContext mContext;

    @DoNotStrip
    private PlatformContext mPlatformContext;

    @DoNotStrip
    SkiaManager(ReactContext context) {
        super();
        mContext = context;

        CallInvokerHolderImpl holder = (CallInvokerHolderImpl) context.getCatalystInstance().getJSCallInvokerHolder();

        mPlatformContext = new PlatformContext(context);

        mHybridData = initHybrid(context.getJavaScriptContextHolder().get(), holder, mPlatformContext);

        initializeRuntime();
    }

    public void destroy() {
        mHybridData.resetNative();
    }

    public float getPixelDensity() {
        return mContext.getResources().getDisplayMetrics().density;
    }

    public PlatformContext getPlatformContext() {
        return mPlatformContext;
    }

    public void register(int nativeId, SkiaDrawView view) {
        registerSkiaView(nativeId, view);
    }

    public void unregister(int nativeId) {
        unregisterSkiaView(nativeId);
    }

    public void onHostResume() { mPlatformContext.onResume(); }

    public void onHostPause() {  mPlatformContext.onPause(); }

    // private C++ functions
    private native HybridData initHybrid(long jsContext, CallInvokerHolderImpl jsCallInvokerHolder,
            PlatformContext platformContext);
    private native void initializeRuntime();
    private native void registerSkiaView(int nativeId, SkiaDrawView view);
    private native void unregisterSkiaView(int nativeId);
    public native void invalidate();

}