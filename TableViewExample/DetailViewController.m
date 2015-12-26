//
//  detailViewController.m
//  TableViewExample
//
//  Created by Claire Davis on 12/25/15.
//  Copyright © 2015 Davis. All rights reserved.
//

#import "DetailViewController.h"
#import "DataStore.h"


@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *locationImage;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (nonatomic, strong) DataStore *store;

@end

@implementation DetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // get store
  self.store = [DataStore sharedDataStore];
  
  // set labels to values passed from segue
  self.cityLabel.text = self.city;
  self.countryLabel.text = self.country;
  self.likesLabel.text = [NSString stringWithFormat:@"Likes: %@",self.likes];
  
  // check if image has already downloaded, if it has set the image
  // if it hasn't, download it now and then set it
  if (self.store.images[self.imageID]) {
    self.locationImage.image = self.image;
  } else {
    [self.store downloadPictureFromAWS:self.imageID withCompletion:^(BOOL complete) {
      self.locationImage.image = self.store.images[self.imageID];
    }];
  }
  
}



@end
