//
//  ShareHelper.h
//  ShareDemo
//
//  Created by Stanley on 2020/4/20.
//  Copyright © 2020 Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "ShareModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShareHelper : NSObject

- (void)shareToPlatformType:(NSString *)platformType withContent:(ShareModel *)model result:(FlutterResult)result;

@end

NS_ASSUME_NONNULL_END
