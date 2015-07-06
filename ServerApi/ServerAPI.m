//
//  SIPServerAPI.m
//  @home
//
//  Created by Black N Green on 26/12/13.
//  Copyright (c) 2014 Black N Green. All rights reserved.
//

#import "ServerAPI.h"
#import "UserProfile.h"
#import "Util.h"
#import "ASIHTTPRequest.h"
#import "ServerResponse.h"
#import "XMLReader.h"
#import "NSData+Base64.h"
#import "UserProfile.h"

@implementation ServerAPI


-(ServerResponse*)sendContactBook :(NSString*)msidn dictionary:(NSString*)data
{
    NSString *string =@"contactlist";
    NSURL *URL = [self getServerUrlForOperation:string];
    
    UserProfile* userProfile = [Util retriveObjectFromUserDefaultForKey:@"UserID"];
    
    
    NSString* jsonString=[NSString stringWithFormat:@"{\"mobile_no\":\"%@\",\"json_contact\":\%@}",userProfile.Msisdn,data];
    
    
    
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    return serverResponse;
}

- (NSURL *)getServerUrlForLocationUpdate:(NSString *)operation
{
    
    
    NSString*url=[[[NSUserDefaults standardUserDefaults] objectForKey:@"responseDic"]  objectForKey:@"operator_server"];
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,operation]];
}

- (NSURL *)getServerUrlForOperation:(NSString *)operation
{
   
    
    NSString*url=[[[NSUserDefaults standardUserDefaults] objectForKey:@"responseDic"]  objectForKey:@"operator_server"];
    
	return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,operation]];
}
//- (NSURL *)getServerUrlForOperation:(NSString *)operation
//{
//	return [NSURL URLWithString:[NSString stringWithFormat:@"https://111.93.115.216/AThome/homeapi.php?rquest=register"]];
//}
//- (NSURL *)getServerUrlForSIPOperation:(NSString *)operation
//{
//	return [NSURL URLWithString:[NSString stringWithFormat:@"http://athome.elasticbeanstalk.com/api/%@", operation]];
//}


//- (NSURL *)getServerUrlForSIPOperation:(NSString *)operation
//{
//	return [NSURL URLWithString:[NSString stringWithFormat:@"http://athome.elasticbeanstalk.com/api/%@", operation]];
//}

- (NSURL *)getServerUrlForResend:(NSString *)operation
{
       NSString*url=[[[NSUserDefaults standardUserDefaults] objectForKey:@"responseDic"] objectForKey:@"operator_server"];
  return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,@"resend"]];
}

-(NSURL*)getActivationUrl:(NSString*)operation
{
    NSString*url=[[[NSUserDefaults standardUserDefaults] objectForKey:@"responseDic"] objectForKey:@"operator_server"];
   
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,@"activation"]];
    
}

- (NSURL *)getServerUrlForSIPOperation:(NSString *)operation
{
	
   NSString*url=[[[NSUserDefaults standardUserDefaults] objectForKey:@"responseDic"] objectForKey:@"operator_server"];
   
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,@"register"]];

}

- (NSURL *)getServerUrlForConfig
{

    return [NSURL URLWithString:[NSString stringWithFormat:@"http://50.116.4.70/athome/api.php?rquest=serverconfig"]];
    
}



- (NSURL *)getServerUrlForoperator
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://50.116.4.70/athome/api.php?rquest=operatorlist"]];
}

-(NSURL *)getCountryurl
{
    
   
    	return [NSURL URLWithString:[NSString stringWithFormat:@"http://50.116.4.70/athome/api.php?rquest=country"]];
}

-(ServerResponse *)getCountry
{
    NSURL *URL = [self getCountryurl];
      NSString*device=@"iphone";
    
    NSString* jsonString=[NSString stringWithFormat:@"{\"device_type\":\"%@\"}",device];
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    return serverResponse;
}

