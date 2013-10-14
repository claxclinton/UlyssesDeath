//
//  ViewController.h
//  Hades
//
//  Created by Inderjit Singh on 14/10/2013.
//  Copyright (c) 2013 Inderjit Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <AVAudioPlayerDelegate>
{
    NSMutableArray* recordings;
    int currentRec;
    
    AVAudioPlayer *player;
}

@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UILabel *lblPlay;

@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UILabel *lblNext;

@property (weak, nonatomic) IBOutlet UIButton *btnPrev;
@property (weak, nonatomic) IBOutlet UILabel *lblPrev;


@end
