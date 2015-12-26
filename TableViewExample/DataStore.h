//
//  DataStore.h
//  TableViewExample
//
//  Created by Claire Davis on 12/22/15.
//  Copyright © 2015 Davis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataStore : NSObject

@property (nonatomic, strong)NSMutableArray *downloadedPictures;
@property(nonatomic, strong)NSMutableDictionary *images;

+ (instancetype)sharedDataStore;
- (void)downloadPicturesToDisplay:(NSUInteger)imagesToDownloadFromParseQuery
                   withCompletion:(void(^)(BOOL complete, BOOL allImagesFinished))completionBlock;
- (void)downloadPictureFromAWS:(NSString*)imageID
                withCompletion:(void(^)(BOOL complete))completionBlock;


@end
