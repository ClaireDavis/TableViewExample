//
//  ParseAPIClient.m
//  TableViewExample
//
//  Created by Claire Davis on 12/22/15.
//  Copyright © 2015 Davis. All rights reserved.
//

#import "ParseAPIClient.h"

@implementation ParseAPIClient

/**
 *  Fetch images info from Parse
 *
 *  @param predicate       Filter input
 *  @param numberOfImages  Number of images wanted to return
 *  @param completionBlock Call back to pass the returned array of image information
 *  @param failure         Call back with error incase of failure
 */
+ (void)fetchImagesWithPredicate:(NSPredicate *)predicate
                 numberOfImages:(NSUInteger)numberOfImages
                           page:(NSUInteger)page
                     completion:(void (^)(NSArray *))completionBlock
                        failure:(void (^)(NSError *))failure
{
  // Quering the Photo object from Parse with filter parameters.
  PFQuery *query = [PFQuery queryWithClassName:@"Image" predicate:predicate];
  
  // [query includeKey:@"comments"];
  [query includeKey:@"owner"];
  [query includeKey:@"location"];
  [query orderByDescending:@"createdAt"];
  
  // Setting the maximum numbers of return objects.
  query.limit = numberOfImages;
  query.skip = page * numberOfImages;
  [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
    if (!error) {
      completionBlock(objects);
    } else{
      failure(error);
    }
  }];
}

@end
