//
//  AWSDownloadManager.m
//  TableViewExample
//
//  Created by Claire Davis on 12/23/15.
//  Copyright © 2015 Davis. All rights reserved.
//

#import "AWSDownloadManager.h"
#import <AWSS3/AWSS3.h>

@implementation AWSDownloadManager

// manages download of PNG from AWS
+ (void)downloadImageWithImageID:(NSString *)imageID
                      completion:(void (^)(UIImage *))completionBlock
                         failure:(void (^)(NSError *))failure
{
  AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];
  
  NSString *downloadingFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"thumbnail%@",imageID]];
  NSLog(@"downloading file pat: %@",downloadingFilePath);
  NSURL *downloadingFileURL = [NSURL fileURLWithPath:downloadingFilePath];
  NSLog(@"downloading file URL: %@",downloadingFileURL);
  
  AWSS3TransferManagerDownloadRequest *downloadRequest = [AWSS3TransferManagerDownloadRequest new];
  downloadRequest.bucket = @"fissamplebucket";
  downloadRequest.key = [NSString stringWithFormat:@"%@",imageID];
  downloadRequest.downloadingFileURL = downloadingFileURL;
  
  [[transferManager download:downloadRequest]
   continueWithExecutor:[AWSExecutor mainThreadExecutor]
   withBlock:^id(AWSTask *task) {
    if (task.error) {
      NSLog(@"taskerror: %@",task.error);
      if ([task.error.domain isEqualToString:AWSS3TransferManagerErrorDomain]) {
        switch (task.error.code) {
          case AWSS3TransferManagerErrorCancelled:
          case AWSS3TransferManagerErrorPaused:
            break;
          default:
            NSLog(@"Error: %@", task.error);
            failure(task.error);
            break;
        }
      } else {
        NSLog(@"error: %@", task.error);
        failure(task.error);
      }
    }
    if (task.result) {
      AWSS3TransferManagerDownloadOutput *downloadOutput = task.result;
      NSLog(@"download output: %@",downloadOutput);
      [[NSOperationQueue mainQueue]addOperationWithBlock:^{
        UIImage *image = [UIImage imageWithContentsOfFile:downloadingFilePath];
        completionBlock(image);
      }];
    }
    return nil;
  }];
}

@end
