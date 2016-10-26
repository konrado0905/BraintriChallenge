//
//  TumblrVideoPost.m
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 26/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "TumblrVideoPost.h"

@implementation TumblrVideoPost

- (instancetype)initWithJSON: (NSDictionary*)json {
    self = [super initWithJSON:json];

    if (self) {
        self.videoCaption = json[@"video-caption"];
        if (!self.videoCaption) return nil;

        self.videoSource = json[@"video-source"];
        if (!self.videoSource) return nil;

        self.videoPlayer = json[@"video-player"];
        if (!self.videoPlayer) return nil;

        self.videoPlayer_500 = json[@"video-player-500"];
        if (!self.videoPlayer_500) return nil;

        self.videoPlayer_250 = json[@"video-player-250"];
        if (!self.videoPlayer_250) return nil;
    }
    
    return self;
}

@end
