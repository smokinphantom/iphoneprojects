//
//  RatingCommentController.h
//  Assignment5
//
//  Created by Mahmood Contractor on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJson.h"

@interface RatingCommentController : UIViewController { 
    
    
     NSString *idOfProfessorInCommentView;
    UIActivityIndicatorView *activityIndicatorInCommentView;
    NSMutableArray *arrayContainingComment;
    NSMutableArray *objectForTextKey;
    NSMutableArray *objectForDateKey;
    NSMutableData *receivedDataForComment;
    UITextField *textBoxForComment;
    SBJsonStreamParserAdapter *adapter;
    SBJsonStreamParser *parser;
   
    UITextView *textViewForCommentView;
}
@property (nonatomic, retain) IBOutlet UITextField *textBoxForComment;
@property (nonatomic, copy) NSString *idOfProfessorInCommentView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicatorInCommentView;
@property (nonatomic, retain) IBOutlet UITextView *textViewForCommentView;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)postComment;


@end
