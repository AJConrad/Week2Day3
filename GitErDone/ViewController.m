//
//  ViewController.m
//  GitErDone
//
//  Created by Andrew Conrad on 4/19/16.
//  Copyright © 2016 AndrewConrad. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Assignment.h"
#import "DetailViewController.h"

@interface ViewController ()

@property (nonatomic, strong)   NSManagedObjectContext      *managedObjectContext;
@property (nonatomic, strong)   AppDelegate                 *appDelegate;
@property (nonatomic, strong)   NSArray                     *assignmentsArray;
@property (nonatomic, weak)     IBOutlet UITableView        *assignmentsTable;

@end

@implementation ViewController

#pragma mark - Fetch Method

- (NSArray *)fetchAssignments {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Assignment" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"assignmentDueDate" ascending:true];
    [fetchRequest setSortDescriptors:@[sortDescriptor1]];
    NSError *error;
    NSArray *fetchResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return fetchResults;
    
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _assignmentsArray.count;
}



- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *iCell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Assignment *currentAssignment = _assignmentsArray[indexPath.row];
    iCell.textLabel.text =  [currentAssignment assignmentName];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMMM d, yyyy";
    iCell.detailTextLabel.text = [formatter stringFromDate:currentAssignment.assignmentDueDate];
    
//
//SHOULD ADD
//Delete Function via swiping, remember to add the refresh stuff from view did load to the table section while doing so
//color change based on priority
//
    
    return iCell;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *destController = [segue destinationViewController];
    
    if ([[segue identifier] isEqualToString:@"editAssignmentSegue"]) {
        NSIndexPath *indexPath = [_assignmentsTable indexPathForSelectedRow];
        Assignment *selectedAssignment = _assignmentsArray [indexPath.row];
        destController.currentAssignment = selectedAssignment;
    } else if ([[segue identifier] isEqualToString:@"addAssignmentSegue"]) {
        destController.currentAssignment = nil;
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
    _assignmentsArray = [self fetchAssignments];
    [_assignmentsTable reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
