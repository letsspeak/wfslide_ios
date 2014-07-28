//
//  SliderImage.h
//  TwitterStreams
//
//  Created by Oomiya Masatsugu on 2014/07/28.
//  Copyright (c) 2014年 Stuart Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSTweet.h"
#import "MikuMikuError.h"

@interface SliderImage : NSObject

@property (nonatomic, readwrite) BOOL downloaded;
@property (nonatomic, retain) TSTweet *tweet;
@property (nonatomic, retain) UIImage *image;

+ (id)imageWithTweet:(TSTweet*)tweet;

- (void)downloadOnSuccess:(void(^)(void))succeededHandler
                   onFail:(void(^)(void))failedHandler;

@end
