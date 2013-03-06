//
//  FinalView.m
//  AasthaAPp
//
//  Created by Kartik i-phone on 7/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FinalView.h"

@implementation FinalView
@synthesize objCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         self.title = NSLocalizedString(@"Detail", @"Detail");
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
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item     {

    if(tabBar.selectedItem.tag==0){
         strSelected=@"List";
        lblBuyH.hidden=NO;
        lblSaleH.hidden=NO;
        lblNameH.hidden=NO;

        [self FetchData];
          
    }
    else if(tabBar.selectedItem.tag==1)
    {
        lblBuyH.hidden=YES;
        lblSaleH.hidden=YES;
        lblNameH.hidden=YES;
        
        strSelected=@"Setting";
        [tblData reloadData];
        
        
    }
    else if(tabBar.selectedItem.tag==2)
    {
        [self.navigationController  popToRootViewControllerAnimated:YES];
        
    }
    


}
// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ if([strSelected isEqualToString:@"List"]){

    return [arrList count];
    
}
else{
    return  [arrListArray count];
    
}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CustomCell  *cell = (CustomCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        
        cell=objCell;
        objCell=nil;
        
    }

    if([strSelected isEqualToString:@"List"]){
   
        
        cell.lblName.text = [arrList objectAtIndex:indexPath.row];
      //  NSLog(@"Current Price %d Previeous Price %d",[[arrBuyPrice objectAtIndex:indexPath.row] intValue],[[arrBuyPricePrev objectAtIndex:indexPath.row] intValue]);
        if([arrBuyPricePrev count]>0){
        if([[arrBuyPrice objectAtIndex:indexPath.row] intValue]<[[arrBuyPricePrev objectAtIndex:indexPath.row] intValue]){
            cell.lblBuyPrice.backgroundColor=[UIColor redColor];
             cell.lblBuyPrice.textColor=[UIColor whiteColor];
        }
        else if([[arrBuyPrice objectAtIndex:indexPath.row] intValue]>[[arrBuyPricePrev objectAtIndex:indexPath.row] intValue]){
            cell.lblBuyPrice.backgroundColor=[UIColor blueColor];
             cell.lblBuyPrice.textColor=[UIColor whiteColor];
        }

        else{
        
            cell.lblBuyPrice.backgroundColor=[UIColor clearColor];
            cell.lblBuyPrice.textColor=[UIColor whiteColor];

        }
        }
    cell.lblBuyPrice.text =[NSString stringWithFormat:@"%@",[arrBuyPrice objectAtIndex:indexPath.row]];
        if([arrSalePricePrev count]>0){
        if([[arrSalePrice objectAtIndex:indexPath.row] intValue]<[[arrSalePricePrev objectAtIndex:indexPath.row] intValue]){
            cell.lblSalePrice.backgroundColor=[UIColor redColor];
               cell.lblSalePrice.textColor=[UIColor whiteColor];
        }
        else if([[arrSalePrice objectAtIndex:indexPath.row] intValue]>[[arrSalePricePrev objectAtIndex:indexPath.row] intValue]){
          cell.lblSalePrice.backgroundColor=[UIColor blueColor];
              cell.lblSalePrice.textColor=[UIColor whiteColor];
        }
            else{
              cell.lblSalePrice.backgroundColor=[UIColor clearColor];
                cell.lblSalePrice.textColor=[UIColor whiteColor];
                
            
        }
        }
    cell.lblSalePrice.text = [NSString stringWithFormat:@"%@",[arrSalePrice objectAtIndex:indexPath.row]];
    }
    else{
        cell.lblName.text = [arrListArray objectAtIndex:indexPath.row];
        
        cell.lblBuyPrice.hidden=TRUE;
        cell.lblSalePrice.hidden=TRUE;
        cell.switchValue.hidden=FALSE;
        cell.switchValue.tag=indexPath.row;
        
        [cell.switchValue addTarget:self action:@selector(checkOnOffState:) forControlEvents:UIControlEventValueChanged];
        
        
        for(int i=0;i<[arrUnselectedList count];i++){
            
            if([[arrUnselectedList objectAtIndex:i] isEqualToString:[arrListArray objectAtIndex:indexPath.row]]){
                
                [cell.switchValue setOn:NO];
                
                
            }
        }
    
    }
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
//[arrSalePrice objectAtIndex:indexPath.row];
    
    
    //cell.textLabel.textColor=[UIColor whiteColor];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
