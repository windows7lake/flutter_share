//
//  ShareModel.h
//  ShareDemo
//
//  Created by Stanley on 2020/4/20.
//  Copyright © 2020 Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareModel : NSObject

@property (strong, nonatomic) NSString * text;
@property (strong, nonatomic) NSString * url;
@property (strong, nonatomic) UIImage * image;
- (instancetype)initWithParams:(NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END
