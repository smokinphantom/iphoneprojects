//
//  FirstViewController.h
//  Assignment4a
//
//  Created by Mahmood Contractor on 10/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCountryComponent 0 
#define kSportComponent 1

@interface FirstViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource> 
{ 
    
    NSDictionary *sportsOfCountries; 
    NSArray *listOfCountries; 
    NSArray *listOfSports;
    UISlider *sliderForSelectingSports;
    UIPickerView *picker;
    
}

@property (nonatomic, retain) IBOutlet UIPickerView *picker;
@property (retain, nonatomic) NSDictionary *sportsOfCountries; 
@property (retain, nonatomic) NSArray *listOfCountries;
@property (retain, nonatomic) NSArray *listOfSports;
@property (nonatomic, retain) IBOutlet UISlider *sliderForSelectingSports;
- (IBAction)moveSlider; 

@end
