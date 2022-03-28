#import <React/RCTBridge.h>

@interface RCT_EXTERN_MODULE(MyAppModule, NSObject)

RCT_EXTERN_METHOD(chooseFile: (RCTPromiseResolveBlock)resolve
                rejecter: (RCTPromiseRejectBlock)reject)

@end
