//
//  TumblrRegularPost.h
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 26/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "TumblrPost.h"

@interface TumblrRegularPost : TumblrPost <HtmlContent>

@property (nonatomic) NSString* regularTitle;
@property (nonatomic) NSString* regularBody;

@end