//[tableView deselectRowAtIndexPath:indexPath animated:NO];
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
#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated    {
    lblHeader.text=@"List";
    
 self.navigationController.navigationBarHidden=TRUE;
}
- (void)viewDidLoad
{ 
//    self.navigationController.navigationBarHidden=TRUE;
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"USD" style:UIBarButtonItemStylePlain target:self action:@selector(USd:)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Info" style:UIBarButtonItemStylePlain target:self action:@selector(information:)];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1];
    
    [super viewDidLoad];
    strSelected=@"List";
    //hud=[[MBProgressHUD alloc]initWithView:self.view];
    objAppdel=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    // [objAppdel.window addSubview:objAppdel.tabbarcontroller.view];
    [objAppdel Rechability1];
    arrUnselectedList=[[NSMutableArray alloc]init ];
    
  //  [hud show:YES];
    
    [AlertHandler showAlertForProcess];

    [self FetchData]; 
 timer= [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                  target: self
                                                selector:@selector(FetchData1)
                                                userInfo: nil repeats:YES];

   
    
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)USd:(id)sender{

    USD *objMaster=[[USD alloc]initWithNibName:@"USD" bundle:nil];
    [self.navigationController pushViewController:objMaster animated:YES];

}
-(IBAction)information:(id)sender{
    InformationScreen *objMaster=[[InformationScreen alloc]initWithNibName:@"InformationScreen" bundle:nil];
    [self.navigationController presentModalViewController:objMaster animated:YES];
    
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
-(void)FetchData1{
    
    NSString *strId=[[NSUserDefaults standardUserDefaults]valueForKey:@"LoginID"];
    // [AlertHandler showAlertForProcess];
    
    NSString *url=[NSString stringWithFormat:@"http://aasthaaurum.com.rws4.my-hosting-panel.com/Service.asmx/GetItemsNew?UserId=%@",strId];
    
    
    
    NSLog(@"%@",url);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    JSONParser *parser = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(newsParse:) andHandler:self]; 
    // NSLog(@"%@",parser);
    //[AlertHandler hideAlert];
    
    
}

