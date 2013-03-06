//
//  CustomCell.m
//  AasthaAPp
//
//  Created by Kartik Arora on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize lblName;
@synthesize lblBuyPrice;
@synthesize lblSalePrice,switchValue,lblLine2;


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [lblName release];
    [lblBuyPrice release];
    [lblSalePrice release];
    [switchValue release];
    
    [super dealloc];
}
@end
