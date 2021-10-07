//
//  STCWebSocket.h
//  SpeechproSpeechKit
//
//  Created by Soloshcheva Aleksandra on 06.09.16.
//  Copyright © 2016 Speech Technology Center. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Provides working with sockets
 */

@class STCWebSocket;

@interface STCWebSocket : NSObject

@property(nonatomic, readonly, nonnull) NSURL *url;

/**
 * Creates the new websocket.
 * @param url       The connecting host.
 * @param protocols The supported websocket protocols (e.g. chat,superchat).
 * @return The newly initalized websocket.
 */
- (nonnull instancetype)initWithURL:(nonnull NSURL *)url
                          protocols:(nullable NSArray*)protocols;

/**
 * Connects to the host.
 */
- (void)connect;

/**
 * Disconnects to the host. This sends the close Connection opcode to terminate cleanly.
 */
- (void)disconnect;

/**
 * Writes binary based data to the socket.
 * @param data The binary data.
 */
- (void)writeData:(nonnull NSData*)data;

/**
 * Writes text based data to the socket.
 * @param string The string.
 */
- (void)writeString:(nonnull NSString*)string;

/**
 * Writes ping to the socket.
 * @param data The binary data.
 */
- (void)writePing:(nonnull NSData*)data;

/**
 * Adds a header to send along on the the HTTP connect.
 * @param value The string
 * @param key   The HTTP key name to send
 */
- (void)addHeader:(nonnull NSString*)value forKey:(nonnull NSString*)key;

/**
 * Returns if the socket is conneted or not.
 */
@property(nonatomic, assign, readonly)BOOL isConnected;

/**
 * Sets custom queue.
 * Default setting is dispatch_get_main_queue.
 */
@property(nonatomic, strong, nullable)dispatch_queue_t queue;

/**
 * Block property to use on connect.
 */
@property(nonatomic, strong, nullable)void (^onConnect)(void);

/**
 * Block property to use on disconnect.
 */
@property(nonatomic, strong, nullable)void (^onDisconnect)(NSError*_Nullable);

/**
 * Block property to use on receiving data.
 */
@property(nonatomic, strong, nullable) void (^onData)(NSData*_Nullable);

/**
 * Block property to use on receiving text.
 */
@property(nonatomic, strong, nullable) void (^onText)(NSString*_Nullable);

@end
