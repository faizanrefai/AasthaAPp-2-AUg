//
//  CustomCell.h
//  AasthaAPp
//
//  Created by Kartik Arora on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *lblName;
@property (retain, nonatomic) IBOutlet UILabel *lblBuyPrice;
@property (retain, nonatomic) IBOutlet UILabel *lblSalePrice;
@property  (retain,nonatomic)IBOutlet UISwitch *switchValue;
@property (retain, nonatomic) IBOutlet UILabel *lblLine2;

@end
