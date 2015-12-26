//
//  ParseAPIClient.h
//  TableViewExample
//
//  Created by Claire Davis on 12/22/15.
//  Copyright © 2015 Davis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ParseAPIClient : NSObject


+(void)fetchImagesWithPredicate:(NSPredicate *)predicate
                 numberOfImages:(NSUInteger)numberOfImages
                           page:(NSUInteger)page
                     completion:(void (^)(NSArray *))completionBlock
                        failure:(void (^)(NSError *))failure;
@end
