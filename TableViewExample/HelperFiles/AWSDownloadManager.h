//
//  AWSDownloadManager.h
//  TableViewExample
//
//  Created by Claire Davis on 12/23/15.
//  Copyright © 2015 Davis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AWSDownloadManager : NSObject

+(void)downloadImageWithImageID:(NSString *)imageID
                     completion:(void (^)(UIImage *))completionBlock
                        failure:(void (^)(NSError *))failure;

@end
