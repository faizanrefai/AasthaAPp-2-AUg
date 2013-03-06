//
//  MasterViewController.h
//  AasthaAPp
//
//  Created by Kartik i-phone on 7/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FinalView.h"
@class DetailViewController;

@interface MasterViewController : UIViewController
{
    NSMutableArray *arrList;
    

}
@property (strong, nonatomic) DetailViewController *detailViewController;

@end
