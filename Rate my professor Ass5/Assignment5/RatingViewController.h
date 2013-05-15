//
//  RatingViewController.h
//  Assignment5
//
//  Created by Mahmood Contractor on 11/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SBJson.h"

@interface RatingViewController : UIViewController{

    NSString *numberToStringForRating;
    UITextField *textForRating;
    SBJsonStreamParserAdapter *adapter;
    SBJsonStreamParser *parser;
    NSMutableData *ratingToBePosted;

}

@property (nonatomic, retain) IBOutlet UITextField *textForRating;
@property (nonatomic, copy) NSString *numberToStringForRating;
- (IBAction)postRating;

@end
