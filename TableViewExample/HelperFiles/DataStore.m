//
//  DataStore.m
//  TableViewExample
//
//  Created by Claire Davis on 12/22/15.
//  Copyright © 2015 Davis. All rights reserved.
//

#import "DataStore.h"
#import "ParseAPIClient.h"
#import "ImageObject.h"
#import "Location.h"
#import "AWSDownloadManager.h"

@implementation DataStore

//create shared data store to store images downloaded
+ (instancetype)sharedDataStore
{
  static DataStore *_sharedDataStore = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedDataStore = [[DataStore alloc] init];
  });
  
  return _sharedDataStore;
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    _downloadedPictures = [[NSMutableArray alloc]init];
    _images = [[NSMutableDictionary alloc]init];
  }
  
  return self;
}

// method to download image information from Parse and to
// format into image and location objects for accessibility
- (void)downloadPicturesToDisplay:(NSUInteger)imagesToDownloadFromParseQuery
                  withCompletion:(void(^)(BOOL complete, BOOL allImagesFinished))completionBlock
{
  NSUInteger page = ceil(self.downloadedPictures.count / (imagesToDownloadFromParseQuery * 1.00f));
  
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"likes >= %@ AND report < %@ OR report = %@", @(0), @5, nil];
  [ParseAPIClient fetchImagesWithPredicate:predicate numberOfImages:imagesToDownloadFromParseQuery page:page completion:^(NSArray *data) {
    
    __block NSUInteger remainingImageCount = data.count;
    
    if(remainingImageCount == 0) {
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        completionBlock(YES, YES);
      }];
    }
    
    for (PFObject *parseImageObject in data) {
      PFObject *parseLocation = parseImageObject[@"location"];
      Location *locationObject = [[Location alloc] initWithCity:parseLocation[@"city"] country:parseLocation[@"country"] geoPoint:parseLocation[@"geoPoint"] dateTaken:parseLocation[@"dateTaken"]];
      ImageObject *parseImage = [[ImageObject alloc] initWithOwner:parseImageObject[@"owner"] title:parseImageObject[@"title"] imageID:parseImageObject[@"imageID"] likes:parseImageObject[@"likes"] mood:parseImageObject[@"mood"] location:locationObject comments:[data mutableCopy]
                                                          objectID:parseImageObject.objectId];
      [self.downloadedPictures addObject:parseImage];
      remainingImageCount--;
      completionBlock(YES, remainingImageCount == 0);
    }
  } failure:^(NSError *error) {
    NSLog(@"Download images error: %@ code: %ld", error.localizedDescription, (long)error.code);
  }];
}

// download individual PNG files from AWS
- (void)downloadPictureFromAWS:(NSString*)imageID withCompletion:(void(^)(BOOL complete))completionBlock
{
  [AWSDownloadManager downloadImageWithImageID:imageID completion:^(UIImage *image) {
    self.images[imageID] = image;
    completionBlock(YES);
    
  } failure:^(NSError *error) {
    NSLog(@"download AWS error: %@",error);
  }];
}

@end
