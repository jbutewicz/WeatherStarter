//
//  WeatherHTTPClient.h
//  Weather
//
//  Created by Joseph Butewicz on 11/24/13.
//  Copyright (c) 2013 Scott Sherwood. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@protocol WeatherHttpClientDelegate;

@interface WeatherHTTPClient : AFHTTPRequestOperationManager

@property(weak) id<WeatherHttpClientDelegate> delegate;

+ (WeatherHTTPClient *)sharedWeatherHTTPClient;
- (id)initWithBaseURL:(NSURL *)url;
- (void)updateWeatherAtLocation:(CLLocation *)location forNumberOfDays:(int)number;

@end

@protocol WeatherHttpClientDelegate <NSObject>
- (void)weatherHTTPClient:(WeatherHTTPClient *)client didUpdateWithWeather:(id)weather;
- (void)weatherHTTPClient:(WeatherHTTPClient *)client didFailWithError:(NSError *)error;
@end