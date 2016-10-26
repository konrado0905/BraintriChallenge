//
//  TumblrVideoPost.h
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 26/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "TumblrPost.h"

@interface TumblrVideoPost : TumblrPost

@property (nonatomic) NSString* videoCaption;
@property (nonatomic) NSString* videoSource;
@property (nonatomic) NSString* videoPlayer;
@property (nonatomic) NSString* videoPlayer_500;
@property (nonatomic) NSString* videoPlayer_250;

@end
