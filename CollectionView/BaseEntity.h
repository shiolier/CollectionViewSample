//
//  BaseEntity.h
//  Info
//
//  Created by Eisuke Sato on 2014/05/09.
//  Copyright (c) 2014年 Eisuke Sato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseEntity : NSObject

- (id)initWithAttributes:(NSDictionary *)attributes;
- (void)attributes4Object:(NSDictionary *)attributes;
- (id)null2nil:(id)attribute;

@end
