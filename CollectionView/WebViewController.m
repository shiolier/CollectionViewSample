//
//  WebViewController.m
//  CollectionView
//
//  Created by Shiolier on 2014/06/24.
//
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>

@property (nonatomic) UIWebView *webView;
@property (nonatomic) UIToolbar *toolbar;
@property (nonatomic) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation WebViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Initialize
    }
    return self;
}

#pragma mark - instance

- (UIWebView *)webView
{
	if (!_webView) {
		_webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,
															   self.view.frame.size.width,
															   self.view.frame.size.height - 108)];
		_webView.delegate = self;
	}
	return _webView;
}

- (UIToolbar *)toolbar
{
	if (!_toolbar) {
		_toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.webView.frame.size.height,
															   self.view.frame.size.width, 44)];
		_toolbar.barStyle = UIBarStyleDefault;
		_toolbar.tintColor = [UIColor blackColor];
		
		UIBarButtonItem *backButton =
		[[UIBarButtonItem alloc] initWithTitle:@"Back"
										 style:UIBarButtonItemStylePlain
										target:self
										action:@selector(backAction:)];
		UIBarButtonItem *forwardButton =
		[[UIBarButtonItem alloc] initWithTitle:@"Forward"
										 style:UIBarButtonItemStylePlain
										target:self
										action:@selector(forwardAction:)];
		
		UIBarButtonItem *reloadButton =
		[[UIBarButtonItem alloc] initWithTitle:@"Reload"
										 style:UIBarButtonItemStylePlain
										target:self
										action:@selector(reloadAction:)];
		
		UIBarButtonItem *space =
		[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
													  target:nil
													  action:nil];
		
		[_toolbar setItems:@[backButton, space, reloadButton, space, forwardButton] animated:YES];
	}
	return _toolbar;
}

- (UIActivityIndicatorView *)activityIndicatorView
{
	if (!_activityIndicatorView) {
		_activityIndicatorView =
			[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		_activityIndicatorView.center = self.view.center;
		_activityIndicatorView.hidesWhenStopped = YES;
	}
	return _activityIndicatorView;
}

#pragma mark -

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// NavigationBarの左下座標をレイアウトの原点にする
	self.navigationController.navigationBar.translucent = NO;
	
	[self.view addSubview:self.webView];
	[self.view addSubview:self.toolbar];
	[self.view addSubview:self.activityIndicatorView];
}

-(void)viewWillAppear:(BOOL)animated
{
	[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.openURL]]];
	[self barButtonEnabledChange];
}

#pragma mark - Action

- (void)backAction:(UIBarButtonItem *)sender
{
	if (self.webView.canGoBack) {
		[self.webView goBack];
	}
	[self barButtonEnabledChange];
}

- (void)forwardAction:(UIBarButtonItem *)sender
{
	if (self.webView.canGoForward) {
		[self.webView goForward];
	}
	[self barButtonEnabledChange];
}

- (void)reloadAction:(UIBarButtonItem *)sender
{
	[self.webView reload];
}

#pragma mark - UIWebViewDelegate

// ページ読み込み直後
- (void)webViewDidStartLoad:(UIWebView *)webView
{
	NSLog(@"webViewDidStartLoad:");
	[self.activityIndicatorView startAnimating];
}

// ページ読み込み完了後
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	NSLog(@"webViewDidFinishLoad:");
	[self.activityIndicatorView stopAnimating];
	
	[self barButtonEnabledChange];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	NSLog(@"webView:didFailLoadWithError:");
}

#pragma mark -

- (void)barButtonEnabledChange
{
	UIBarButtonItem *backButton = self.toolbar.items[0];
	UIBarButtonItem *forwardButton = self.toolbar.items[4];
	
	if ([self.webView canGoBack]) {
		backButton.enabled = YES;
	} else {
		backButton.enabled = NO;
	}
	
	if ([self.webView canGoForward]) {
		forwardButton.enabled = YES;
	} else {
		forwardButton.enabled = NO;
	}
}

@end