+ (ServerResponse *)postDataWithUrl:(NSURL *)url withRequestType:(NSString *)requestType  andXml:(NSString *)xml
{
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request addRequestHeader:@"username" value:@"bng"];
    [request addRequestHeader:@"password" value:@"123456"];
    [request addRequestHeader:@"device_type" value:@"iphone"];
    
   // NSLog(@"%@");
    [request setRequestMethod:requestType];
    
    NSData *myPostData = [xml dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *myMutablePostData = [NSMutableData dataWithData:myPostData];
    [request setPostBody:myMutablePostData];
    
    // [request addRequestHeader:@"Content-Type" value:@"text/xml"];
    
    NSLog(@"---- Request url : %@", url);
    NSLog(@"---- Request body: %@", xml);

    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
	[request setValidatesSecureCertificate:NO];
    [request setTimeOutSeconds:5];
	[request startSynchronous];
    
    NSLog(@"---- Response : %@", [request responseString]);

    
	ServerResponse *serverResponse = [[ServerResponse alloc] init];
	serverResponse.success = NO;
	serverResponse.errorMessage = nil;
	serverResponse.errorCode = 0;
	serverResponse.responseString = nil;
    
	if ([request responseStatusCode] == 200)
	{
		serverResponse.success = YES;
		serverResponse.responseString = request.responseString;
	}
	else
	{
		serverResponse.errorMessage = [request responseStatusMessage];
		serverResponse.errorCode = [request responseStatusCode];
	}
    
	return serverResponse;
}

/*
 Purpose:Getting the Singleton Object of the ServerAPI  class .
 */

+(ServerAPI *)sharedInstance
{
    static ServerAPI *sharedInstance;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance= [[ServerAPI alloc]init];
        
    });
    return sharedInstance;
}

-(id)init
{
    self= [super init];
    return self;
}

-(ServerResponse *)getOperatorList:(NSString*)country
{
    NSURL *URL = [self getServerUrlForoperator];
    
    NSString* jsonString=[NSString stringWithFormat:@"{\"country\":\"%@\"}",country];
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    return serverResponse;

}
-(ServerResponse *)getConfig
{
    NSURL *URL = [self getServerUrlForConfig];
    NSDictionary* dic=[Util getMncMcc];
    
    NSString* jsonString=[NSString stringWithFormat:@"{\"network_code\":\"%@\",\"country_code\":\"%@\"}",[dic objectForKey:@"mnc"],[dic objectForKey:@"mcc"]];
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    return serverResponse;
}
-(ServerResponse *)getConfigId:(NSString*)operatorId
{
    NSURL *URL = [self getServerUrlForConfig];
    
    
    
    NSString* jsonString=[NSString stringWithFormat:@"{\"operator_id\":\"%@\"}",operatorId];
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    return serverResponse;
}


-(ServerResponse *)getUserProfileForMsisdn:(NSString *)msisdn
{
    NSString *string = [NSString stringWithFormat:@"Subscription/Update?msisdn=%@",msisdn];
    NSURL *URL = [self getServerUrlForSIPOperation:string];
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"GET" andXml:nil];
    
    return serverResponse;
    
}
-(ServerResponse *) subscibeUserWithMsisdn:(NSString *)msisdn andEmail:(NSString *)email andUserName:(NSString *)name
{
    NSString *string =@"Subscription/Create";
    NSURL *URL = [self getServerUrlForSIPOperation:string];
    NSString *xmlString = [NSString stringWithFormat:@"<CreateProfileModel xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns=\"http://schemas.datacontract.org/2004/07/Platform.Api.Models\"><Email>%@</Email><Msisdn>%@</Msisdn><Name>%@</Name></CreateProfileModel>",email,msisdn,name];
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:xmlString];
    
    return serverResponse;
    
}
-(ServerResponse*)reSendVerificationCodeToMsisidn:(NSString *)msisdn withCode:(NSString*)code
{
    NSString *string =@"Message/resend";
    NSURL *URL = [self getServerUrlForResend:string];
    
    //NSString *xmlString = [NSString stringWithFormat:@"<VerificationMessageModel xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns=\"http://schemas.datacontract.org/2004/07/Platform.Api.Models\"><Code>%d</Code><To>%@</To></VerificationMessageModel>",code,msisdn];
    
    NSString* deviceId=[Util getDeviceToken];
    NSString* jsonString=[NSString stringWithFormat:@"{\"mobile_no\":\"%@\",\"device_id\":\"%@\",\"country_calling_code\":\"%@\"}",msisdn,deviceId,code];
    
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    
    return serverResponse;
}
-(ServerResponse *)getverificationCodeActivatipon:(NSString *)enterCode
{
    NSString *string =@"Message/activation";
    NSURL *URL = [self getActivationUrl:string];
    
     UserProfile* userProfile = [Util retriveObjectFromUserDefaultForKey:@"UserID"];
    //mobile_no
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

       NSString* deviceId=[Util getDeviceToken];
    NSString* jsonString=[NSString stringWithFormat:@"{\"device_id\":\"%@\",\"activation_code\":\"%@\",\"mobile_no\":\"%@\",\"device_type\":\"%@\",\"app_version\":\"%@\"}",deviceId,enterCode,userProfile.Msisdn,@"iphone",version];
    
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    return serverResponse;

    
}
-(ServerResponse *)sendVerificationCodeToMsisidn:(NSString *)msisdn withCode:(NSString*)code withCountry:(NSString*)country
{
    NSString *string =@"Message/Verify";
    NSURL *URL = [self getServerUrlForSIPOperation:string];
    // sagar for sample demo changes 8 april 2015
    
    NSString* deviceId=[Util getDeviceToken];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSString* jsonString=[NSString stringWithFormat:@"{\"mobile_no\":\"%@\",\"device_id\":\"%@\",\"country_calling_code\":\"%@\",\"devicename\":\"%@\",\"country_name\":\"%@\",\"app_version\":\"%@\"}",msisdn,deviceId,code,[[UIDevice currentDevice] name],country,version];
    
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    return serverResponse;
}


