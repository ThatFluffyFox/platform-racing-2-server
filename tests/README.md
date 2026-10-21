# Tests

Dependency-free PHP tests for the multiplayer server transport layer. They cover
the WebSocket codec (`multiplayer_server/WebSocket.php`) and the raw-vs-websocket
transport handling in `PR2Client`, including the protocol sniffing that lets a
single port serve both the legacy Flash/socket client and WebSocket clients.

There is no local PHP requirement. The test runner builds and caches a PHP 8.2.35
image with the sockets extension, matching the multiplayer server's PHP version:

```sh
# all tests
tests/run.sh

# a single file
tests/run.sh tests/WebSocketTest.php
tests/run.sh tests/TransportIntegrationTest.php
```

The runner exits non-zero if any assertion fails.

- `WebSocketTest.php` — unit tests for sniff / handshake / frame decode + encode.
- `TransportIntegrationTest.php` — drives a real `socket_create_pair` through
  `PR2Client` to confirm raw and websocket streams yield identical application
  messages and are framed correctly on write.
