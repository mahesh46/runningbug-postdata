//
//  ViewController.h
//  createbugmiles
//
//  Created by mahesh lad on 08/02/2014.
//  Copyright (c) 2014 mahesh lad. All rights reserved.
//

#import <UIKit/UIKit.h>
// for IPAddress
#include <ifaddrs.h>
#include <arpa/inet.h>

@interface ViewController : UIViewController
{
    int iUserId;
    int iActivity;
    int iDevice;
    NSString * dtDateRun;
    float fDistance;
    int iDistanceUnit;
    int iDurationHour;
    int iDurationMinute;
    int iDurationSecond;
     NSString * txtComment;
    NSString * txtIPAdress;
    int iFeeling;
    int iSurface;
}
@property (weak, nonatomic) IBOutlet UITextField *txtUserId;
@property (weak, nonatomic) IBOutlet UITextField *txtDateTime;
@property (weak, nonatomic) IBOutlet UITextField *txtHour;
@property (weak, nonatomic) IBOutlet UITextField *txtMinute;
@property (weak, nonatomic) IBOutlet UITextField *txtSecond;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletDistanceUnit;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletFeeling;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletSurface;
@property (weak, nonatomic) IBOutlet UIButton *onSaveButtonPress;
@property (weak, nonatomic) IBOutlet UISlider *outletSliderHour;
@property (weak, nonatomic) IBOutlet UISlider *outletSliderMinute;
@property (weak, nonatomic) IBOutlet UISlider *outletSliderSecond;
- (IBAction)Hoursliderchange:(id)sender;
- (IBAction)SecondSliderchange:(id)sender;
- (IBAction)MinuteSliderchange:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *outletDistance;
@property (weak, nonatomic) IBOutlet UITextField *outletComment;

@property (weak, nonatomic) IBOutlet UISlider *outletSliderDistance;
//fields for connection and receiving data
@property (weak, nonatomic) IBOutlet NSURLConnection *connection;
@property (weak, nonatomic) IBOutlet NSMutableData *receivedData ;

- (IBAction)DistanceSliderchange:(id)sender;

- (IBAction)onDistanceUnit:(id)sender;
- (IBAction)onFeeling:(id)sender;
- (IBAction)onSurface:(id)sender;

- (IBAction)onSave:(id)sender;
- (IBAction)onComment:(id)sender;
//-(IBAction)backgroundTouched:(id)sender;
//for ipAdress
- (NSString *) getIPAddress;
@end