-(ServerResponse *)sendMessagetoMsisdn:(NSString *)toMsisdn andMessageText:(NSString *)text
{
    NSString *string =@"Message/Send";
    NSURL *URL = [self getServerUrlForSIPOperation:string];
    NSString *xmlString = [NSString stringWithFormat:@"<MessageModel xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns=\"http://schemas.datacontract.org/2004/07/Platform.Api.Models\"><Text>%@</Text><To>%@</To></MessageModel>",text,toMsisdn];
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:xmlString];
    return serverResponse;
    
}
-(ServerResponse *)postProfilePictureForMsisdn:(NSString *)msisdn withImage:(NSData *)base64Data
{
    NSString *string =@"Profile/Photo";
    NSString *base64String = [base64Data base64EncodedString];
    NSURL *URL = [self getServerUrlForSIPOperation:string];
    NSString *xmlString = [NSString stringWithFormat:@"<ProfilePhotoModel xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns=\"http://schemas.datacontract.org/2004/07/Platform.Api.Models\"><Base64ProfilePhoto>%@</Base64ProfilePhoto><Msisdn>%@</Msisdn></ProfilePhotoModel>",base64String,msisdn];
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:xmlString];
    return serverResponse;
}

-(void)unscribeUser:(NSString *)Msisdn
{
   
}

/*
 Purpose:Used to getting the msisdn that has sent the guid code to the server
 */

-(NSString *)getMsisdnForGuid:(NSString *)guid
{
    NSString* msisdn = Nil;
    
    NSString *url=[NSString stringWithFormat:@"Msisdn/%@",guid];
    NSURL *URL = [self getServerUrlForOperation:url];
    
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"GET" andXml:nil];
    NSDictionary *dicRoot = [XMLReader dictionaryForXMLString:serverResponse.responseString error:nil];
    if ([[dicRoot objectForKey:@"string"] isKindOfClass:[NSMutableDictionary class]] == YES) {
        NSMutableDictionary *d = [dicRoot objectForKey:@"string"];
        
        msisdn = [d objectForKey:@"text"];
    }
    return msisdn;
}


-(ServerResponse *)getBalanceAndPackInfo
{
    NSString *string =@"getpack";
    NSURL *URL = [self getServerUrlForOperation:string];
    NSString* deviceId=[Util getDeviceToken];
    UserProfile* userProfile = [Util retriveObjectFromUserDefaultForKey:@"UserID"];
    NSString* jsonString=[NSString stringWithFormat:@"{\"mobile_no\":\"%@\",\"device_id\":\"%@\"}",userProfile.Msisdn,deviceId];
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    return serverResponse;
}

//locationupdate

