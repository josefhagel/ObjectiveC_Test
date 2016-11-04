//
//  Product.m
//  Test-Project
//
//  Created by Josef Hagel on 11/4/16.
//  Copyright © 2016 Josef Hagel. All rights reserved.
//

#import "Product.h"

@implementation Product


- (int)highestProductOf3:(int*)array_of_ints {
    int count = sizeof(array_of_ints) / sizeof(int);
    if (count < 3) {
        @throw [NSException
                exceptionWithName:@"CountNotEnoughException"
                reason:@"Less than 3 items!"
                userInfo:nil];
    }
    
    // We're going to start at the 3rd item (at index 2)
    // so pre-populate highests and lowests based on the first 2 items.
    // we could also start these as null and check below if they're set
    // but this is arguably cleaner
    int highest = MAX(array_of_ints[0], array_of_ints[1]);
    int lowest  = MIN(array_of_ints[0], array_of_ints[1]);
    
    int highestProductOf2 = array_of_ints[0] * array_of_ints[1];
    int lowestProductOf2  = array_of_ints[0] * array_of_ints[1];
    
    // except this one--we pre-populate it for the first /3/ items.
    // this means in our first pass it'll check against itself, which is fine.
    int highestProductOf3 = array_of_ints[0] * array_of_ints[1] * array_of_ints[2];
    
    // walk through items, starting at index 2
    for (int i = 2; i < count; ++i) {
        int current = array_of_ints[i];
        
        // do we have a new highest product of 3?
        // it's either the current highest,
        // or the current times the highest product of two
        // or the current times the lowest product of two
        highestProductOf3 = MAX(MAX(highestProductOf3, current * highestProductOf2), current * lowestProductOf2);
        
        // do we have a new highest product of two?
        highestProductOf2 = MAX(MAX(highestProductOf2, current * highest), current * lowest);
        
        // do we have a new lowest product of two?
        lowestProductOf2 = MIN(MIN(lowestProductOf2, current * highest), current * lowest);
        
        // do we have a new highest?
        highest = MAX(highest, current);
        
        // do we have a new lowest?
        lowest = MIN(lowest, current);
    }
    
    return highestProductOf3;
}

@end
