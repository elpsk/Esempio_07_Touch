//
//  ViewController.m
//  Lezione_08_Touch
//
//  Created by Alberto Pasca on 15/11/11.
//  Copyright (c) 2011 Cutaway SRL. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning 
{
  [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark TOUCH_EVENTS
#pragma mark -

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  
  UITouch *touch = [[event allTouches] anyObject];
  NSLog( @"TAP COUNT: %d", touch.tapCount );
  
	if ( touch.tapCount == 5 ) NSLog(@"5 TAPS!!!");
  
  if ( CGRectContainsPoint( RedView.frame, [touch locationInView:self.view ] ) ) {
    NSLog(@"RED!");
  } else if ( CGRectContainsPoint( YellowView.frame, [touch locationInView:self.view ] ) ) {
    NSLog(@"YELLOW!");
  } else {
    NSLog(@"GRAY!");
  }
  
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  
  UITouch *touch   = [touches anyObject];   
  CGPoint location = [touch locationInView:self.view];
  
  if ( CGRectContainsPoint( RedView.frame, [touch locationInView:self.view ] ) ) {
    RedView.center = location;
  }
  
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {

}

#pragma mark -
#pragma mark GESTURE_RECOGNIZER
#pragma mark -

- (void) showText:(NSString *)string {
  NSLog(@"%@", string);
}

- (void) TapRecognizer:(UITapGestureRecognizer *)sender {
	[self showText:@" *** TAP ***"];
}

- (void) RotationRecognizer:(UIRotationGestureRecognizer *)sender {
	[self showText:@" *** ROTATION ***"];
  
  CGAffineTransform transform = CGAffineTransformMakeRotation([sender rotation]);
  YellowView.transform = transform;

}

- (void) SwipeRecognizer:(UISwipeGestureRecognizer *)sender {
 
  if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
    [self showText:@" *** SWIPE LEFT ***"];
  } else {
    [self showText:@" *** SWIPE RIGHT ***"];    
  }

}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
  NSLog(@"%s", __FUNCTION__);
  
  return YES;
}

#pragma mark -
#pragma mark View lifecycle
#pragma mark -

- (void)viewDidLoad
{
  [super viewDidLoad];

  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapRecognizer:)];
  [self.view addGestureRecognizer:tap];
  [tap release];
  
  UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeRecognizer:)];
  swipe.direction = UISwipeGestureRecognizerDirectionRight;
  [self.view addGestureRecognizer:swipe];
  [swipe release];
  
  UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(RotationRecognizer:)];
  [self.view addGestureRecognizer:rotate];
  [rotate release];

}

- (void)viewDidUnload
{
  [RedView release];    RedView = nil;
  [YellowView release]; YellowView = nil;
  
  [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
  [RedView release];
  [YellowView release];
  [super dealloc];
}
@end
