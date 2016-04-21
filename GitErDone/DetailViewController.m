//
//  DetailViewController.m
//  GitErDone
//
//  Created by Andrew Conrad on 4/19/16.
//  Copyright © 2016 AndrewConrad. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController ()

@property (nonatomic, strong)                   AppDelegate             *appDelegate;
@property (nonatomic, strong)                   NSManagedObjectContext  *managedObjectContext;
@property (nonatomic, weak)         IBOutlet    UITextField             *assignmentNameField;
@property (nonatomic, weak)         IBOutlet    UISegmentedControl      *assignmentPrioritySegment;
@property (nonatomic, weak)         IBOutlet    UITextView              *assignmentDescriptionView;
@property (nonatomic, weak)         IBOutlet    UIDatePicker            *assignmentDueDatePicker;
@property (nonatomic, weak)         IBOutlet    UILabel                 *assignmentCompleteDateDisplay;
@property (nonatomic, weak)         IBOutlet    UISwitch                *assignmentCompleteSwitch;
@property (nonatomic, weak)         IBOutlet    UILabel                 *completionPrompt;


@end

@implementation DetailViewController

#pragma mark - Interactivity Methods

- (IBAction)completeButton:(UISwitch *)sender {
    [self completePrompt];
}

- (IBAction)saveButtonPressed:(id)sender {
    _currentAssignment.assignmentPriority = [NSNumber numberWithInteger:_assignmentPrioritySegment.selectedSegmentIndex];
    _currentAssignment.assignmentDescription = _assignmentDescriptionView.text;
    _currentAssignment.assignmentName = _assignmentNameField.text;
    _currentAssignment.assignmentDueDate = _assignmentDueDatePicker.date;
    [self saveAndPop];
}

- (IBAction)deleteButton:(id)sender {
    [_managedObjectContext deleteObject:_currentAssignment];
    [self saveAndPop];
}

#pragma mark - Called Methods

- (void)saveAndPop {
    [_appDelegate saveContext];
    [self.navigationController popViewControllerAnimated:true];
}

- (void)completePrompt {
    if (_assignmentCompleteSwitch.isOn) {
        _currentAssignment.assignmentCompleteDate = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"MM/dd/yyyy";
        NSString *dateDisplay = [dateFormatter stringFromDate:_currentAssignment.assignmentCompleteDate];
        _assignmentCompleteDateDisplay.text = dateDisplay;
        _completionPrompt.text = @"Complete!";
        _currentAssignment.assignmentComplete = @true;
    } else {
        _currentAssignment.assignmentCompleteDate = nil;
        _assignmentCompleteDateDisplay.text = @"";
        _currentAssignment.assignmentComplete = @false;
        _completionPrompt.text = @"Is it complete?";
    }
}

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (_currentAssignment == nil) {
        Assignment *newAssignment = (Assignment *)[NSEntityDescription insertNewObjectForEntityForName:@"Assignment" inManagedObjectContext:(_managedObjectContext)];
        _currentAssignment = newAssignment;
        _assignmentNameField.text = @"";
        _assignmentDescriptionView.text = @"";
        _assignmentDueDatePicker.date = [NSDate date];
        [self completePrompt];
    
    } else {
        _assignmentNameField.text = _currentAssignment.assignmentName;
        _assignmentDescriptionView.text = _currentAssignment.assignmentDescription;
        _assignmentDueDatePicker.date = _currentAssignment.assignmentDueDate;
        [_assignmentPrioritySegment setSelectedSegmentIndex:[_currentAssignment.assignmentPriority integerValue]];
        [_assignmentCompleteSwitch setOn:[_currentAssignment.assignmentComplete boolValue]];
        [self completePrompt];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
