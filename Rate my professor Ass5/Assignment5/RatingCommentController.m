//
//  RatingCommentController.m
//  Assignment5
//
//  Created by Mahmood Contractor on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "Assignment5AppDelegate.h"
#import "RatingCommentController.h"
#import "DetailViewController.h"
#import "SBJson.h"

@implementation RatingCommentController
@synthesize textViewForCommentView;
@synthesize textBoxForComment;
@synthesize idOfProfessorInCommentView;
@synthesize activityIndicatorInCommentView;




- (void)viewWillAppear:(BOOL)animated { 
    
    NSURLRequest *theRequest3=[NSURLRequest
                               requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"http://bismarck.sdsu.edu/rateme/comments/%@",idOfProfessorInCommentView]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSLog(@"%@",idOfProfessorInCommentView);
    
   
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest3 delegate:self];
    
    
    
    if (theConnection) {
        NSLog(@"hey connection3 is established");
        receivedDataForComment = [[NSMutableData data] retain];
        [theConnection autorelease];
        
        
    } else {
        NSLog(@"hey conn3 isnt established");
        // Inform the user that the connection failed.
    }
    textBoxForComment.text=@"";
    [activityIndicatorInCommentView startAnimating];
    [super viewWillAppear:animated];
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedDataForComment appendData:data];
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
    NSString *responseString3 = [[NSString alloc] initWithData:receivedDataForComment encoding:NSUTF8StringEncoding];
    //[receivedData1 autorelease];
    NSArray *jsonParsedArray = [responseString3 JSONValue];
    
    [responseString3 autorelease];
    
   objectForTextKey = [[NSMutableArray alloc]init ];
    objectForDateKey = [[NSMutableArray alloc]init ];
    arrayContainingComment = [[NSMutableArray alloc]init ];
    
    for (NSDictionary *user in jsonParsedArray) {
        [objectForTextKey addObject:[user objectForKey:@"text"]];
        [objectForDateKey addObject:[user objectForKey:@"date"]];
       
    }
    //[userData3 autorelease];
    for(int i=0; i<[objectForTextKey count];i++)
    {
        NSString* helluva = [NSString stringWithFormat:@"%@-->%@",[objectForDateKey objectAtIndex:i],[objectForTextKey objectAtIndex:i]];
        [arrayContainingComment addObject:helluva];
    }
    
    NSMutableString* theText = [NSMutableString new];
    for (NSString* line in arrayContainingComment)
    {
        [theText appendFormat: @"%@\n", line];
    }
    [textViewForCommentView setEditable:NO];
    textViewForCommentView.text = theText;
        [theText autorelease];
    [activityIndicatorInCommentView stopAnimating];
 }



- (IBAction)backgroundTap:(id)sender //method implemented to release the keyboard after background is tapped anywhere by the user.
{
    [textBoxForComment resignFirstResponder];
    
}


- (void)viewDidUnload {
    self.idOfProfessorInCommentView=nil;
    [self setTextBoxForComment:nil];
   
    [self setTextViewForCommentView:nil];
    [self setActivityIndicatorInCommentView:nil];
    [super viewDidUnload];
}


- (void)dealloc { 
    [idOfProfessorInCommentView dealloc];
    [textBoxForComment release];
    
    [textViewForCommentView release];
    [activityIndicatorInCommentView release];
    [super dealloc];
}




- (IBAction)postComment {
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"your comment has been posted successfully" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        
    
        
        NSMutableURLRequest *request3 = [[NSMutableURLRequest alloc] init];
        [request3 setURL: [NSURL URLWithString: [NSString stringWithFormat:@"http://bismarck.sdsu.edu/rateme/comment/%@", idOfProfessorInCommentView]]];
        [request3 setHTTPMethod:@"POST"];
        [request3 setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
        [request3 setHTTPBody:[[textBoxForComment text] dataUsingEncoding:NSASCIIStringEncoding]];
        
        NSURLConnection *conn=[[NSURLConnection alloc] 
                                        initWithRequest:request3 delegate:self];
    [request3 autorelease];
    [conn autorelease];
       
    [alert show];
    [alert release];
    [self viewWillAppear:YES];
    [textBoxForComment resignFirstResponder];
    

}
@end
