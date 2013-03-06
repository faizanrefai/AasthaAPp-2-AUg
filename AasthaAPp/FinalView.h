//
//  FinalView.h
//  AasthaAPp
//
//  Created by Kartik i-phone on 7/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "JSONParser.h"
#import "CustomCell.h"
#import "AlertHandler.h"
#import "InformationScreen.h"
#import "USD.h"
#import "Setting.h"

#import "AppDelegate.h"
#import "DetailViewController.h"
@interface FinalView : UIViewController<UITabBarDelegate,UITableViewDataSource,UITableViewDelegate>

{       
    AppDelegate *objAppdel;
    
    
    IBOutlet UITabBar *tabbar;
    
    IBOutlet UIView *viewSetting;
    
    
    IBOutlet UITableView *tblData;
     NSMutableArray *arrList;
    NSMutableArray *arrListArray;
    
     NSMutableArray *arrBuyPrice; 
    NSMutableArray *arrSalePrice;
    
    NSMutableArray *arrBuyPricePrev; 
    NSMutableArray *arrSalePricePrev;
    IBOutlet UILabel *lblHeader;
    
    NSTimer *timer;
    NSString *strSelected;
    NSMutableArray *arrUnselectedList;
    IBOutlet UILabel *lblNameH;
    IBOutlet UILabel *lblBuyH;
    IBOutlet UILabel *lblSaleH;
    
}
@property(nonatomic,retain)IBOutlet CustomCell *objCell;
-(IBAction)checkOnOffState:(id)sender;
-(IBAction)information:(id)sender;
-(void)FetchData1;
-(IBAction)Reload:(id)sender;
-(IBAction)Setting:(id)sender;
-(IBAction)Logout:(id)sender;
-(void)newsParse1:(NSDictionary*)dic;


-(void)FetchData;

@end
