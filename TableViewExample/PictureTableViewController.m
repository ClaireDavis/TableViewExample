//
//  PictureTableViewController.m
//  TableViewExample
//
//  Created by Claire Davis on 12/22/15.
//  Copyright © 2015 Davis. All rights reserved.
//

#import "PictureTableViewController.h"
#import "DataStore.h"
#import "CustomTableViewCell.h"
#import <AWSS3/AWSS3.h>
#import "ImageObject.h"


@interface PictureTableViewController ()

@property (nonatomic, strong) DataStore *store;

@end

@implementation PictureTableViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // establish data store
  self.store = [DataStore sharedDataStore];
  
  // download images from databases
  [self downloadImagesToDisplay];
  
  self.refreshControl = [[UIRefreshControl alloc] init];
  self.refreshControl.backgroundColor = [UIColor lightGrayColor];
  self.refreshControl.tintColor = [UIColor whiteColor];
  [self.refreshControl addTarget:self
                          action:@selector(downloadImagesToDisplay)
                forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Table view data source

- (void)downloadImagesToDisplay
{
  // first download imageIds from Parse database and when all imageIds are downloaded
  // then download actual PNG from AWS S3
  [self.store downloadPicturesToDisplay:15 withCompletion:^(BOOL complete, BOOL allImagesFinished) {
    if (complete && allImagesFinished) {
      for (ImageObject *object in self.store.downloadedPictures) {
        [self.store downloadPictureFromAWS:object.imageID withCompletion:^(BOOL complete) {
          if (complete) {
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
              [self.tableView reloadData];
            }];
          }
        }];
      }
      [[NSOperationQueue mainQueue]addOperationWithBlock:^{
        // if is refreshing end refreshing then reload table view either way
        if (self.refreshControl) {
          [self.refreshControl endRefreshing];
        }
        [self.tableView reloadData];
      }];
    }
  }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // return same number of rows as images to display from Parse
  return self.store.downloadedPictures.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pictureCell" forIndexPath:indexPath];
  
  // set UIImageView to have image with the ID of that ImageObject in the Data Store's image array
  ImageObject *image = self.store.downloadedPictures[indexPath.row];
  NSString *imageTitle = image.imageID;
  
  // fill label with city of image
  cell.locationLabel.text = image.location.city;
  cell.locationImageView.image = self.store.images[imageTitle];
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  // get height, set cell height so that 7 cells appear on screen
  CGFloat height = [UIScreen mainScreen].bounds.size.height;
  return height/7;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                    withVelocity:(CGPoint)velocity
             targetContentOffset:(inout CGPoint *)targetContentOffset
{
  // when table view nears end of table, download more images to display
  CGFloat currentOffset = self.tableView.contentOffset.y;
  CGFloat targetLoadOffset = self.tableView.contentSize.height - 1.5 * self.tableView.frame.size.height;
  if (currentOffset >= targetLoadOffset) {
    [self downloadImagesToDisplay];
  }
}

@end
