//
//  DetailViewController.m
//  Tracker
//
//  Created by wilekson on 189//16.
//  Copyright © 2016 Arvi. All rights reserved.
//

#import "DetailViewController.h"
#import "MasterViewController.h"    

@interface DetailViewController ()

@end

@implementation DetailViewController

- (IBAction)rute1:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  
    if(_btrSwitch.on){
        [userDefaults setBool:YES forKey:@"btrSwitch"];
        [userDefaults synchronize];
        //self.view.backgroundColor = [UIColor blackColor];
    }
    else{
        [userDefaults setBool:NO forKey:@"btrSwitch"];
        [userDefaults synchronize];
        //self.view.backgroundColor = [UIColor whiteColor];
    }
}
- (IBAction)rute2:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if(_rtbSwitch.on){
        [userDefaults setBool:YES forKey:@"rtbSwitch"];
        [userDefaults synchronize];
        
    }
    else{
        [userDefaults setBool:NO forKey:@"rtbSwitch"];
        [userDefaults synchronize];
        
    }
}
#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}
- (IBAction)myUnwindAction:(UIStoryboardSegue*)unwindSegue
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
   BOOL btr = [userDefaults boolForKey:@"btrSwitch"];
    [_btrSwitch setOn:btr animated:NO];
    
    BOOL rtb = [userDefaults boolForKey:@"rtbSwitch"];
    [_rtbSwitch setOn:rtb animated:NO];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
