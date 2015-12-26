//
//  ImageObject.m
//  TableViewExample
//
//  Created by Claire Davis on 12/22/15.
//  Copyright © 2015 Davis. All rights reserved.
//


#import "ImageObject.h"

@implementation ImageObject

// initializes image object from parse information
- (instancetype)init
{
  return [self initWithOwner:[PFUser currentUser]
                       title:@""
                     imageID:@""
                       likes:@0
                        mood:@""
                    location:[Location new]
                    comments:[@[] mutableCopy]
                    objectID:@""];
}

- (instancetype)initWithTitle:(NSString *)title
                      imageID:(NSString *)imageID
                         mood:(NSString *)mood
                     location:(Location *)location
{
  return [self initWithOwner:[PFUser currentUser]
                       title:title
                     imageID:imageID
                       likes:@0
                        mood:mood
                    location:location
                    comments:[@[] mutableCopy]
                    objectID:@""];
}

- (instancetype)initWithOwner:(PFUser *)owner
                        title:(NSString *)title
                      imageID:(NSString *)imageID
                        likes:(NSNumber *)likes
                         mood:(NSString *)mood
                     location:(Location *)location
                     comments:(NSMutableArray *)comments
{
  return [self initWithOwner:[PFUser currentUser]
                       title:title
                     imageID:imageID
                       likes:@0
                        mood:mood
                    location:location
                    comments:[@[] mutableCopy]
                    objectID:@""];
}

- (instancetype)initWithOwner:(PFUser *)owner
                        title:(NSString *)title
                      imageID:(NSString *)imageID
                        likes:(NSNumber *)likes
                         mood:(NSString *)mood
                     location:(Location *)location
                     comments:(NSMutableArray *)comments
                     objectID:(NSString *)objectID
{
  self = [super init];
  if (self) {
    _owner = owner;
    _title = title;
    _imageID = imageID;
    _likes = likes;
    _mood = mood;
    _location = location;
    _comments = comments;
    _objectID = objectID;
  }
  
  return self;
}

@end
