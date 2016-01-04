//
//  PictureTableViewController.h
//  TableViewExample
//
//  Created by Claire Davis on 12/22/15.
//  Copyright © 2015 Davis. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PictureTableViewController;

// protocol to handle picture downloading after segue to detail is complete

@protocol PictureTableViewControllerDelegate <NSObject>
- (void)pictureTableViewController:(PictureTableViewController *)viewController
            didEndDownloadingImage:(NSString *)image;
@end

@interface PictureTableViewController : UITableViewController
@property (nonatomic, weak) id<PictureTableViewControllerDelegate> delegate;
@end
