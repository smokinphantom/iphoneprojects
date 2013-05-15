//
//  DetailViewController.m
//  Assignment5
//
//  Created by Mahmood Contractor on 11/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Assignment5AppDelegate.h"
#import "RatingCommentController.h"
#import "RatingViewController.h"
#import "DetailViewController.h"
#import "SBJson.h"
#import "RootViewController.h"

@implementation DetailViewController

@synthesize labelForFirstName; 
@synthesize labelForLastName;
@synthesize labelForEmailId;
@synthesize labelForContactNumber;
@synthesize labelForOfficeAddress;
@synthesize idOfSelectedProfessor;
@synthesize labelForAverageGrade;
@synthesize labelForTotalRating;
@synthesize textForRating;
@synthesize indicatorView;




- (void)viewWillAppear:(BOOL)animated { 
    
   
       
    NSURLRequest *theRequest=[NSURLRequest
                              requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"http://bismarck.sdsu.edu/rateme/instructor/%@",idOfSelectedProfessor]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
   
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
       

    if (theConnection) {
        NSLog(@"hey connection2 is established");
        receivedData1 = [[NSMutableData data] retain];
         [theConnection autorelease];       
        
    } else {
        NSLog(@"hey conn2 isnt established");
        // Inform the user that the connection failed.
    }
    [indicatorView startAnimating];
   
    [super viewWillAppear:animated];
}




- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData1 appendData:data];
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
    NSString *responseString1 = [[NSString alloc] initWithData:receivedData1 encoding:NSUTF8StringEncoding];
    NSDictionary *jsonParsedDictionary = [responseString1 JSONValue];
    

    
    
    labelForFirstName.text = [NSString stringWithFormat:@"%@",[jsonParsedDictionary objectForKey:@"firstName"]];
    labelForLastName.text = [NSString stringWithFormat:@"%@",[jsonParsedDictionary objectForKey:@"lastName"]];
    labelForEmailId.text = [NSString stringWithFormat:@"%@",[jsonParsedDictionary objectForKey:@"email"]];
    labelForContactNumber.text = [NSString stringWithFormat:@"%@",[jsonParsedDictionary objectForKey:@"phone"]];
    labelForOfficeAddress.text = [NSString stringWithFormat:@"%@",[jsonParsedDictionary objectForKey:@"office"]];
   
    ratingValue = [[NSMutableArray alloc]init];
    ratingKey = [[NSMutableArray alloc]init];
    arrayWithKeyValueForRating = [[NSMutableArray alloc]init];
    
    for(id ratin in [jsonParsedDictionary objectForKey:@"rating"])
    {
        [ratingValue addObject:[[jsonParsedDictionary objectForKey:@"rating"] objectForKey:ratin]]; 
        [ratingKey addObject:ratin];
      
    }
    for(int i=0;i<[ratingValue count];i++)
    {
        NSString* keyvaluepair = [NSString stringWithFormat:@"%@ %@",[ratingKey objectAtIndex:i],[ratingValue objectAtIndex:i]];
        [arrayWithKeyValueForRating addObject:keyvaluepair];
    }
   
    
    labelForAverageGrade.text = [arrayWithKeyValueForRating objectAtIndex:0];
    labelForTotalRating.text = [arrayWithKeyValueForRating objectAtIndex:1];
     [responseString1 autorelease];
    [indicatorView stopAnimating];
  
}



- (IBAction)goToRatingView {

    if (childControllerForRatingView == nil) {
        childControllerForRatingView = [[RatingViewController alloc] initWithNibName:@"RatingView" bundle:nil];
    }
    childControllerForRatingView.title = @"Ratings";
    childControllerForRatingView.numberToStringForRating = idOfSelectedProfessor;
    [self.navigationController pushViewController:childControllerForRatingView animated: YES];


}




- (IBAction)backgroundTap:(id)sender //method implemented to release the keyboard after background is tapped anywhere by the user.
{
    [textForRating resignFirstResponder];
    
}

- (IBAction)goToCommentView {
    if (childControllerForCommentView == nil) {
        childControllerForCommentView = [[RatingCommentController alloc] initWithNibName:@"RatingComment" bundle:nil];
    }
    childControllerForCommentView.title = @"Comments";
    childControllerForCommentView.idOfProfessorInCommentView = idOfSelectedProfessor;
    [self.navigationController pushViewController:childControllerForCommentView animated: YES];
}


- (void)viewDidUnload { 
    self.labelForFirstName = nil; 
    self.idOfSelectedProfessor = nil;
    [self setLabelForLastName:nil];
    [self setLabelForEmailId:nil];
    [self setLabelForContactNumber:nil];
    [self setLabelForOfficeAddress:nil];
    [self setLabelForAverageGrade:nil];
    [self setLabelForTotalRating:nil];
    [self setTextForRating:nil];
    [self setIndicatorView:nil];
    [super viewDidUnload];
}

- (void)dealloc { 
    [labelForFirstName release]; 
    [idOfSelectedProfessor release];
    [labelForLastName release];
    [labelForEmailId release];
    [labelForContactNumber release];
    [labelForOfficeAddress release];
    [labelForAverageGrade release];
    [labelForTotalRating release];
    [textForRating release];
    [indicatorView release];
    [super dealloc];
}



@end
