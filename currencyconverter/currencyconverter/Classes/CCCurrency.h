//
//  CCCurrency.h
//  currencyconverter
//
//  Created by Alex Liu on 12/11/13.
//  Copyright (c) 2013 Andrew Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCCurrency : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *value;

// publicly accessible constructor
- (id) initWithName: (NSString *) name value: (NSNumber *) value;

@end
