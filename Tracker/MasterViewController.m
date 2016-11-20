//
//  MasterViewController.m
//  Tracker
//
//  Created by wilekson on 189//16.
//  Copyright © 2016 Arvi. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import <AFNetworking/AFURLSessionManager.h>

@interface MasterViewController ()
@end
@interface UIViewController () <UIPopoverPresentationControllerDelegate>

@end

@implementation MasterViewController
UIImageView *_busView;
GMSMarker *mbus;
BOOL btr,rtb;



UIViewController *ViewMenu;

-(void)popover:(id)sender{
    [self performSegueWithIdentifier:@"popup" sender:sender];
    
}
- (void)dismissPopover {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    
    return UIModalPresentationNone;
}

-(IBAction)pop:(id)sender{
    
    UIViewController *pop = [self.storyboard instantiateViewControllerWithIdentifier:@"popview"];
    [self presentViewController:pop animated:YES completion:nil];
}

//KATANYA BUAT SWITCH BUTTON
-(IBAction)switchBTR:(id)sender{

    UISwitch *mySwitch = (UISwitch *)sender;
    
    if ([mySwitch isOn]) {
        btr = YES;
    } else {
        btr= NO;
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://119.235.255.139:8080/gpstrackingapp/api/vehicle/all"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]
    initWithTitle:@"Rute"
    style:UIBarButtonItemStylePlain
    
    target:self
    action:@selector(popover:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-6.28
                                                            longitude:106.72
                                                                 zoom:11];
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 435)];
    scroll.contentSize = CGSizeMake(320, 700);
    scroll.showsHorizontalScrollIndicator = YES;
    
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    GMSMutablePath *path = [GMSMutablePath path];
    mapView.settings.myLocationButton = YES;
    [path addLatitude:-6.286267 longitude:106.727969]; // Bintaro XChange
    [path addLatitude:-6.279363 longitude:106.720164]; // BTC
    [path addLatitude:-6.265738 longitude:106.78272]; // PIM 2
    [path addLatitude:-6.242967 longitude:106.783611]; // Gancy
    [path addLatitude:-6.226542 longitude:106.8012]; //RaPlaz
    [path addLatitude:-6.225614 longitude:106.800256]; //PS
    
    mapView.settings.zoomGestures = YES;
    //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL btr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"btrSwitch"] boolValue];
    BOOL rtb = [[[NSUserDefaults standardUserDefaults] objectForKey:@"rtbSwitch"] boolValue];
    //btr = YES;
    
    if(btr){
        CLLocationCoordinate2D bus = CLLocationCoordinate2DMake(-6.215500,106.800270);
        GMSMarker *mbus = [GMSMarker markerWithPosition:bus];
        mbus.title = @"Bus 1";
        mbus.snippet = @"Rute: BXchange - Ratu Plaza \nHalte Selanjutnya: Senayan City \nJam Berangkat: 08.00 ";
        // mbus.snippet = @"Halte Selanjutnya: Senayan City";
        //mbus.snippet = @"Jam Berangkat: 08.00";
        mbus.icon = [GMSMarker markerImageWithColor:[UIColor blackColor]];
        mbus.map = mapView;
        mbus.icon = [UIImage imageNamed:@"Icon"];
        mbus.appearAnimation = kGMSMarkerAnimationPop;
        mbus.flat = YES;
        mbus.tracksInfoWindowChanges = YES;
        mbus.tracksViewChanges = YES;
    }
    if(rtb){
        CLLocationCoordinate2D bus = CLLocationCoordinate2DMake(-6.265738,106.78272);
        GMSMarker *mbus2 = [GMSMarker markerWithPosition:bus];
        mbus2.title = @"Bus 1";
        mbus2.snippet = @"Rute: Ratu Plaza \nHalte Selanjutnya: Pondok Indah \nJam Berangkat: 07.30 ";
        // mbus.snippet = @"Halte Selanjutnya: Pondok Indah";
        //mbus.snippet = @"Jam Berangkat: 07.30";
        mbus2.icon = [GMSMarker markerImageWithColor:[UIColor whiteColor]];
        mbus2.map = mapView;
        mbus2.icon = [UIImage imageNamed:@"Icon"];
        mbus2.appearAnimation = kGMSMarkerAnimationPop;
        mbus2.flat = YES;
        mbus2.tracksInfoWindowChanges = YES;
        mbus2.tracksViewChanges = YES;
    }
    CLLocationCoordinate2D bcx = CLLocationCoordinate2DMake(-6.286267,106.727969);
    GMSMarker *markerbcx = [GMSMarker markerWithPosition:bcx];
    markerbcx.title = @"Bintaro XChange";
    markerbcx.map = mapView;
    
    CLLocationCoordinate2D btc = CLLocationCoordinate2DMake(-6.279363,106.720164);
    GMSMarker *markerbtc = [GMSMarker markerWithPosition:btc];
    markerbtc.title = @"Bintaro Trade Centre";
    markerbtc.map = mapView;
    
    CLLocationCoordinate2D pim= CLLocationCoordinate2DMake(-6.265738,106.78272);
    GMSMarker *markerpim = [GMSMarker markerWithPosition:pim];
    markerpim.title = @"Pondok Indah Mall 2";
    markerpim.map = mapView;
    
    CLLocationCoordinate2D gancy = CLLocationCoordinate2DMake(-6.242967,106.783611);
    GMSMarker *markergancy = [GMSMarker markerWithPosition:gancy];
    markergancy.title = @"Gandaria City";
    markergancy.map = mapView;
    
    CLLocationCoordinate2D raplaz = CLLocationCoordinate2DMake(-6.226542,106.8012);
    GMSMarker *markerraplaz = [GMSMarker markerWithPosition:raplaz];
    markerraplaz.title = @"Ratu Plaza";
    markerraplaz.map = mapView;
    
    CLLocationCoordinate2D ps = CLLocationCoordinate2DMake(-6.225614,106.800256);
    GMSMarker *markerps = [GMSMarker markerWithPosition:ps];
    markerps.title = @"Plaza Senayan";
    markerps.map = mapView;
    
    [mapView addObserver:self
              forKeyPath:@"myLocation"
                 options:NSKeyValueObservingOptionNew
                 context:NULL];
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView.myLocationEnabled = YES;
    });
    
    self.view = mapView;
    

    }

- (void)mapView:(GMSMapView *) mapView{
    [UIView animateWithDuration: 5.0
                     animations:^{
                         _busView.tintColor = [UIColor blueColor];
                     }
                     completion:^(BOOL finished){
                         mbus.tracksViewChanges = YES;
                         
                     }];
}


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"popover"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [[object valueForKey:@"timeStamp"] description];
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */

@end
