JSIHTTPRequest
==============

JSIHTTPRequest is a simple Cappuccino implementation of the basic interface for HTTP requests provided by the excellent ASIHTTPRequest by Ben Copsey. It's not nearly as full featured as ASIHTTPRequest, but it allows you to at least start making basic calls that have a similar flow in Cappuccino as you do on iOS/Mac.

Here's an example GET request:
    
    // editing ended, so save back to the server the new message
    var request = [[JSIHTTPRequest alloc] initWithURL: "http://hostname.net/stuff"];      
	
    [request setPostValue: csrfmiddlewaretoken
        forKey: @"csrfmiddlewaretoken"];

    [request setDelegate: self];
    [request startAsynchronous];


Like ASIHTTPRequest, JSIHTTPRequest will call requestDidFinish: and requestDidFail: methods on the delegate if they exist. You can specify custom selectors yourself:


    [request setDidFinishSelector: @selector(myRequestSuccessHandler:)];
    [request setDidFailSelector: @selector(myRequestFailureHandler:)];

To do POST requests use JSIFormDataRequest instead. You set parameters like so:
	
    [request setPostValue: 42 forKey: @"meaningOfLife"];

This is just a first pass, and I'm adding functionality as I need it. That said it's already making it easier to build my server side code in parallel with my client side code, as I can use the same network abstraction!

Michael Dales