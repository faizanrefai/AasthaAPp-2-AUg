//
//  DetailViewController.m
//  AasthaAPp
//
//  Created by Kartik i-phone on 7/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize txtUsername = _txtUsername;
@synthesize txtPassword = _txtPassword;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize masterPopoverController = _masterPopoverController;

- (void)dealloc
{
    [_detailItem release];
    [_detailDescriptionLabel release];
    [_masterPopoverController release];
    [_txtUsername release];
    [_txtPassword release];
    [super dealloc];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release]; 
        _detailItem = [newDetailItem retain]; 

        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    objAppdel=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [self setTxtUsername:nil];
    [self setTxtPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{  self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1];
    
    _txtUsername.text=@"";
    _txtPassword.text=@"";
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [scrlView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//    } else {
        return NO;
//    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Login", @"Login");
    }
    return self;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    
}	
- (IBAction)Click:(id)sender{

}
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (IBAction)Login:(id)sender {
    [objAppdel Rechability1];
    if([_txtUsername.text isEqualToString:@""] || [_txtPassword.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Aastha" message:@"Please Fill Required Field." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else{
    [AlertHandler showAlertForProcess];
    
    NSString *url=[NSString stringWithFormat:@"http://aasthaaurum.com.rws4.my-hosting-panel.com/Service.asmx/ValidateUser?userName=%@&password=%@",_txtUsername.text,_txtPassword.text];
    
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    JSONParser *parser = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(newsParse:) andHandler:self]; 
    NSLog(@"%@",parser);
    }
   
}
-(IBAction)NewUser:(id)sender{
    InformationScreen *objMaster1=[[InformationScreen alloc]initWithNibName:@"InformationScreen" bundle:nil];
    [self.navigationController presentModalViewController:objMaster1 animated:YES];
    

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [scrlView setContentOffset:CGPointMake(0, textField.frame.origin.y - 50) animated:YES];
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
         [scrlView setContentOffset:CGPointMake(0, 0) animated:YES];
    // [textField resignFirstResponder];
    return YES;
}

-(void)newsParse:(NSDictionary*)dic
{
    NSLog(@"%@",dic);
    
    NSString *strId=[[dic valueForKey:@"d"]valueForKey:@"UserId"];
    if([strId isEqualToString:@"0"]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:[[dic valueForKey:@"d"]valueForKey:@"Message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    
    }
    else{
    objAppdel.strSelect=@"Login";
        
    objMaster=[[FinalView alloc]initWithNibName:@"FinalView" bundle:nil];
    
        [[NSUserDefaults standardUserDefaults] setValue:strId forKey:@"LoginID"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
//        [objMaster setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
//        
//        [self presentModalViewController:objMaster animated:YES];
//        
        
        [self.navigationController pushViewController:objMaster animated:YES];
        
    }
    [AlertHandler hideAlert];
    
    
}

@end
