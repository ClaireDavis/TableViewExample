//
//  Location.h
//  TableViewExample
//
//  Created by Claire Davis on 12/22/15.
//  Copyright © 2015 Davis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Location : NSObject

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) PFGeoPoint *geoPoint;
@property (nonatomic, strong) NSDictionary *weather;
@property (nonatomic, strong) NSDate *dateTaken;

-(instancetype)initWithCity:(NSString *)city
                    country:(NSString *)country
                   geoPoint:(PFGeoPoint *)geoPoint
                  dateTaken:(NSDate *)dateTaken;

@end

