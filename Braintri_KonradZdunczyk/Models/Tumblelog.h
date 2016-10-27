//
//  Tumblelog.h
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 26/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tumblelog : NSObject

@property (nonatomic) NSString* title;
@property (nonatomic) NSString* info;
@property (nonatomic) NSString* name;

- (instancetype)initWithJSON: (NSDictionary*)json;

@end
