//
//  SliderImage.m
//  TwitterStreams
//
//  Created by Oomiya Masatsugu on 2014/07/28.
//  Copyright (c) 2014年 Stuart Hall. All rights reserved.
//

#import "SliderImage.h"
#import "MikuMikuDownloader.h"

@implementation SliderImage

- (id)initWithTweet:(TSTweet*)tweet
{
    if (!tweet) return nil;
    self = [super init];
    if (self) {
        self.tweet = tweet;
        self.downloaded = NO;
    }
    return self;
}

- (void)dealloc
{
    self.tweet = nil;
    self.image = nil;
    [super dealloc];
}

- (void)downloadOnSuccess:(void(^)(void))succeededHandler
                   onFail:(void(^)(void))failedHandler
{
    __block __weak SliderImage *self_ = self;
    NSString *url = self.tweet.mediaUrl;
    [MikuMikuDownloader temporaryDownloadWithUrl:url
                                succeededHandler:^(NSString *temporaryPath) {
                                    self_.image = [UIImage imageWithContentsOfFile:temporaryPath];
                                    self_.downloaded = YES;
                                } failedHandler:^(MikuMikuError *error) {
                                    self_.image = nil;
                                    self_.downloaded = YES;
                                }];
    
}



+ (id)imageWithTweet:(TSTweet*)tweet
{
    return [[[self alloc] initWithTweet:tweet] autorelease];
}

@end
