//
//  DetailViewController.h
//  AasthaAPp
//
//  Created by Kartik i-phone on 7/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "JSONParser.h"
#import "AlertHandler.h"
#import "MasterViewController.h"

#import "InformationScreen.h"
#import "AppDelegate.h"
@class FinalView;

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate,UITextFieldDelegate>
{
    FinalView *objMaster;
    
    IBOutlet UIScrollView *scrlView;
    
    AppDelegate *objAppdel;
    
}
@property (strong, nonatomic) id detailItem;
@property (retain, nonatomic) IBOutlet UITextField *txtUsername;

@property (retain, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
- (IBAction)Login:(id)sender;
- (IBAction)Click:(id)sender;
-(IBAction)NewUser:(id)sender;

@end
