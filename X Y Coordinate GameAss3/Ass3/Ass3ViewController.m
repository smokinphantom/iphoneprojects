//
//  Ass3ViewController.m
//  Ass3
//
//  Created by Mahmood Contractor on 9/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Ass3ViewController.h"

@implementation Ass3ViewController
@synthesize display;
@synthesize xCoordinate;
@synthesize yCoordinate;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
            //Used NSUserDefaults store the last count value for retaining it after bringing the app back from the background.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger myInt = [defaults integerForKey:@"integerKey"];
    count=myInt;
    
            //called the display method to display the latest retained count.
    
    [display setText:[NSString stringWithFormat:@"%i",count]];
    [super viewDidLoad];
    
}


- (void)viewDidUnload
{
    [self setDisplay:nil];
    [self setXCoordinate:nil];
    [self setYCoordinate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)displayCount  //used this method to display the latest count of increment button in label.
{
    [display setText:[NSString stringWithFormat:@"%i",count]];
}
- (IBAction)Increment {
    count++;
    [self displayCount];
    
            //the final value before the application, if goes to thebackground is set by this defaults object.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:count forKey:@"integerKey"];
   
            // The resignfirstresponder is called for ensuring that the textfields leave the control of thekeyboard after the incement button has been pressed.
    
    [xCoordinate resignFirstResponder];
    [yCoordinate resignFirstResponder];
    
            //the positionofx method is called to perform label shifting operations.
    
    [self positionOfX];
}

- (IBAction)backgroundTap:(id)sender //method implemented to release the keyboard after background is tapped anywhere by the user.
{
    [xCoordinate resignFirstResponder];
    [yCoordinate resignFirstResponder];
}

- (IBAction)positionOfX {
    
    
    UIScreen* mainScreen = [UIScreen mainScreen];
    CGSize screenSize = mainScreen.currentMode.size;
    float screenheight = screenSize.height;
   float screenwidth = screenSize.width;
    
    float x=21+[xCoordinate.text floatValue];
    float y=10.5+[yCoordinate.text floatValue];
    float newxpoint=display.frame.origin.x+x;
    float newypoint=display.frame.origin.y+y;
    if(newxpoint>screenwidth)
    {
        while(newxpoint>screenwidth)
        {
            newxpoint=newxpoint-screenwidth;
        }
        
        
    }else if(newxpoint<0)
    {
        while(newxpoint<0)
        {
           newxpoint=screenwidth+newxpoint; 
        }
        
    }
    if(newypoint>screenheight)
    {
        while(newypoint>screenheight)
        {
          newypoint=newypoint-screenheight;  
        }
        
    }else if(newypoint<0)
    {
        while(newypoint<0)
        {
           newypoint=screenheight+newypoint; 
        }
        
    }
    display.center=CGPointMake(newxpoint,newypoint);
    NSLog(@"%f,%f",newxpoint,newypoint);
    
    
}
- (void)dealloc {
    [display release];
    [xCoordinate release];
    [yCoordinate release];
    [super dealloc];
}
@end
