//
//  UIImageView+AsyncDownload.m
//  TwitterStreams
//
//  Created by Oomiya Masatsugu on 2014/07/28.
//  Copyright (c) 2014年 Stuart Hall. All rights reserved.
//

#import "UIImageView+AsyncDownload.h"
#import "MikuMikuDownloader.h"

@implementation UIImageView (AsyncDownload)

-(void)loadImage:(NSString *)url
{
    [MikuMikuDownloader temporaryDownloadWithUrl:url
                                succeededHandler:^(NSString *temporaryPath) {
                                    NSLog(@"download succeeded");
                                    self.image = [UIImage imageWithContentsOfFile:temporaryPath];
                                } failedHandler:^(MikuMikuError *error) {
                                    NSLog(@"download failed");
                                    NSLog(@"%@", error);
                                }];

}

@end
