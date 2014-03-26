//
//  JPWWebClient.m
//  CrazyEightsApp
//
//  Created by Jeremy on 3/24/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import "JPWWebClient.h"
#import "JPWGame.h"

#define JPWResponseTokenKey @"token"
#define JPWResponseIdKey @"id"

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
    [self setUsernameAuthorization:email password:password onRequest:request];
    
    NSError *error;
    NSHTTPURLResponse *responseCode;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if (error) {
        NSLog(@"%@", error);
    }
    
    NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:oResponseData options:kNilOptions error:&error];
    
    self.token = responseData[JPWResponseTokenKey];
    self.userID = responseData[JPWResponseIdKey];
    
    if (responseCode.statusCode != 200){
        NSLog(@"Error getting %@, HTTP status code %li", @"localhost:3000/users/sign_in", (long)[responseCode statusCode]);
    } else {
        NSLog(@"%@", responseData);
    }
    return @(responseCode.statusCode == 200);
}

- (void)setUsernameAuthorization:(NSString *)username password:(NSString *)password onRequest:(NSMutableURLRequest *)request {
    NSData *authData = [[NSString stringWithFormat:@"%@:%@", username, password] dataUsingEncoding:NSASCIIStringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength]];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
}

// use beter name for below method
-(JPWGame *)initializeServerWithNumberOfPlayers:(NSNumber *)numberOfPlayers andNumberOfRobots:(NSNumber *)numberOfRobots {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.HTTPMethod = @"POST";
    request.URL = [NSURL URLWithString:@"crazy_eights" relativeToURL:self.baseURL];
    request.HTTPBody = [[NSString stringWithFormat:@"number_of_players=%@&number_of_robots=%@&game=%@", numberOfPlayers, numberOfRobots, @""] dataUsingEncoding:NSUTF8StringEncoding];
//    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:@{@"number_of_players": numberOfPlayers, @"number_of_robots": numberOfRobots, @"game": @""} options:0 error:NULL];
    [self setUsernameAuthorization:[self.userID description] password:self.token onRequest:request];
    
    NSError *error;
    NSHTTPURLResponse *responseCode;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:oResponseData options:kNilOptions error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", @"localhost:3000/crazy_eights", (long)[responseCode statusCode]);
    } else {
        NSLog(@"%@", responseData);
    }
    return [JPWGame newWithID:responseData[@"game"][@"id"]];
}
// use better name for below method
-(JPWGame *)joinGame:(NSNumber *)gameID {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.HTTPMethod = @"PUT";
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"crazy_eights/%@", gameID] relativeToURL:self.baseURL];
    
    [self setUsernameAuthorization:[self.userID description] password:self.token onRequest:request];
    
    NSError *error;
    NSHTTPURLResponse *responseCode;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:oResponseData options:kNilOptions error:&error];
    
    JPWGame *game = [JPWGame newWithID:gameID];
    NSMutableArray *arrayOfUserNames = [[NSMutableArray alloc] init];
    for (NSDictionary *userJSON in json[@"game"][@"users"]) {
        [arrayOfUserNames addObject:userJSON[@"email"]];
    }
    [game setPlayersWithNames:arrayOfUserNames];
    
    if ([json[@"game"][@"start_game"] boolValue]) {
        [game startupGame];
    }
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", @"localhost:3000/crazy_eights", (long)[responseCode statusCode]);
    } else {
        NSLog(@"%@", oResponseData);
    }
    return game;
}

-(NSNumber *)sendGameToServer:(NSString *)game withID:(NSNumber *)gameID {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.HTTPMethod = @"POST";
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"crazy_eights/%@/turn", gameID] relativeToURL:self.baseURL];
    request.HTTPBody = [[NSString stringWithFormat:@"game=%@", game] dataUsingEncoding:NSUTF8StringEncoding];
    
    [self setUsernameAuthorization:[self.userID description] password:self.token onRequest:request];
    
    NSError *error;
    NSHTTPURLResponse *responseCode;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:oResponseData options:kNilOptions error:&error];
    
   
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", @"localhost:3000/crazy_eights", (long)[responseCode statusCode]);
    } else {
        NSLog(@"%@", oResponseData);
    }
    return json[@"game"][@"id"];
}

-(JPWGame *)retrieveGameFromServer:(NSNumber *)gameID {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.HTTPMethod = @"GET";
    request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"crazy_eights/%@", gameID] relativeToURL:self.baseURL];
//    request.HTTPBody = [[NSString stringWithFormat:@"game=%@", game] dataUsingEncoding:NSUTF8StringEncoding];
    
    [self setUsernameAuthorization:[self.userID description] password:self.token onRequest:request];
    
    NSError *error;
    NSHTTPURLResponse *responseCode;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:oResponseData options:kNilOptions error:&error];
    
//    NSLog(@"%@", json[@"game"][@"data"]);
    JPWGame *game = [self convertFromJson:json[@"game"][@"data"] withID:gameID];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", @"localhost:3000/crazy_eights", (long)[responseCode statusCode]);
    } else {
        NSLog(@"%@", oResponseData);
    }
    return game;
}

-(JPWGame *)convertFromJson:(NSString *)jsonGame withID:gameID {
    NSError *error = nil;
    NSData *jsonData = [jsonGame dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    JPWGame *game = [JPWGame newWithID:gameID];
    [game fromNSDictionary:json];
    return game;
}




@end
