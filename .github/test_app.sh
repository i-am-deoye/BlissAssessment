#!/bin/bash

set -eo pipefail

xcodebuild -workspace FingoApp.xcworkspace \
            -scheme FingoApp \
            -destination platform=iOS\ Simulator,name=iPhone\ 11 \
            clean test | xcpretty