-(ServerResponse *)locationupdate:(NSString *)IP
{
    // NSString *string =@"terms";
    NSURL *URL =[self getServerUrlForLocationUpdate:@"locationupdate"];
        UserProfile* userProfile = [Util retriveObjectFromUserDefaultForKey:@"UserID"];
   
    
    NSString* jsonString=[NSString stringWithFormat:@"{\"mobile_no\":\"%@\",\"ip\":\"%@\"}",userProfile.Msisdn,IP];
    
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    
    
    return serverResponse;
    
}
//bi

-(ServerResponse *)termsAndCondition
{
   // NSString *string =@"terms";
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://50.116.4.70/athome/api.php?rquest=terms"]];
    
    NSDictionary* dic=[Util getMncMcc];
    
    NSString* jsonString=[NSString stringWithFormat:@"{\"network_code\":\"%@\",\"country_code\":\"%@\",\"operator_id\":\"%@\"}",[dic objectForKey:@"mnc"],[dic objectForKey:@"mcc"],[[NSUserDefaults standardUserDefaults] objectForKey:@"opID"]];
 
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    
  
    return serverResponse;

}
//billingdetails


-(ServerResponse *)billingdetailsDiscriptionDetail :(NSString *)idt
{
//resion&i_log_id=293
    
  
    NSURL *URL = [self getServerUrlForOperation:idt];
    
    
    UserProfile* userProfile = [Util retriveObjectFromUserDefaultForKey:@"UserID"];
    NSString* jsonString=[NSString stringWithFormat:@"{\"mobile_no\":\"%@\"}",userProfile.Msisdn];
    
    
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    
    NSLog(@"sdfwdfasasss %@",serverResponse);
    return serverResponse;
   
}

-(ServerResponse *)billingdetailsDiscription{
    NSString *string =@"billingdetails";
    NSURL *URL = [self getServerUrlForOperation:string];
    
    
    UserProfile* userProfile = [Util retriveObjectFromUserDefaultForKey:@"UserID"];
    NSString* jsonString=[NSString stringWithFormat:@"{\"mobile_no\":\"%@\"}",userProfile.Msisdn];

   
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    
    NSLog(@"sdfwdfasasss %@",serverResponse);
    return serverResponse;
}
-(ServerResponse *)PackIdDiscription:(NSString*)packid{
    NSString *string =@"packdiscription";
    NSURL *URL = [self getServerUrlForOperation:string];
   
    NSString* jsonString=[NSString stringWithFormat:@"{\"pack_id\":\"%@\"}",packid];
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    
    NSLog(@"sdfwdfasasss %@",serverResponse);
    return serverResponse;
}

-(ServerResponse *)buyCreditWithPackId:(NSString*)packid status:(NSString *)status
{
    NSString *string =@"buycredit";
    NSURL *URL = [self getServerUrlForOperation:string];
    NSString* deviceId=[Util getDeviceToken];
    UserProfile* userProfile = [Util retriveObjectFromUserDefaultForKey:@"UserID"];
    NSString* jsonString=[NSString stringWithFormat:@"{\"mobile_no\":\"%@\",\"device_id\":\"%@\",\"pack_id\":\"%@\" ,\"buy_pack_status\":\"%@\"}",userProfile.Msisdn,deviceId,packid,status];
    
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    return serverResponse;
}

-(ServerResponse*)registerPuahNotificationWithDeviceToken:(NSString *)deviceToken
{
    NSString *string =@"push";
    UserProfile* userProfile = [Util retriveObjectFromUserDefaultForKey:@"UserID"];
    NSString* mobileNumber=userProfile.Msisdn?userProfile.Msisdn:@"";
    NSString* deviceId=[Util getDeviceToken];
    NSString* jsonString=[NSString stringWithFormat:@"{\"mobile_no\":\"%@\",\"device_id\":\"%@\",\"key\":\"%@\"}",mobileNumber,deviceId,deviceToken];
    
    NSURL *URL = [self getServerUrlForOperation:string];
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    return serverResponse;
}


-(ServerResponse *)removeDevice
{
    NSString *string =@"removedevice";
    NSURL *URL = [self getServerUrlForOperation:string];
    NSString* deviceId=[Util getDeviceToken];
    UserProfile* userProfile = [Util retriveObjectFromUserDefaultForKey:@"UserID"];
    NSString* jsonString=[NSString stringWithFormat:@"{\"mobile_no\":\"%@\",\"device_id\":\"%@\"}",userProfile.Msisdn,deviceId];
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    return serverResponse;
}

