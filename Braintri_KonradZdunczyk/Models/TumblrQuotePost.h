//
//  TumblrQuotePost.h
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 26/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "TumblrPost.h"

@interface TumblrQuotePost : TumblrPost <HtmlContent>

@property (nonatomic) NSString* quoteText;
@property (nonatomic) NSString* quoteSource;

@end
