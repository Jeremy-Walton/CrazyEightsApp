//
//  JPWWebClient.m
//  CrazyEightsApp
//
//  Created by Jeremy on 3/24/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import "JPWWebClient.h"

#define JPWResponseTokenKey @"token"

JPWWebClient *_sharedClient;

@interface JPWWebClient()
@property (nonatomic, strong) NSURL *baseURL;
@end

@implementation JPWWebClient

+ (instancetype)sharedClient {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [self new];
        _sharedClient.baseURL = [NSURL URLWithString:@"http://localhost:3000"];
    });
    return _sharedClient;
}

-(NSNumber *)loginWithEmail:(NSString *)email andPassword:(NSString *)password {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.HTTPMethod = @"POST";
    request.URL = [NSURL URLWithString:@"users/token" relativeToURL:self.baseURL];
    
    NSData *authData = [[NSString stringWithFormat:@"%@:%@", email, password] dataUsingEncoding:NSASCIIStringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength]];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    NSError *error;
    NSHTTPURLResponse *responseCode;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if (error) {
        NSLog(@"%@", error);
    }
    
    NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:oResponseData options:kNilOptions error:&error];
    
    self.token = responseData[JPWResponseTokenKey];
    
    if (responseCode.statusCode != 200){
        NSLog(@"Error getting %@, HTTP status code %li", @"localhost:3000/users/sign_in", (long)[responseCode statusCode]);
    } else {
        NSLog(@"%@", responseData);
    }
    return @(responseCode.statusCode == 200);
}

@end
