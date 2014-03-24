//
//  ViewController.m
//  createbugmiles
//
//  Created by mahesh lad on 08/02/2014.
//  Copyright (c) 2014 mahesh lad. All rights reserved.
//

#import "ViewController.h"
//for ipAddress
#include <ifaddrs.h>
#include <arpa/inet.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    iUserId = 184512;
    iActivity = 1;
    iDevice = 2;
    dtDateRun = @"";
    fDistance = 0.0f;
    iDistanceUnit = 1;
    iDurationHour = 0;
    iDurationMinute = 0;
    iDurationSecond =0;
    txtComment = @"";
     txtIPAdress = @"";
    iFeeling = 1;
    iSurface = 1;
    
     NSLog(@"IPAdress: %@",[ self getIPAddress]);
    txtIPAdress = [ self getIPAddress];
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
   // [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    //@"YYYY'-'MM'-'dd'T'HH':'mm':'ss'Z'"
    [DateFormatter setDateFormat:@"YYYY'-'MM'-'dd'T'HH':'mm':'ss'Z'"];

    NSLog(@"%@",[DateFormatter stringFromDate:[NSDate date]]);
    dtDateRun =[NSString stringWithFormat:@"%@",[DateFormatter stringFromDate:[NSDate date]]];

   // NSLocale* currentLocale = [NSLocale currentLocale];
    //[[NSDate date] descriptionWithLocale:currentLocale];
    
    //change format for txtDatetime field
    [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    _txtDateTime.text = [NSString stringWithFormat:@"%@",[DateFormatter stringFromDate:[NSDate date]]];
    _txtUserId.text= [NSString stringWithFormat:@"%i", iUserId] ;
    
    _txtHour.text = [NSString stringWithFormat:@"%i", iDurationHour];
    _txtMinute.text = [NSString stringWithFormat:@"%i", iDurationMinute];
    _txtSecond.text = [NSString stringWithFormat:@"%i", iDurationSecond];
   // _outletSliderHour. = 1;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidUnload{
    // realse
    //e.g. self.myOutlet = nil
    self.txtUserId = nil;
    self.txtDateTime = nil;
    self.txtHour = nil;
    self.txtMinute = nil;
    self.txtSecond = nil;
    self.outletFeeling = nil;
    self.outletSliderHour= nil;
    
    iUserId = 0;
    iActivity = 0;
    iDevice = 2;
    dtDateRun = nil;
    fDistance = 0.0f;
    iDistanceUnit = 1;
    iDurationHour = 0;
    iDurationMinute = 0;
    iDurationSecond =0;
    txtComment = nil;
    txtIPAdress = nil;
    iFeeling = 1;
    iSurface = 1;
    
}

- (IBAction)Hoursliderchange:(id)sender {
  
    _txtHour.text = [NSString stringWithFormat:@"%1.0f", _outletSliderHour.value];
    iDurationHour = _outletSliderHour.value;
}

- (IBAction)SecondSliderchange:(id)sender {
    _txtSecond.text = [NSString stringWithFormat:@"%1.0f", _outletSliderSecond.value];
    iDurationSecond =  _outletSliderSecond.value;
}

- (IBAction)MinuteSliderchange:(id)sender {
     _txtMinute.text = [NSString stringWithFormat:@"%1.0f", _outletSliderMinute.value];
    iDurationMinute = _outletSliderMinute.value;
}
- (IBAction)DistanceSliderchange:(id)sender {
    _outletDistance.text = [NSString stringWithFormat:@"%2.6f", _outletSliderDistance.value];
    fDistance = _outletSliderDistance.value;
}

- (IBAction)onDistanceUnit:(id)sender {
    switch (self.outletDistanceUnit.selectedSegmentIndex) {
        case 0:
        //self.segmentLabel.text =@"Segment 1 selected.";
            iDistanceUnit = 1;
            break;
        case 1:
        //self.segmentLabel.text =@"Segment 2 selected.";
            iDistanceUnit = 2;
            break;
            
        default:
            break;
           }
    
}

