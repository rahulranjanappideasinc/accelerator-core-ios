//
//  MainView.m
//
// Copyright © 2016 Tokbox, Inc. All rights reserved.
//

#import "OTOneToOneCommunicationView.h"
#import "UIView+Helper.h"

#import "OTAcceleratorCoreBundle.h"

@interface OTOneToOneCommunicationView()
@property (weak, nonatomic) IBOutlet UIView *publisherView;
@property (weak, nonatomic) IBOutlet UIView *subscriberView;

// 3 action buttons at the bottom of the view
@property (weak, nonatomic) IBOutlet UIButton *publisherVideoButton;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIButton *publisherAudioButton;

@property (weak, nonatomic) IBOutlet UIButton *reverseCameraButton;

@property (weak, nonatomic) IBOutlet UIButton *subscriberVideoButton;
@property (weak, nonatomic) IBOutlet UIButton *subscriberAudioButton;

@end

@implementation OTOneToOneCommunicationView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.publisherView.hidden = YES;
    self.publisherView.alpha = 1;
    self.publisherView.layer.borderWidth = 1;
    self.publisherView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.publisherView.layer.backgroundColor = [UIColor grayColor].CGColor;
    self.publisherView.layer.cornerRadius = 3;
    
    [self drawBorderOn:self.publisherAudioButton withWhiteBorder:YES];
    [self drawBorderOn:self.callButton withWhiteBorder:NO];
    [self drawBorderOn:self.publisherVideoButton withWhiteBorder:YES];
    [self showSubscriberControls:NO];
}

- (void)drawBorderOn:(UIView *)view
     withWhiteBorder:(BOOL)withWhiteBorder {
    
    view.layer.cornerRadius = (view.bounds.size.width / 2);
    if (withWhiteBorder) {
        view.layer.borderWidth = 1;
        view.layer.borderColor = [UIColor whiteColor].CGColor;
    }
}

#pragma mark - publisher view
- (void)addPublisherView:(UIView *)publisherView {
    
    [self.publisherView setHidden:NO];
    [self.publisherView addSubview:publisherView];
    publisherView.translatesAutoresizingMaskIntoConstraints = NO;
    [publisherView addAttachedLayoutConstantsToSuperview];
}

- (void)removePublisherView {
    [self.publisherView setHidden:YES];
    [self.publisherView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)connectCallHolder:(BOOL)connected {
    [self.callButton setImage:connected ? [UIImage imageNamed:@"hangUp" inBundle:[OTAcceleratorCoreBundle acceleratorCoreBundle] compatibleWithTraitCollection: nil] : [UIImage imageNamed:@"startCall" inBundle:[OTAcceleratorCoreBundle acceleratorCoreBundle] compatibleWithTraitCollection: nil]  forState:UIControlStateNormal];
    self.callButton.layer.backgroundColor = connected ? [UIColor colorWithRed:(205/255.0) green:(32/255.0) blue:(40/255.0) alpha:1.0].CGColor : [UIColor colorWithRed:(106/255.0) green:(173/255.0) blue:(191/255.0) alpha:1.0].CGColor;
}
- (void)updatePublisherAudio:(BOOL)connected {
    [self.publisherAudioButton setImage:connected ? [UIImage imageNamed:@"mic" inBundle:[OTAcceleratorCoreBundle acceleratorCoreBundle] compatibleWithTraitCollection: nil] : [UIImage imageNamed:@"mutedMic" inBundle:[OTAcceleratorCoreBundle acceleratorCoreBundle] compatibleWithTraitCollection: nil] forState:UIControlStateNormal];
}

- (void)updatePublisherVideo:(BOOL)connected {
    [self.publisherVideoButton setImage:connected ? [UIImage imageNamed:@"video" inBundle:[OTAcceleratorCoreBundle acceleratorCoreBundle] compatibleWithTraitCollection: nil] : [UIImage imageNamed:@"noVideo" inBundle:[OTAcceleratorCoreBundle acceleratorCoreBundle] compatibleWithTraitCollection: nil] forState:UIControlStateNormal];
}

#pragma mark - subscriber view
- (void)addSubscribeView:(UIView *)subscriberView {
    [self.subscriberView addSubview:subscriberView];
    subscriberView.translatesAutoresizingMaskIntoConstraints = NO;
    [subscriberView addAttachedLayoutConstantsToSuperview];
}

- (void)removeSubscriberView {
    [self.subscriberView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)updateSubscriberAudioButton:(BOOL)connected {
    [self.subscriberAudioButton setImage:connected ? [UIImage imageNamed:@"audio" inBundle:[OTAcceleratorCoreBundle acceleratorCoreBundle] compatibleWithTraitCollection: nil] : [UIImage imageNamed:@"noAudio" inBundle:[OTAcceleratorCoreBundle acceleratorCoreBundle] compatibleWithTraitCollection: nil] forState:UIControlStateNormal];
}

- (void)updateSubscriberVideoButton:(BOOL)connected {
    [self.subscriberVideoButton setImage:connected ? [UIImage imageNamed:@"video" inBundle:[OTAcceleratorCoreBundle acceleratorCoreBundle] compatibleWithTraitCollection: nil] : [UIImage imageNamed:@"noVideo" inBundle:[OTAcceleratorCoreBundle acceleratorCoreBundle] compatibleWithTraitCollection: nil] forState:UIControlStateNormal];
}

- (void)showSubscriberControls:(BOOL)shown {
    [self.subscriberAudioButton setHidden:!shown];
    [self.subscriberVideoButton setHidden:!shown];
}

#pragma mark - other controls
- (void)enableControlButtonsForCall:(BOOL)enabled {
    [self.subscriberAudioButton setEnabled:enabled];
    [self.subscriberVideoButton setEnabled:enabled];
    [self.publisherVideoButton setEnabled:enabled];
    [self.publisherAudioButton setEnabled:enabled];
}

- (void)showReverseCameraButton; {
    self.reverseCameraButton.hidden = NO;
}

- (void)resetAllControl {
    [self removePublisherView];
    [self connectCallHolder:NO];
    [self updatePublisherAudio:YES];
    [self updatePublisherVideo:YES];
    [self updateSubscriberAudioButton:YES];
    [self updateSubscriberVideoButton:YES];
    [self enableControlButtonsForCall:NO];
}

@end
