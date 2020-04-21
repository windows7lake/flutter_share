//
//  ShareHelper.m
//  ShareDemo
//
//  Created by Stanley on 2020/4/20.
//  Copyright © 2020 Stanley. All rights reserved.
//

#import "ShareHelper.h"
#import <FBSDKShareKit/FBSDKShareKit.h>

//#import <FBSDKShareKit/FBSDKShareKit/FBSDKShareLinkContent.h>
//#import <FBSDKShareKit/FBSDKShareKit/FBSDKSharePhotoContent.h>
//#import <FBSDKShareKit/FBSDKShareKit/FBSDKShareDialog.h>
//#import <FBSDKShareKit/FBSDKShareKit/FBSDKSharePhoto.h>

@interface ShareHelper ()<FBSDKSharingDelegate>

@property(strong, nonatomic) FlutterResult result;

@end

@implementation ShareHelper

- (void)shareToPlatformType:(NSString *)platformType withContent:(ShareModel *)model  result:(FlutterResult)result
 {
     self.result = result;
     if([@"facebook" isEqualToString:platformType]){
        [self shareToFacebook:model];

    } else {
        [self shareToLine:model];
    }
}

- (void)shareToFacebook:(ShareModel *)model{
    
    UIViewController * root = [[UIApplication sharedApplication] keyWindow].rootViewController;
    
    if(model.url.length > 0){
        FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
        content.contentURL = [NSURL URLWithString: model.url];
        [FBSDKShareDialog showFromViewController: root withContent:content delegate: self];
    } else if(model.image != nil){
        FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
        FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
        photo.image = model.image;
        photo.userGenerated = YES;
        content.photos = @[photo];
        [FBSDKShareDialog showFromViewController: root withContent:content delegate: self];
    }
}

- (void)shareToLine:(ShareModel *)model{
    
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"line://"]]){
        NSString * url = @"line://msg";
        if(model.url.length > 0){
            url = [NSString stringWithFormat:@"%@/text/%@",url,model.url];
        }else {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            [pasteboard setData:UIImageJPEGRepresentation(model.image , 1.0) forPasteboardType:@"public.jpeg"];
            url = [NSString stringWithFormat:@"%@/image/%@",url,pasteboard.name];
            NSLog(@"%@", url);
        }
        NSLog(@"%@",url);
        self.result(@{@"state": @0, @"msg": @""});
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: url]];
    } else {
        NSLog(@"错误");
        self.result(@{@"state": @1, @"msg": @"未安裝"});
    }
}

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary<NSString *, id> *)results{
    NSLog(@"完成");
    self.result(@{@"state": @0, @"msg": @""});
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error {
    self.result(@{@"state": @1, @"msg": @"未安裝"});
    NSLog(@"error");
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer {
    NSLog(@"取消");
    self.result(@{@"state": @2, @"msg": @"用戶取消"});
}


@end