-(void)FetchData{
 //    [AlertHandler showAlertForProcess];
    NSString *strId=[[NSUserDefaults standardUserDefaults]valueForKey:@"LoginID"];
   // [AlertHandler showAlertForProcess];
    
    NSString *url=[NSString stringWithFormat:@"http://aasthaaurum.com.rws4.my-hosting-panel.com/Service.asmx/GetItemsNew?UserId=%@",strId];
    
    
    
    NSLog(@"%@",url);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    JSONParser *parser = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(newsParse:) andHandler:self]; 
   // NSLog(@"%@",parser);


}
-(void)newsParse1:(NSDictionary*)dic{
    arrBuyPricePrev=[[NSMutableArray alloc]init ];
    arrSalePricePrev=[[NSMutableArray alloc]init ];
    
    [arrSalePricePrev addObjectsFromArray:arrSalePrice];
    [arrBuyPricePrev addObjectsFromArray:arrBuyPrice];
    
    
    
    arrList=[[NSMutableArray alloc]init ];
    arrBuyPrice=[[NSMutableArray alloc]init ];
    arrSalePrice=[[NSMutableArray alloc]init ];
    arrListArray=[[NSMutableArray alloc]init ];
    
    for(int i=0;i<[[[dic valueForKey:@"d"] valueForKey:@"Items"] count];i++){
        [arrList addObject:[[[[dic valueForKey:@"d"] valueForKey:@"Items"]valueForKey:@"ItemName"]objectAtIndex:i]];
        [arrBuyPrice addObject:[[[[dic valueForKey:@"d"] valueForKey:@"Items"]valueForKey:@"Buy"]objectAtIndex:i]];
        [arrSalePrice addObject:[[[[dic valueForKey:@"d"] valueForKey:@"Items"]valueForKey:@"Sale"]objectAtIndex:i]];
        
        [arrListArray addObject:[[[[dic valueForKey:@"d"] valueForKey:@"Items"]valueForKey:@"ItemName"]objectAtIndex:i]];
    }
    
   
    
    [arrUnselectedList addObjectsFromArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"Array"]];
    
        for(int i=0;i<[arrUnselectedList count];i++){
            for (int k=0; k<[arrList count]; k++) {
                if([[arrUnselectedList objectAtIndex:i] isEqualToString:[arrList objectAtIndex:k]]){
                    [arrList removeObjectAtIndex:k];
                    
                    
                }
            }
            
        }
    
    
    [tblData reloadData];
  //  [AlertHandler hideAlert];

}
-(void)newsParse:(NSDictionary*)dic
{
  //  NSLog(@"%@",[dic valueForKey:@"d"]);
  
    arrBuyPricePrev=[[NSMutableArray alloc]init ];
    arrSalePricePrev=[[NSMutableArray alloc]init ];

    [arrSalePricePrev addObjectsFromArray:arrSalePrice];
    [arrBuyPricePrev addObjectsFromArray:arrBuyPrice];
    
    
    
    arrList=[[NSMutableArray alloc]init ];
    arrBuyPrice=[[NSMutableArray alloc]init ];
    arrSalePrice=[[NSMutableArray alloc]init ];
    arrListArray=[[NSMutableArray alloc]init ];

    for(int i=0;i<[[[dic valueForKey:@"d"] valueForKey:@"Items"] count];i++){
        [arrList addObject:[[[[dic valueForKey:@"d"] valueForKey:@"Items"]valueForKey:@"ItemName"]objectAtIndex:i]];
        [arrBuyPrice addObject:[[[[dic valueForKey:@"d"] valueForKey:@"Items"]valueForKey:@"Buy"]objectAtIndex:i]];
        [arrSalePrice addObject:[[[[dic valueForKey:@"d"] valueForKey:@"Items"]valueForKey:@"Sale"]objectAtIndex:i]];
        
        [arrListArray addObject:[[[[dic valueForKey:@"d"] valueForKey:@"Items"]valueForKey:@"ItemName"]objectAtIndex:i]];
    }
    


        
        [arrUnselectedList addObjectsFromArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"Array"]];
        
        for(int i=0;i<[arrUnselectedList count];i++){
            for (int k=0; k<[arrList count]; k++) {
                if([[arrUnselectedList objectAtIndex:i] isEqualToString:[arrList objectAtIndex:k]]){
                    [arrList removeObjectAtIndex:k];
                    
                    
                }
            }
        }
            
            
    [tblData reloadData];
    //[AlertHandler hideAlert];
    [AlertHandler hideAlert];

}
-(IBAction)Reload:(id)sender{
     [AlertHandler showAlertForProcess];
    [self FetchData]; 
}
-(IBAction)Setting:(id)sender{
   
  //  [self.view addSubview:viewSetting];
    
    
    Setting *objMaster=[[Setting alloc]initWithNibName:@"Setting" bundle:nil];
    [self.navigationController pushViewController:objMaster animated:YES];
//
    
}
-(IBAction)Logout:(id)sender{
    if(timer !=nil){
        [timer invalidate];
        timer=nil;
        
    }
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"LoginID"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if([objAppdel.strSelect isEqualToString:@"Direct"]){
        DetailViewController *objDetail=[[DetailViewController alloc]initWithNibName:@"DetailViewController_iPhone" bundle:nil];
        [self.navigationController pushViewController:objDetail animated:YES];
        
    }
    else{
  [self.navigationController popViewControllerAnimated:YES];
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
