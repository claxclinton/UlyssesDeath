//
//  ViewController.m
//  Hades
//
//  Created by Inderjit Singh on 14/10/2013.
//  Copyright (c) 2013 Inderjit Singh. All rights reserved.
//
//

#import "ViewController.h"
#import "Recording.h"

@interface ViewController ()

@end

@implementation ViewController

NSString* const recording[] = {@"REC 1", @"REC 2", @"REC 3_4", @"REC 5", @"REC 6", @"REC 7", @"REC 8", @"REC 9", @"REC 10", @"REC 11_1", @"REC 11_2", @"REC 12"};
NSString* const paragraph[] = {
    @"All these here once walked round Dublin. Faithful departed.",
    @"If little Rudy had lived. See him grow up. Hear his voice in the house.",
    @"Sympathetic- human man he is. Intelligent. Always a good word to say.",
    @"Tomorrow is killing day. For Liverpool probably. Roast beef for old England.",
    @"Upset. A coffin bumped out on to the road. Burst open.",
    @"Murder. They love reading about it.",
    @"Horse looking round with his plume skew-ways. Do they know what they cart out here every day?",
    @"Father …. Coffey.I knew his name was like a coffin.",
    @"Who was telling me? Mervyn Brown.",
    @"The resurrection and the life? Once you are dead you are dead.",
    @"Then every fellow mousing them around for his liver and his lights and the rest of his traps.",
    @"Who is that lankylooking galoot over there in the macintosh? Now who is he I'd like to know?"
};
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    recordings = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < 12; i++)
    {
        Recording* rec = [[Recording alloc] init];
        rec.fileName = recording[i];
        rec.paragraph = paragraph[i];
        
        [recordings addObject:rec];
    }
    
    
    currentRec = 0;
    
    [_lblPrev setText:@""];
    [_lblPlay setText:((Recording*)[recordings objectAtIndex:0]).paragraph];
    [_lblNext setText:((Recording*)[recordings objectAtIndex:1]).paragraph];
    
    [_btnPrev setEnabled:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnPrev:(id)sender
{
    if(currentRec == 0)
    {
        return;
    }
    
    currentRec--;
    
    if(currentRec == 0)
    {
        [_lblPrev setText:@""];
        [_btnPrev setEnabled:NO];
    }
    else
    {
        [_lblPrev setText:((Recording*)[recordings objectAtIndex:currentRec-1]).paragraph];
    }
    
    [_lblPlay setText:((Recording*)[recordings objectAtIndex:currentRec]).paragraph];
    [_lblNext setText:((Recording*)[recordings objectAtIndex:currentRec+1]).paragraph];
    
    if(currentRec == 10)
    {
        [_btnNext setEnabled:YES];
    }
}

-(IBAction)btnNext:(id)sender
{
    if(currentRec == 11)
    {
        return;
    }
    
    currentRec++;
    
    if(currentRec == 1)
    {
        [_btnPrev setEnabled:YES];
    }
    
    [_lblPrev setText:((Recording*)[recordings objectAtIndex:currentRec-1]).paragraph];
    [_lblPlay setText:((Recording*)[recordings objectAtIndex:currentRec]).paragraph];
    
    if(currentRec == 11)
    {
        [_lblNext setText:@""];
        [_btnNext setEnabled:NO];
    }
    else
    {
        [_lblNext setText:((Recording*)[recordings objectAtIndex:currentRec+1]).paragraph];
    }
}

-(IBAction)btnPlay:(id)sender
{
    Recording* rec = [recordings objectAtIndex:currentRec];
    
    NSError *error;
    NSString *path = [[NSBundle mainBundle]
                      pathForResource:rec.fileName ofType:@"mp3"];
    NSURL *soundURL = [NSURL fileURLWithPath:path];
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
    [player setDelegate:self];
    
    [player play];
    
    [self disableAllbuttons];
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self btnNext:self];
    [self enableButtons];
}

-(void) disableAllbuttons
{
    [_btnPrev setEnabled:NO];
    [_btnPlay setEnabled:NO];
    [_btnNext setEnabled:NO];
}

-(void) enableButtons
{
    [_btnPrev setEnabled:YES];
    [_btnPlay setEnabled:YES];
    
    if(currentRec < 11)
    {
        [_btnNext setEnabled:YES];
    }
}

@end
