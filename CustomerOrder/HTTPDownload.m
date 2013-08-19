//
//  HTTPDownload.m
//  CustomerOrder
//
//  Created by ios on 13-7-11.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "HTTPDownload.h"

@implementation HTTPDownload
@synthesize mData = _mData;
@synthesize delegate = _delegate;

- (void)downloadFromURL:(NSString *)url withArgument:(NSString *)argument
{
    if (self.mData == nil) {
        
        self.mData= [[NSMutableData alloc]init];
        
    } else {
        
        self.mData.length = 0;
    }
    
    mRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [mRequest setHTTPMethod:@"POST"];
    NSString *str = [NSString stringWithFormat:@"%@",argument];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [mRequest setHTTPBody:data];
    [NSURLConnection connectionWithRequest:mRequest delegate:self];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.mData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [_delegate downloadDidFinishLoading:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [_delegate downloadDidFail:self];
}

-(void)dealloc
{
    [_mData release];
    [super dealloc];
}
@end
