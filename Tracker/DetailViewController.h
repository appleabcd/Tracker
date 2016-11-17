//
//  DetailViewController.h
//  Tracker
//
//  Created by wilekson on 189//16.
//  Copyright © 2016 Arvi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UISwitch *btrSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *rtbSwitch;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

