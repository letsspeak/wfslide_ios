//
//  TSTweet.m
//  TwitterStreams
//
//  Created by Stuart Hall on 6/03/12.
//  Copyright (c) 2012 Stuart Hall. All rights reserved.
//

#import "TSTweet.h"
#import "NSArray+Enumerable.h"

@interface TSTweet()
@property (nonatomic, retain) TSUser* cachedUser;
@property (nonatomic, retain) NSArray* cachedUserMentions;
@property (nonatomic, retain) NSArray* cachedUrls;
@property (nonatomic, retain) NSArray* cachedHashtags;
@end

@implementation TSTweet

@synthesize cachedUser=_cachedUser;
@synthesize cachedUserMentions=_cachedUserMentions;
@synthesize cachedUrls=_cachedUrls;
@synthesize cachedHashtags=_cachedHashtags;

- (void)dealloc {
    self.cachedUser = nil;
    self.cachedUserMentions = nil;
    self.cachedUrls = nil;
    self.cachedHashtags = nil;
    
    [super dealloc];
}

- (NSString*)text {
    return [self.dictionary objectForKey:@"text"];
}

- (TSUser*)user {
    if (!self.cachedUser)
        self.cachedUser = [[[TSUser alloc] initWithDictionary:[self.dictionary objectForKey:@"user"]] autorelease];
    
    return self.cachedUser;
}

- (NSArray*)userMentions {
    if (!self.cachedUserMentions) {
        self.cachedUserMentions = [[self.dictionary valueForKeyPath:@"entities.user_mentions"] map:^id(NSDictionary* d) {
            return [[[TSUser alloc] initWithDictionary:d] autorelease];
        }];
    }
    
    return self.cachedUserMentions;
}

- (NSArray*)urls {
    if (!self.cachedUrls) {
        self.cachedUrls = [[self.dictionary valueForKeyPath:@"entities.urls"] map:^id(NSDictionary* d) {
            return [[[TSUrl alloc] initWithDictionary:d] autorelease];
        }];
    }
    
    return self.cachedUrls;
}

- (NSArray*)hashtags {
    if (!self.cachedHashtags) {
        self.cachedHashtags = [[self.dictionary valueForKeyPath:@"entities.hashtags"] map:^id(NSDictionary* d) {
            return [[[TSHashtag alloc] initWithDictionary:d] autorelease];
        }];
    }
    
    return self.cachedHashtags;
}

- (NSArray*)mediaUrls {
    return [[self.dictionary valueForKeyPath:@"entities.media"] map:^id(NSDictionary *d) {
        return d[@"media_url"];
    }];
}

- (NSString*)mediaUrl {
    NSArray *urls = self.mediaUrls;
    if (urls.count == 0) return nil;
    return urls[0];
}

@end
