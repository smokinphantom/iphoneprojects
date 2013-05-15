//
//  FirstViewController.m
//  Assignment4a
//
//  Created by Mahmood Contractor on 10/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "Assignment4aAppDelegate.h"

@implementation FirstViewController

@synthesize picker;
@synthesize sportsOfCountries;
@synthesize listOfSports;
@synthesize sliderForSelectingSports;
@synthesize listOfCountries;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSBundle *bundle = [NSBundle mainBundle];
    
    //set the plist file
    NSString *plistPath = [bundle pathForResource:@"countrySports" ofType:@"plist"];
    
    //load contents of plist file to a dictionary variable
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];

    self.sportsOfCountries = dictionary; 
    [dictionary release];
    
    NSArray *components = [self.sportsOfCountries allKeys];
    
    //get the sorted list of countries in sorted.
    NSArray *sorted = [components sortedArrayUsingSelector:@selector(compare:)];
    self.listOfCountries = sorted;

    
    NSString *selectedState = [self.listOfCountries objectAtIndex:0];
    NSArray *array = [sportsOfCountries objectForKey:selectedState]; 
    self.listOfSports = array;
    
    //set the initial value of the slider to 0 at view load
    sliderForSelectingSports.value=0;

}


//This function is used for moving the picker according to slider's value.
- (IBAction)moveSlider {
    
    //set slider's max value to row count of sports picker.
    sliderForSelectingSports.maximumValue = [listOfSports count]-1;
    
    //move picker according to sliders value.
    [picker selectRow:[sliderForSelectingSports value] inComponent:kSportComponent animated:NO];
  }



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [self setPicker:nil];
    self.sportsOfCountries = nil; 
    self.listOfCountries = nil; 
    self.listOfSports = nil;
    [self setSliderForSelectingSports:nil];
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (void)dealloc {
    [picker release];
    [sportsOfCountries release]; 
    [listOfCountries release]; 
    [listOfSports release];
    [sliderForSelectingSports release];
    [super dealloc];
}


#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2; }
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == kCountryComponent) return [self.listOfCountries count];
    return [self.listOfSports count]; }
#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component { if (component ==kCountryComponent)
                return [self.listOfCountries objectAtIndex:row]; 
                return [self.listOfSports objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView 
      didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component 
        { 
            //if the component is country component select proper list of sports accordingly
            if (component == kCountryComponent) 
            {
                sliderForSelectingSports.value=0;
                NSString *selectedState = [self.listOfCountries objectAtIndex:row]; 
                NSArray *array = [sportsOfCountries objectForKey:selectedState]; 
                self.listOfSports = array;
                [picker reloadComponent:kSportComponent];
                [picker selectRow:0 inComponent:kSportComponent animated:YES];
                
            }
            
            //if sports component is selected the slider is moved accordingly to selected row index on picker.
            if(component == kSportComponent)
            {
                int indexValueOfSelectedRow = [picker selectedRowInComponent:1];
                [sliderForSelectingSports setMinimumValue:0];
                [sliderForSelectingSports setMaximumValue:[picker numberOfRowsInComponent:1]-1];
                [sliderForSelectingSports setValue:indexValueOfSelectedRow];   
            }
            
                              
        }

@end
