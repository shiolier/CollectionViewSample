//
//  BaseModel.m
//  TerraceHouse
//
//  Created by Takaaki Kakinuma on 2013/05/14.
//  Copyright (c) 2013年 Takaaki Kakinuma. All rights reserved.
//

#import "BaseEntity.h"

#import "objc/runtime.h"

@implementation BaseEntity

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        [self attributes4Object:attributes];
    }
    return  self;
}

- (void)attributes4Object:(NSDictionary *)attributes {
    
}

- (id)null2nil:(NSObject *)attribute {
    if (attribute.class == [NSNull class])
        attribute = nil;
    return attribute;
}

@end

