//
//  ViewController.m
//  iBeaconDevice
//
//  Created by タカ on 2015/01/24.
//  Copyright (c) 2015年 Taka. All rights reserved.
//

#import "ViewController.h"

NSString* const	kUUIDString	= @"9D46B74B-AE5B-4CEA-965D-D3C4EEC89D3C"; //made by uuidgen

@interface ViewController ()
@property (nonatomic) CBPeripheralManager* peripheralManager;
@property (nonatomic, weak) IBOutlet UILabel* uuidText;
@property (nonatomic, weak) IBOutlet UITextField* majorText;
@property (nonatomic, weak) IBOutlet UITextField* minorText;
@property (nonatomic, weak) IBOutlet UIButton* buttonStart;

- (IBAction)tapStartBecon:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                   queue:dispatch_get_main_queue()];
  
  self.uuidText.text = kUUIDString;
  self.majorText.text = @"1";
  self.minorText.text = @"1";
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
  [self.peripheralManager stopAdvertising];
}

#pragma mark - delegate

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
  
}

#pragma mark - beacon
- (void)beaconing
{
  NSLog(@"start becoing");
  //ビーコン情報を設定
  NSUUID* uuid = [[NSUUID alloc] initWithUUIDString:self.uuidText.text];
  CLBeaconRegion* region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                   major:[self.majorText.text intValue]
                                                                   minor:[self.minorText.text intValue]
                                                              identifier:[uuid UUIDString]];
  
  NSDictionary* peripheralData = [region peripheralDataWithMeasuredPower:nil];//Default
  
  [self.peripheralManager startAdvertising:peripheralData];
}

#pragma mark - action
- (IBAction)tapStartBecon:(id)sender
{
  [self beaconing];
  
  [self.buttonStart setTitle:@"発信中" forState:UIControlStateNormal];
  [self.buttonStart setEnabled:NO];
}


@end
