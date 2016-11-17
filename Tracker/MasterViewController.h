//
//  MasterViewController.h
//  Tracker
//
//  Created by wilekson on 189//16.
//  Copyright © 2016 Arvi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>
// #importnya gue tambahin corelocation, terus interfacenya gue tambahin si CLLocationManagerDelegate@class DetailViewController;

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, CLLocationManagerDelegate>


//@property (strong, nonatomic) DetailViewController *detailViewController;
// Gue tambahin propertynya juga itu
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property(nonatomic,assign) BOOL *btrEnabled;
@property(nonatomic,assign) BOOL *rtbEnabled;
-(IBAction)popover:(id)sender;
-(IBAction)switchBTR:(id)sender;
@end

