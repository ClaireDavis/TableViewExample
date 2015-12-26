//
//  Location.m
//  TableViewExample
//
//  Created by Claire Davis on 12/22/15.
//  Copyright © 2015 Davis. All rights reserved.
//


#import "Location.h"

@implementation Location

//initializes location object from parse information so that we can access city
- (instancetype)init
{
  return [self initWithCity:@"'" country:@"" geoPoint:[PFGeoPoint geoPoint] dateTaken:[NSDate date]];
}

- (instancetype)initWithCity:(NSString *)city
                     country:(NSString *)country
                    geoPoint:(PFGeoPoint *)geoPoint
                   dateTaken:(NSDate *)dateTaken
{
  self = [super init];
  if (self) {
    _city = city;
    _country = country;
    _geoPoint = geoPoint;
    _dateTaken = dateTaken;
    _weather = @{};
  }
  
  return self;
}

@end
