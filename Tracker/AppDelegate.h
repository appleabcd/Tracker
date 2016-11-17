//
//  AppDelegate.h
//  Tracker
//
//  Created by wilekson on 189//16.
//  Copyright © 2016 Arvi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>
// #importnya gue tambahin corelocation, terus interfacenya gue tambahin si CLLocationManagerDelegate
@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>
// Gue tambahin propertynya juga itu
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

