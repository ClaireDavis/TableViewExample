//
//  detailViewController.h
//  TableViewExample
//
//  Created by Claire Davis on 12/25/15.
//  Copyright © 2015 Davis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureTableViewController.h"

@interface DetailViewController : UIViewController <PictureTableViewControllerDelegate>

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *likes;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *imageID;


@end
