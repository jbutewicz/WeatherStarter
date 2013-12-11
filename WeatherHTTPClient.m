//
//  WeatherHTTPClient.m
//  Weather
//
//  Created by Joseph Butewicz on 11/24/13.
//  Copyright (c) 2013 Scott Sherwood. All rights reserved.
//

#import "WeatherHTTPClient.h"

@implementation WeatherHTTPClient

+ (WeatherHTTPClient *)sharedWeatherHTTPClient {
    // URL for World Weather API was updated!
    // NSString *urlStr = @"http://free.worldweatheronline.com/feed/";
    NSString *urlStr = @"http://api.worldweatheronline.com/free/v1/";
    
    static dispatch_once_t pred;
    static WeatherHTTPClient *_sharedWeatherHTTPClient = nil;
    
    dispatch_once(&pred, ^{ _sharedWeatherHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:urlStr]]; });
    return _sharedWeatherHTTPClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    // Code from the tutorial that was updated was commented out below.
    //[self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    // AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager self];
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
         return self;
}

- (void)updateWeatherAtLocation:(CLLocation *)location forNumberOfDays:(int)number{
    // Code from the tutorial that was updated was commented out below.
    /*
     NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
     [parameters setObject:[NSString stringWithFormat:@"%d",number] forKey:@"num_of_days"];
     [parameters setObject:[NSString stringWithFormat:@"%f,%f",location.coordinate.latitude,location.coordinate.longitude] forKey:@"q"];
     [parameters setObject:@"json" forKey:@"format"];
     [parameters setObject:@"7f3a3480fc162445131401" forKey:@"key"];
     
     [self getPath:@"weather.ashx"
     parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
     if([self.delegate respondsToSelector:@selector(weatherHTTPClient:didUpdateWithWeather:)])
     [self.delegate weatherHTTPClient:self didUpdateWithWeather:responseObject];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     if([self.delegate respondsToSelector:@selector(weatherHTTPClient:didFailWithError:)])
     [self.delegate weatherHTTPClient:self didFailWithError:error];
     }];
     }*/
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSString stringWithFormat:@"%d",number] forKey:@"num_of_days"];
    [parameters setObject:[NSString stringWithFormat:@"%f,%f",location.coordinate.latitude,location.coordinate.longitude] forKey:@"q"];
    [parameters setObject:@"json" forKey:@"format"];
    [parameters setObject:@"7f3a3480fc162445131401" forKey:@"key"]; // VERY IMPORTANT! The API key in this example was created only for Ray's tutorial, and I don't think it functions any longer. You have to create an account at World Weather Online and get your own API key or this will not work!

        [self GET:[NSString stringWithFormat:@"weather.ashx"]
          parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 if([self.delegate respondsToSelector:@selector(weatherHTTPClient:didUpdateWithWeather:)])
                     [self.delegate weatherHTTPClient:self didUpdateWithWeather:responseObject];
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 if([self.delegate respondsToSelector:@selector(weatherHTTPClient:didFailWithError:)])
                     [self.delegate weatherHTTPClient:self didFailWithError:error];
             }];

}

@end
