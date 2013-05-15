//
//  ThirdViewController.h
//  Assignment4a
//
//  Created by Mahmood Contractor on 10/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController {
    UISegmentedControl *segmentedControl;
    UISwitch *switchButtonIndicator;
    UIActivityIndicatorView *activityIndicator;
    UIView *textViewForSecondSegment;
    UITextView *internalTextView;
    UIView *alertViewForThirdSegment;
    UIView *progressViewForFirstSegment;
}
@property (nonatomic, retain) IBOutlet UIView *progressViewForFirstSegment;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, retain) IBOutlet UISwitch *switchButtonIndicator;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) IBOutlet UIView *textViewForSecondSegment;
@property (nonatomic, retain) IBOutlet UITextView *internalTextView;
@property (nonatomic, retain) IBOutlet UIView *alertViewForThirdSegment;
- (IBAction)AlertButton:(id)sender;
- (IBAction)SwitchIndicatorChange:(id)sender;
- (IBAction)ActionOnSegmentSwitch:(id)sender;



@end
