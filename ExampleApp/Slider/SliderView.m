//
//  SliderView.m
//  TwitterStreams
//
//  Created by Oomiya Masatsugu on 2014/07/28.
//  Copyright (c) 2014年 Stuart Hall. All rights reserved.
//

#import "SliderView.h"

@interface SliderView ()
@property (nonatomic, assign) NSTimer *timer;

@end

@implementation SliderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.interval = 10.0f;
        self.ticked = NO;
        self.pos = 0;
        self.queue = [NSMutableArray array];
       
        self.imageView = [self createImageView];
        NSTimer *timer = [NSTimer
                          scheduledTimerWithTimeInterval:self.interval
                          target:self
                          selector:@selector(update)
                          userInfo:nil
                          repeats:YES];
        self.timer = timer;
    }
    return self;
}

- (void)dealloc
{
    self.queue = nil;
    [self.timer invalidate];
    [super dealloc];
}

- (void)addQueue:(SliderImage*)image
{
    NSLog(@"addQueue: %@", image.tweet.mediaUrl);
    [image downloadOnSuccess:^{
        if (self.ticked) [self update];
    } onFail:^{}];
    [self.queue addObject:image];
}

- (void)update
{
    self.ticked = YES;
    NSLog(@"update: queue_count:%d pos:%d", (int)self.queue.count, (int)self.pos);
    if (self.queue.count > self.pos) {
        SliderImage *nextImage = self.queue[self.pos];
        if (nextImage.downloaded) {
            if (!nextImage.image) {
                self.pos++;
                [self update];
                return;
            }
            
            [UIView transitionWithView:self.imageView
                              duration:1.0f
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                self.imageView.image = nextImage.image;
                            } completion:^(BOOL finished) {
                                self.pos++;
                                self.ticked = NO;
                            }];
        }
    }
}

- (UIImageView*)createImageView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth
    |UIViewAutoresizingFlexibleRightMargin
    |UIViewAutoresizingFlexibleTopMargin
    |UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:imageView];
    return imageView;
}

@end
