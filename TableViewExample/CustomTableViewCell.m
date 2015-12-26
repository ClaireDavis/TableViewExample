//
//  CustomTableViewCell.m
//  TableViewExample
//
//  Created by Claire Davis on 12/22/15.
//  Copyright © 2015 Davis. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
}

// initializes objects with frames
- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self commonInit];
  }
  return self;
}

// initializes archived objects, which are all objects from nib
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonInit];
  }
  return self;
}


// common init perfoms tasks for both initializer statements
- (void)commonInit
{
  // get height and width of contentView of the cell to help set frames of objects in cell
  CGFloat cellWidth = self.contentView.bounds.size.width;
  CGFloat cellHeight = self.contentView.bounds.size.height;
  
  // set background color of cell
  self.backgroundColor = [UIColor grayColor];
  
  // initialize UIImageView with frame and set contentMode
  self.locationImageView = [[UIImageView alloc ] initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight)];
  self.locationImageView.contentMode = UIViewContentModeScaleAspectFill;
  
  // inititalize UILabel with frame and background color
  self.locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cellWidth, 20)];
  self.locationLabel.backgroundColor = [UIColor colorWithWhite:0.95 alpha:0.9];
  
  // adding subviews to view
  [self.contentView addSubview:self.locationImageView];
  [self.contentView addSubview:self.locationLabel];
}


@end
