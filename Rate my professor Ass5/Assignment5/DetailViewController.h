//
//  DetailViewController.h
//  Assignment5
//
//  Created by Mahmood Contractor on 11/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SBJson.h"
@class RatingCommentController;
@class RatingViewController;

@interface DetailViewController : UIViewController { 
       
    UILabel *labelForFirstName;
    RatingCommentController *childControllerForCommentView;
    RatingViewController *childControllerForRatingView;
    NSMutableArray *ratingKey;
    NSMutableArray *arrayWithKeyValueForRating;
    NSMutableArray *ratingValue;
    NSString *idOfSelectedProfessor;
    UILabel *labelForAverageGrade;
    UILabel *labelForTotalRating;
    UITextField *textForRating;
    UIActivityIndicatorView *indicatorView;
    NSMutableData * receivedData1;
    SBJsonStreamParserAdapter *adapter;
    SBJsonStreamParser *parser;
    UILabel *labelForLastName;
    UILabel *labelForEmailId;
    UILabel *labelForContactNumber;
    UILabel *labelForOfficeAddress;
    }

@property (nonatomic, retain) IBOutlet UILabel *labelForFirstName; 
@property (nonatomic, retain) IBOutlet UILabel *labelForLastName;
@property (nonatomic, retain) IBOutlet UILabel *labelForEmailId;
@property (nonatomic, retain) IBOutlet UILabel *labelForContactNumber;
@property (nonatomic, retain) IBOutlet UILabel *labelForOfficeAddress;
@property (nonatomic, copy) NSString *idOfSelectedProfessor;
@property (nonatomic, retain) IBOutlet UILabel *labelForAverageGrade;
@property (nonatomic, retain) IBOutlet UILabel *labelForTotalRating;
@property (nonatomic, retain) IBOutlet UITextField *textForRating;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *indicatorView;
- (IBAction)goToRatingView;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)goToCommentView;


    
@end
