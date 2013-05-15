//
//  RootViewController.m
//  Assignment5
//
//  Created by Mahmood Contractor on 11/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Assignment5AppDelegate.h"
#import "DetailViewController.h"
#import "RootViewController.h"
#import "SBJson.h"

@implementation RootViewController


- (void)viewDidLoad
{
    
    self.title = @"Rate Your Professor";
    
    //connection is being established
    NSURLRequest *theRequest=[NSURLRequest
                              requestWithURL:[NSURL URLWithString: @"http://bismarck.sdsu.edu/rateme/list"]
                              cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if (theConnection) 
    {
        NSLog(@"hey connection is established");
        receivedData = [[NSMutableData data] retain];
        [theConnection autorelease];
        
    } else 
    {
        NSLog(@"hey conn isnt established");
        // Inform the user that the connection failed.
    }
    
    
    //activity indicator is created here
  activityIndicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    
    activityIndicator.center = self.tableView.center;
    
    [activityIndicator startAnimating];
    
    [self.tableView addSubview: activityIndicator];
    
    [super viewDidLoad];
}




- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
    SBJsonStreamParserStatus status = [parser parse:data];
    if (status == SBJsonStreamParserError) {
        NSLog(@"Parser error: %@", parser.error);
        //Handle error
    } else if (status == SBJsonStreamParserWaitingForData) {
        NSLog(@"Parser waiting for more data.");
        //Normal state
    }
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    [receivedData release];
    //parsed value is being extracted here
    NSArray *jsonParsedArray = [responseString JSONValue];
    [responseString release];
    NSLog(@"huhu %@",jsonParsedArray);
   NSMutableArray *objectsOfKeyFirstName = [NSMutableArray array];
     for (NSDictionary *user in jsonParsedArray) {
         [objectsOfKeyFirstName addObject:[user objectForKey:@"firstName"]];
    }
   
    
    
    NSMutableArray *objectsOfKeyLastName = [NSMutableArray array];
    for (NSDictionary *user in jsonParsedArray) {
        [objectsOfKeyLastName addObject:[user objectForKey:@"lastName"]];
    }
    
    
    
    NSMutableArray *objectsOfKeyId = [NSMutableArray array];
    for (NSDictionary *user in jsonParsedArray) {
        [objectsOfKeyId addObject:[user objectForKey:@"id"]];
    }
    
    
    
       arrayContainingFullName = [[NSMutableArray alloc] init];
    
    for (int i=0;i<[objectsOfKeyFirstName count];i++) {
        
        [arrayContainingFullName addObject:[NSString stringWithFormat:@"%@" @" %@",[objectsOfKeyFirstName objectAtIndex:i],[objectsOfKeyLastName objectAtIndex:i]]];
    }
    NSLog(@"the final listing array that m using:%@",arrayContainingFullName);
    
    
    arrayContainingId = [[NSMutableArray alloc] init];
    for (id a in objectsOfKeyId) {
        [arrayContainingId addObject:a];
    }
    NSLog(@"the final id array that m using:%@",objectsOfKeyId);

    [activityIndicator stopAnimating];
    
    //tableview is reloaded to get the updated view
    [self.tableView reloadData];
    // do something with the data
}




- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    [connection release];
    [receivedData release];
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}


- (void)connection:(NSURLConnection *)connection 
didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}




- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    [childControllerForDetailView release], 
    childControllerForDetailView = nil;

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [childControllerForDetailView release];
   
    [super dealloc];
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section {
    return [arrayContainingFullName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * DisclosureButtonCellIdentifier = @"DisclosureButtonCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DisclosureButtonCellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DisclosureButtonCellIdentifier] autorelease];
    }
    NSUInteger row = [indexPath row];
    NSString *rowString = [arrayContainingFullName objectAtIndex:row];
    cell.textLabel.text = rowString;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton; 
    return cell;
}

#pragma mark -
#pragma mark Table Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hey, do you see the disclosure button?" message:@"Please touch that to proceed to Detailed information" delegate:nil cancelButtonTitle:@"Won't happen again" otherButtonTitles:nil]; 
    [alert show];
    [alert release];
}

- (void)tableView:(UITableView *)tableView 
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath 
{ 
    //child controller instance is being allocated
    if (childControllerForDetailView == nil) {
    childControllerForDetailView = [[DetailViewController alloc] initWithNibName:@"DetailView" bundle:nil];
}
    
    NSUInteger row = [indexPath row];
    NSString *selectedFullName = [arrayContainingFullName objectAtIndex:row];
    NSString *selectedid = [arrayContainingId objectAtIndex:row];
    
    childControllerForDetailView.idOfSelectedProfessor = selectedid;
    childControllerForDetailView.title = selectedFullName;
    
    //view is being pushed to detailedview
    [self.navigationController pushViewController:childControllerForDetailView animated: YES];
     }


@end
