//
//  CCCurrency.m
//  currencyconverter
//
//  Created by Alex Liu on 12/11/13.
//  Copyright (c) 2013 Andrew Liu. All rights reserved.
//

#import "CCCurrency.h"

@implementation CCCurrency

- (id) initWithName: (NSString *) name value: (NSNumber *) value {
    self = [super init];
    
    if (self) {
        self.name = name;
        self.value = value;
    }
    
    return self;
}

@end