- (IBAction)onFeeling:(id)sender {
    switch (self.outletFeeling.selectedSegmentIndex) {
        case 0:
            //self.segmentLabel.text =@"Segment 1 selected.";
            iFeeling = 1;
            break;
        case 1:
            //self.segmentLabel.text =@"Segment 2 selected.";
            iFeeling = 2;
            break;
        case 2:
            //self.segmentLabel.text =@"Segment 2 selected.";
            iFeeling = 3;
            break;

        default:
            break;
    }

}

- (IBAction)onSurface:(id)sender {
    switch (self.outletSurface.selectedSegmentIndex) {
        case 0:
            iSurface = 1;
            break;
        case 1:
            
            iSurface = 2;
            break;
        case 2:
            
            iSurface = 3;
            break;
        case 3:
            
            iSurface = 3;
            break;
        default:
            break;
    }

}

- (IBAction)onSave:(id)sender {
    
    
    //if there is a connection going on just cancel it.
    [self.connection cancel];
    
    //initialize new mutable data
    NSMutableData *data = [[NSMutableData alloc] init];
    self.receivedData = data;
    
    //initialize url that is going to be fetched.
    
    NSURL *myURL = [[NSURL alloc]initWithString:@"http://therunningbug-staging.co.uk/api.ashx/v2/bugmiles.json"];
    //initialize a request from url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[myURL standardizedURL]];
    
    //specify that it will be a post request
    [request setHTTPMethod:@"POST"];
    
    
    //This is how we set header fields

    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"bjFyd3hicGdld3FoOk1vYmlsZVRlc3RVc2Vy" forHTTPHeaderField:@"Rest-User-Token"];

    
   
    
    //initialize a post data
   //   NSString *stringData = @"some data";
    
     NSString *stringData = [[NSString alloc] initWithFormat:@"UserId=%i&Activity=%i&Device=%i&DateRun=%@&Distance=%2.6f&DistanceUnit=%i&DurationHours=%i&DurationMinutes=%i&DurationSeconds=%i&Comment=%@&IPAddress=%@&Feeling=%i&Surface=%i",iUserId,iActivity,iDevice,dtDateRun,fDistance,iDistanceUnit,iDurationHour,iDurationMinute,iDurationSecond,txtComment,txtIPAdress,iFeeling,iSurface];


    

     // Convert your data and set your request's HTTPBody property
 
    NSData *requestBodyData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = requestBodyData;
    
    // Create url connection and fire request
   
       [NSURLConnection connectionWithRequest:request delegate:self];
    
    //send complete message
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Successful"
                          message: @" Run Posted"
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];

}


-(void) connection:(NSURLConnection *) connection didFailWithError:(NSError *)error
{
    NSLog(@"conn didFailWithError");
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The download could not complete -please connect through wifi or 3g" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
    [errorView show];
    
    //close spinning wheel
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

- (IBAction)onComment:(id)sender {
    txtComment = [[NSString alloc] initWithString: _outletComment.text];
    
}

// background Touched routine
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_outletComment resignFirstResponder];
}

//get IP address
- (NSString *)getIPAddress
{
	NSString *address = @"error";
	struct ifaddrs *interfaces = NULL;
	struct ifaddrs *temp_addr = NULL;
	int success = 0;
    
	// retrieve the current interfaces - returns 0 on success
	success = getifaddrs(&interfaces);
	if (success == 0)
	{
		// Loop through linked list of interfaces
		temp_addr = interfaces;
		while(temp_addr != NULL)
		{
			if(temp_addr->ifa_addr->sa_family == AF_INET)
			{
				// Check if interface is en0 which is the wifi connection on the iPhone
				if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en1"])
				{
					// Get NSString from C String
					address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
				}
			}
            
			temp_addr = temp_addr->ifa_next;
		}
	}
    
	// Free memory
	freeifaddrs(interfaces);
    
	return address;
}


@end
