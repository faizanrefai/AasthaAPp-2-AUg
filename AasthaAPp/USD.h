//
//  USD.h
//  AasthaAPp
//
//  Created by Kartik Arora on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
#import "JSON.h"
#import "JSONParser.h"
#import "AlertHandler.h"

@interface USD : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arrList;
    
    NSMutableArray *arrBuyPrice; 
    NSMutableArray *arrSalePrice;
    IBOutlet UITableView *tblData;
    
      NSTimer *timer;
}
-(void)FetchData;

@property(nonatomic,retain)IBOutlet CustomCell *objCell;
-(IBAction)Back:(id)sender;

@end
