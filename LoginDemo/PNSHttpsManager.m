//
//  PNSHttpsManager.m
//  AliyunLoginDemo
//
//  Created by 王俊钢 on 2021/10/22.
//

#import "PNSHttpsManager.h"

#define PNSATAUTHSDKINFOKEY @"ATAuthSDKInfoKey"
#define PNSATAUTHSDKINFO  @"MUhmLW8br7EW5KHFkCB2mDZfBXIIt6rNriFxQjR3rMuoD5PUMmPVOeqq0hOgrcIRT8ch8bCFf4iHih29gh6KQYM5OqZ9QOlWB/n7Nb4BpdkOAWCWY2m3FBsZ4YpVVsG69Kb5IDpjM4qJSPBn5O4phWpEc4DFqZomrh1If5VbPt8x5dVA+yS37zCRkDC9CFcE+OIa2+qokc0FSSxyjPU4osveWRkaiQAbG2BKklNDJ6JyjsJRbyWchEmEpbXgPlQbhtTtak7UkagOgvCV10PBUA=="

@implementation PNSHttpsManager
+ (void)requestATAuthSDKInfo:(void (^)(BOOL, NSString * _Nonnull))block {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(1.0 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        
        if (block) {
            block(YES, PNSATAUTHSDKINFO);
        }
    });
}

@end

