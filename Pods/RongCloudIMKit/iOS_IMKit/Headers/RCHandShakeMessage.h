//
//  RCHandShakeMessage.h
//  iOS-IMKit
//
//  Created by Heq.Shinoda on 14-6-30.
//  Copyright (c) 2014年 Heq.Shinoda. All rights reserved.
//

#import "RCMessageContent.h"

#define RCHandShakeMessageTypeIdentifier @"RC:HsMsg"

@interface RCHandShakeMessage : RCMessageContent<RCMessageCoding,RCMessagePersistentCompatible>
@property(nonatomic, assign) int type;

-(RCHandShakeMessage*)initWithType:(int)aType;

@end
