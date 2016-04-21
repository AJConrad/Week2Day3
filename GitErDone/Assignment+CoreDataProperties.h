//
//  Assignment+CoreDataProperties.h
//  GitErDone
//
//  Created by Andrew Conrad on 4/20/16.
//  Copyright © 2016 AndrewConrad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Assignment.h"

NS_ASSUME_NONNULL_BEGIN

@interface Assignment (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *assignmentDescription;
@property (nullable, nonatomic, retain) NSDate *assignmentDueDate;
@property (nullable, nonatomic, retain) NSString *assignmentName;
@property (nullable, nonatomic, retain) NSNumber *assignmentPriority;
@property (nullable, nonatomic, retain) NSDate *assignmentCompleteDate;
@property (nullable, nonatomic, retain) NSNumber *assignmentComplete;

@end

NS_ASSUME_NONNULL_END