-(ServerResponse *)changeDeviceStatus:(int)status
{
    NSString *string =@"removedevice";
    NSURL *URL = [self getServerUrlForOperation:string];
    NSString* deviceId=[Util getDeviceToken];
    UserProfile* userProfile = [Util retriveObjectFromUserDefaultForKey:@"UserID"];
    NSString* jsonString=[NSString stringWithFormat:@"{\"mobile_no\":\"%@\",\"device_id\":\"%@\",\"status\":\"%d\"}",userProfile.Msisdn,deviceId,status];
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    return serverResponse;
}
-(ServerResponse*)getDeviceValidity :(NSString*)msidn status:(NSString *)token
{
    
    NSString *string =@"validuser";
    NSURL *URL = [self getServerUrlForOperation:string];
    NSString* deviceId=[Util getDeviceToken];
    UserProfile* userProfile = [Util retriveObjectFromUserDefaultForKey:@"UserID"];
    NSString* jsonString=[NSString stringWithFormat:@"{\"mobile_no\":\"%@\",\"device_id\":\"%@\"}",userProfile.Msisdn,deviceId];
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    return serverResponse;
}

-(ServerResponse *)getDeviceList
{
    NSString *string =@"listdevice";
    NSURL *URL = [self getServerUrlForOperation:string];
    UserProfile* userProfile = [Util retriveObjectFromUserDefaultForKey:@"UserID"];
    NSString* jsonString=[NSString stringWithFormat:@"{\"mobile_no\":\"%@\"}",userProfile.Msisdn];
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    return serverResponse;
}

-(ServerResponse *)setCallForwarding : (int)setOnOff
{
    NSString *string =@"callforwarding";
    NSURL *URL = [self getServerUrlForOperation:string];
    UserProfile* userProfile = [Util retriveObjectFromUserDefaultForKey:@"UserID"];
    
    NSString *code=[[NSUserDefaults standardUserDefaults] objectForKey:@"countryCodeselected"];
    code=[code stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    NSString* jsonString=[NSString stringWithFormat:@"{\"mobile_no\":\"%@\",\"calling_code\":\"%@\",\"callforwarding\":\"%d\"}",userProfile.Msisdn,code,setOnOff];
    
    
    
    
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    return serverResponse;
    
    
}
-(void)locationUpdateIp :(NSString*)ip;
{
    NSURL *URL =[self getServerUrlForLocationUpdate:@"locationupdate"];
    UserProfile* userProfile = [Util retriveObjectFromUserDefaultForKey:@"UserID"];
    
    
    NSString* jsonString=[NSString stringWithFormat:@"{\"mobile_no\":\"%@\",\"ip\":\"%@\"}",userProfile.Msisdn,ip];
    
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    
    NSLog(@" location ServerResponse :%@",serverResponse);

    
}

-(ServerResponse*)checkCallForwardingStatus
{
    NSURL *URL =[self getServerUrlForLocationUpdate:@"callforwordingstatuscheck"];
    UserProfile* userProfile = [Util retriveObjectFromUserDefaultForKey:@"UserID"];
    if (userProfile.Msisdn==nil) {
        return 0 ;
    }
    
    NSString* jsonString=[NSString stringWithFormat:@"{\"mobile_no\":\"%@\"}",userProfile.Msisdn];
    
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    
    NSLog(@"ServerResponse :%@",serverResponse);
    
    return serverResponse;
    
}


-(ServerResponse *)getMissedCall

{
    
    //NSURL *URL = [self getMissedCallUrl];
     NSURL *URL = [self getServerUrlForOperation:@"missedcalllog"];
    
    NSString* deviceId=[Util getDeviceToken];
    
    
    NSString* jsonString=[NSString stringWithFormat:@"{\"device_id\":\"%@\"}",deviceId];
    
    
    ServerResponse *serverResponse = [ServerAPI postDataWithUrl:URL withRequestType:@"POST" andXml:jsonString];
    
    return serverResponse;
    
}




@end
