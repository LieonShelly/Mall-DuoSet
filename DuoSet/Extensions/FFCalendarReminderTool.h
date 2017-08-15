//
//  FFCalendarReminderTool.h
//  DuoSet
//
//  Created by fanfans on 2017/5/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

typedef void (^STCalendarReminderToolSaveSuccessBlock)(NSString* eventIdentifier);
typedef void (^STCalendarReminderToolSaveFailBlock)(NSError *err);

@interface FFCalendarReminderTool : NSObject

+(void)saveEventWithTitle:(NSString *)title
                    notes:(NSString *)notes
                 location:(NSString *)location
                startDate:(NSDate *)startDate
                  endDate:(NSDate *)endDate
                   alarms:(NSArray*)alarms
                      URL:(NSURL *)URL
             availability:(EKEventAvailability)availability
             successBlock:(STCalendarReminderToolSaveSuccessBlock)successBlock
                failBlock:(STCalendarReminderToolSaveFailBlock)failBlock;

+(EKCalendarItem *)fetchReminderWithIdentier:(NSString *)identifer;

+(BOOL)deleteReminderWithIdentifer:(NSString *)identifier;

@end
