//
//  SIPServerAPI.h
//  @home
//
//  Created by Black N Green on 26/12/13.
//  Copyright (c) 2014 Black N Green. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerResponse.h"

@class SIPUserProfile;
@interface ServerAPI : NSObject


+(ServerAPI *) sharedInstance;

-(NSString *) getMsisdnForGuid:(NSString *)guid;

//Implemented as of now
-(ServerResponse *)getUserProfileForMsisdn:(NSString *)msisdn;
-(ServerResponse *)subscibeUserWithMsisdn:(NSString *)msisdn andEmail:(NSString *)email andUserName:(NSString *)name;
-(ServerResponse *)sendMessagetoMsisdn:(NSString *)toMsisdn andMessageText:(NSString *)text;
-(ServerResponse *)postProfilePictureForMsisdn:(NSString *)msisdn withImage:(NSData *)base64Data;
-(ServerResponse *)sendVerificationCodeToMsisidn:(NSString *)msisdn withCode:(NSString*)code withCountry:(NSString*)country;
-(ServerResponse*)reSendVerificationCodeToMsisidn:(NSString *)msisdn withCode:(NSString*)code;
-(ServerResponse*)sendContactBook :(NSString*)msidn dictionary:(NSString*)data;

-(NSURL*)getActivationUrl:(NSString*)operation;
-(ServerResponse *)getverificationCodeActivatipon:(NSString *)enterCode;

-(void)unscribeUser:(NSString *)Msisdn;
-(ServerResponse *)getBalanceAndPackInfo;
-(ServerResponse *)buyCreditWithPackId:(NSString*)packid status:(NSString*)status;
-(ServerResponse *)PackIdDiscription:(NSString*)packid;
-(ServerResponse*)getDeviceValidity;
- (NSURL *)getServerUrlForResend:(NSString *)operation;
- (NSURL *)getServerUrlForOperation:(NSString *)operation;
-(ServerResponse *)getMissedCall;

-(ServerResponse *)getConfigId:(NSString*)operatorId;
-(ServerResponse *)billingdetailsDiscriptionDetail :(NSString *)idt;

-(ServerResponse*)registerPuahNotificationWithDeviceToken:(NSString *)deviceToken;

-(ServerResponse*)getDeviceValidity :(NSString*)msidn status:(NSString *)token;
-(ServerResponse *)billingdetailsDiscription;

-(ServerResponse *)changeDeviceStatus:(int)status;
-(ServerResponse *)removeDevice;
-(ServerResponse *)getDeviceList;
-(ServerResponse *)getConfig;
-(ServerResponse *)termsAndCondition;
-(ServerResponse *)getOperatorList:(NSString*)country;
-(ServerResponse*)webViewLoad;
-(ServerResponse *)locationupdate:(NSString *)IP;

-(ServerResponse *)getCountry;
-(ServerResponse *)setCallForwarding : (int)setOnOff;
-(void)locationUpdateIp :(NSString*)ip;

-(ServerResponse*)checkCallForwardingStatus;


@end
