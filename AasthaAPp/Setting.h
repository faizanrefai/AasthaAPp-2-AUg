//
//  Setting.h
//  AasthaAPp
//
//  Created by Kartik Arora on 7/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
#import "JSON.h"
#import "JSONParser.h"
#import "AlertHandler.h"
@interface Setting : UIViewController<UITableViewDelegate ,UITableViewDataSource>
{  IBOutlet UITableView *tblData;
    NSMutableArray *arrList;
    NSMutableArray *arrUnselectedList;

}
-(IBAction)Back:(id)sender;
-(IBAction)Done:(id)sender;
@property(nonatomic,retain)IBOutlet CustomCell *objCell;
@end
