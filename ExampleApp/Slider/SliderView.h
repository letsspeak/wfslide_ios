//
//  SliderView.h
//  TwitterStreams
//
//  Created by Oomiya Masatsugu on 2014/07/28.
//  Copyright (c) 2014年 Stuart Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SliderImage.h"

@interface SliderView : UIView

@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, assign) BOOL ticked;

@property (nonatomic, assign) UIImageView *imageView;
@property (nonatomic, readwrite) NSInteger pos;
@property (nonatomic, retain) NSMutableArray *queue;

- (void)addQueue:(SliderImage*)image;

@end
