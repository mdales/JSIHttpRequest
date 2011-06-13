//
//  JSIFormDataRequest.h
//
//  Created by Michael Dales on 07/06/2011.
//  Copyright 2011 Digital Flapjack Ltd. All rights reserved.
//

@import "JSIHTTPRequest.j"


@implementation JSIFormDataRequest : JSIHTTPRequest
{
    var _params;
}

///////////////////////////////////////////////////////////////////////////////
//
- (id)initWithURL: (CPString)url
{
    if (self = [super initWithURL: url])
    {        
        [_request setHTTPMethod: "POST"]; 
        [_request setValue:"application/x-www-form-urlencoded" forHTTPHeaderField:"Content-Type"]; 
        
        _params = [[CPDictionary alloc] init];
    }
    
    return self;
}


///////////////////////////////////////////////////////////////////////////////
//
- (void)setPostValue: (CPString)value forKey: (CPString)key
{
    [_params setValue: value
        forKey: key];
}



///////////////////////////////////////////////////////////////////////////////
//
- (void)startAsynchronous
{    
    var body = "";
    
    var keys = [_params allKeys];
    for (var i = 0; i < [keys count]; i++)
    {
        if (i != 0)
            body += "&";
        
        var key = [keys objectAtIndex: i];
        var value = [_params objectForKey: key];
        
        body += escape(key) + "=" + escape(value);        
    }
    [_request setValue:[body length] forHTTPHeaderField:"Content-Length"]; 
    [_request setHTTPBody: body]; 
    
    [super startAsynchronous]; 
}


@end