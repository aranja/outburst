
/**
 * Module dependencies.
 */

var express = require('express')
  , http = require('http')
  , socketPort = require('./gameserver/shared/constants').SOCKET_PORT;

/**
 * Create express server
 */
var app = express();

/**
 * Create http server for socket.io
 */
var server = http.createServer(app);
var io = require('socket.io')(server);
module.exports = server;

/**
 * Game servers
 */
var GameServer = require('./gameserver/main');
new GameServer.Server(io);

/**
 * Master server
 */
var MasterServer = require('./masterserver/main');
new MasterServer.Server(app);

