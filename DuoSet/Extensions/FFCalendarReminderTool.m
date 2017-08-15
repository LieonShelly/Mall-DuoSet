//
//  FFCalendarReminderTool.m
//  DuoSet
//
//  Created by fanfans on 2017/5/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "FFCalendarReminderTool.h"

@implementation FFCalendarReminderTool

/** 向日历添加一个事件
 * title  事件标题
 * notes  事件备注
 * location 事件地址
 * startDate 开始日期
 * endDate  结束日期
 * alarms 闹钟
 * availability 事件调度
 */

+(void)saveEventWithTitle:(NSString *)title
                    notes:(NSString *)notes
                 location:(NSString *)location
                startDate:(NSDate *)startDate
                  endDate:(NSDate *)endDate
                   alarms:(NSArray*)alarms
                      URL:(NSURL *)URL
             availability:(EKEventAvailability)availability
             successBlock:(STCalendarReminderToolSaveSuccessBlock)successBlock
                failBlock:(STCalendarReminderToolSaveFailBlock)failBlock{
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
         dispatch_async(dispatch_get_main_queue(), ^{
             if (error) {
                 //错误信息
                 return;
             }
             if (!granted) {
                 //被用户拒绝，不允许访问日历
                 return;
             }
             EKEvent *event = [EKEvent eventWithEventStore:store];
             event.title = title;
             event.notes = notes;
             event.availability = availability;
             event.startDate = startDate;
             event.endDate = endDate;
             event.location  = location;
             event.alarms = alarms;
             event.calendar = store.defaultCalendarForNewEvents;
             event.URL = URL;
             NSError *err = nil;
             [store saveEvent:event span:EKSpanThisEvent error:&err];
             if (!err) {
                 if (successBlock) {
                     successBlock(event.eventIdentifier);
                 }
             }else{
                 if (failBlock) {
                     NSLog(@"err:%@",err.description);
                     failBlock(err);
                 }
             }
             NSLog(@"eventIdentifier %@",event.eventIdentifier);
         });
     }];
}

//使用唯一标示查询提醒
+(EKCalendarItem *)fetchReminderWithIdentier:(NSString *)identifer{
    EKEventStore *store = [[EKEventStore alloc] init];
    EKCalendarItem *item = [store calendarItemWithIdentifier:identifer];
    return item;
}

+(BOOL)deleteReminderWithIdentifer:(NSString *)identifier{
    EKEventStore *store = [[EKEventStore alloc] init];
    return [store removeEvent:[store eventWithIdentifier:identifier] span:EKSpanThisEvent commit:true error:nil];
//    EKCalendarItem *item = [store calendarItemWithIdentifier:identifier];
//    EKReminder *reminder = (EKReminder *)item;
//    return  [store removeReminder:reminder commit:YES error:nil];
}

@end
