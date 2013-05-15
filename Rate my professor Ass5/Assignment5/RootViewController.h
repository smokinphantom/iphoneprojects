//
//  RootViewController.h
//  Assignment5
//
//  Created by Mahmood Contractor on 11/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SBJson.h"
#import <UIKit/UIKit.h>
@class DetailViewController;

@interface RootViewController : UITableViewController
{
    UIActivityIndicatorView *activityIndicator;
    NSMutableArray *arrayContainingFullName;
    NSMutableArray *arrayContainingId;
    NSMutableData * receivedData;
    DetailViewController *childControllerForDetailView;
    SBJsonStreamParserAdapter *adapter;
    SBJsonStreamParser *parser;

}

@end
