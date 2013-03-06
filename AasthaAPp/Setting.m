//
//  Setting.m
//  AasthaAPp
//
//  Created by Kartik Arora on 7/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Setting.h"

@implementation Setting
@synthesize objCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    return [arrList count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CustomCell  *cell = (CustomCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        
        cell=objCell;
        objCell=nil;
        
    }
    cell.lblBuyPrice.hidden =TRUE;
    cell.lblSalePrice.hidden=TRUE;
    
    cell.lblName.text =[arrList objectAtIndex:indexPath.row];
    cell.switchValue.hidden=FALSE;
    cell.switchValue.tag=indexPath.row;
    
    cell.lblLine2.hidden=TRUE;
    [cell.switchValue addTarget:self action:@selector(checkOnOffState:) forControlEvents:UIControlEventValueChanged];
    
    
    for(int i=0;i<[arrUnselectedList count];i++){
        
        if([[arrUnselectedList objectAtIndex:i] isEqualToString:[arrList objectAtIndex:indexPath.row]]){
            
            [cell.switchValue setOn:NO];
            
            
        }
    }
    return cell;
}
    
-(IBAction)checkOnOffState:(id)sender{
        UISwitch *swtch=(UISwitch *)sender;
        if(swtch.on){
            
            for(int i=0;i<[arrUnselectedList count];i++){
                
                if([[arrUnselectedList objectAtIndex:i] isEqualToString:[arrList objectAtIndex:swtch.tag]]){
                    
                    [arrUnselectedList removeObjectAtIndex:i];
                    
                }
            }
            
            
        }
        else{
            
            [arrUnselectedList addObject:[arrList objectAtIndex:swtch.tag]];
            
            
        }
        
      
        
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [AlertHandler showAlertForProcess];
 arrUnselectedList=[[NSMutableArray alloc]init ];
    
    [arrUnselectedList addObjectsFromArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"Array"]];
    
    
    
    NSString *strId=[[NSUserDefaults standardUserDefaults]valueForKey:@"LoginID"];
    
    NSString *url=[NSString stringWithFormat:@"http://aasthaaurum.com.rws4.my-hosting-panel.com/Service.asmx/GetItemsNew?UserId=14"];
    
    
    NSLog(@"%@",url);
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    JSONParser *parser = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(newsParse1:) andHandler:self]; 

    // Do any additional setup after loading the view from its nib.
}
-(void)newsParse1:(NSDictionary*)dic{
    arrList=[[NSMutableArray alloc]init ];
    
    for(int i=0;i<[[[dic valueForKey:@"d"] valueForKey:@"Items"] count];i++){
        
        [arrList addObject:[[[[dic valueForKey:@"d"] valueForKey:@"Items"]valueForKey:@"ItemName"]objectAtIndex:i]];
        
    }
    [tblData reloadData];
    [AlertHandler hideAlert];
    
}
-(IBAction)Done:(id)sender{
    [[NSUserDefaults standardUserDefaults]setObject:arrUnselectedList forKey:@"Array"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.navigationController popViewControllerAnimated:YES];

}
-(IBAction)Back:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
   return NO;
}

@end
