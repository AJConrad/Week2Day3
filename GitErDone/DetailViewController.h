//
//  DetailViewController.h
//  GitErDone
//
//  Created by Andrew Conrad on 4/19/16.
//  Copyright © 2016 AndrewConrad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Assignment.h"
#import "Assignment+CoreDataProperties.h"

@interface DetailViewController : UIViewController

@property (nonatomic, strong)       Assignment       *currentAssignment;

@end
