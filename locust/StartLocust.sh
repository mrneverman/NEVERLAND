rm out.log; rm std.err; locust --host=https://neverland.com --web-host=0.0.0.0 --web-port=8089 --loglevel=DEBUG --logfile=out.log 2> std.err
