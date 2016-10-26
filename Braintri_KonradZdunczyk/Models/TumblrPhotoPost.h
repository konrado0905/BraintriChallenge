//
//  TumblrPhotoPost.h
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 26/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "TumblrPost.h"
#import "Photo.h"

@interface TumblrPhotoPost : TumblrPost

@property (nonatomic) NSString* photoCaption;
@property (nonatomic) int width;
@property (nonatomic) int height;
@property (nonatomic) NSURL* photoUrl_1280;
@property (nonatomic) NSURL* photoUrl_500;
@property (nonatomic) NSURL* photoUrl_400;
@property (nonatomic) NSURL* photoUrl_250;
@property (nonatomic) NSURL* photoUrl_100;
@property (nonatomic) NSURL* photoUrl_75;
@property (nonatomic) NSArray<Photo*>* photos;

@end
