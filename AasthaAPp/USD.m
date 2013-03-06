//
//  USD.m
//  AasthaAPp
//
//  Created by Kartik Arora on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "USD.h"

@implementation USD
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
    cell.lblBuyPrice.text =[NSString stringWithFormat:@"%@",[arrBuyPrice objectAtIndex:indexPath.row]];
  cell.lblName.textAlignment=UITextAlignmentCenter;
    
cell.lblBuyPrice.textAlignment=UITextAlignmentCenter;
    cell.lblSalePrice.textAlignment=UITextAlignmentCenter;
 cell.lblSalePrice.text =[NSString stringWithFormat:@"%@",[arrSalePrice objectAtIndex:indexPath.row]];    
    cell.lblName.text =[arrList objectAtIndex:indexPath.row];
     cell.switchValue.hidden=TRUE;
 //   cell.lblLine2.hidden=TRUE;


return cell;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=TRUE;
  //  NSString *strId=[[NSUserDefaults standardUserDefaults]valueForKey:@"LoginID"];
   
   // [AlertHandler showAlertForProcess];
       // NSLog(@"%@",parser);
    [self FetchData];
    timer= [NSTimer scheduledTimerWithTimeInterval: 1.0
                                            target: self
                                          selector:@selector(FetchData)
                                          userInfo: nil repeats:YES];
    
 
    // Do any additional setup after loading the view from its nib.
}
-(void)FetchData{
    NSString *strId=[[NSUserDefaults standardUserDefaults]valueForKey:@"LoginID"];
    
    NSString *url=[NSString stringWithFormat:@"http://aasthaaurum.com.rws4.my-hosting-panel.com/Service.asmx/GetItems?userId=%@",strId];
    
    
    
    NSLog(@"%@",url);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    JSONParser *parser = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(newsParse:) andHandler:self]; 


}
-(void)newsParse:(NSDictionary*)dic
{
    arrList=[[NSMutableArray alloc]init];
    arrBuyPrice=[[NSMutableArray alloc]init ];
    arrSalePrice=[[NSMutableArray alloc]init ];
      
    for(int i=0;i<[[dic valueForKey:@"d"] count];i++){
        [arrList addObject:[[[dic valueForKey:@"d"]valueForKey:@"Type"]objectAtIndex:i]];
        [arrBuyPrice addObject:[[[dic valueForKey:@"d"]valueForKey:@"Buy"]objectAtIndex:i]];
        [arrSalePrice addObject:[[[dic valueForKey:@"d"]valueForKey:@"Ask"]objectAtIndex:i]];
        
        }

  
    [tblData reloadData];
       // [AlertHandler hideAlert];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(IBAction)Back:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated {
    //self.navigationController.navigationBarHidden=FALSE;
    //   [timer invalidate];
    // [timer release];
    if(timer !=nil){
        [timer invalidate];
        timer=nil;
        
    }
    
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
