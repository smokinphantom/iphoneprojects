//
//  Ass3ViewController.h
//  Ass3
//
//  Created by Mahmood Contractor on 9/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ass3ViewController : UIViewController
{
    int count;
    UILabel *display;
    UITextField *xCoordinate;
    UITextField *yCoordinate;
}
- (IBAction)Increment;
- (IBAction)positionOfX;
- (IBAction)backgroundTap:(id)sender;
@property (nonatomic, retain) IBOutlet UILabel *display;
@property (nonatomic, retain) IBOutlet UITextField *xCoordinate;
@property (nonatomic, retain) IBOutlet UITextField *yCoordinate;

@end
