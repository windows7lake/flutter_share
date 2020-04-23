//
//  ShareModel.m
//  ShareDemo
//
//  Created by Stanley on 2020/4/20.
//  Copyright © 2020 Stanley. All rights reserved.
//

#import "ShareModel.h"


@implementation ShareModel


- (instancetype)initWithParams:(NSDictionary *)params
{
    self = [super init];
    if (self) {
        [self initParams:params];
    }
    return self;
}

- (void)initParams:(NSDictionary *)params{
    NSLog(@"%@", params);
    
    NSString * image = params[@"image"];
    NSString * text = params[@"text"];
    
    if([text hasPrefix:@"http"]){
        self.url = text;
    } else {
        self.text = text;
    }
    
    if([image hasPrefix:@"http"]){
        self.image = [self downloadImageResouce:image];
    } else {
        self.image = [UIImage imageWithContentsOfFile: image];
    }
}

-(UIImage *)downloadImageResouce:(NSString *)url{
    NSString * loadUrl = url;
    if([loadUrl hasSuffix:@".webp"]){
       loadUrl = [loadUrl stringByReplacingOccurrencesOfString:@".webp" withString:@".png"];
    }
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString: loadUrl]];
    return [UIImage imageWithData:data];
}

@end
