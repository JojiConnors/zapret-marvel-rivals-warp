@echo off
chcp 65001 > nul
title Cloudflare WARP installer

echo Opening the official Cloudflare WARP download...
echo:
echo After installation:
echo 1. Select Private browsing.
echo 2. Accept the terms.
echo 3. Do not connect WARP yet.
echo 4. Run "2 - START Marvel Rivals via WARP.bat" as administrator.
echo:

start "" "https://downloads.cloudflareclient.com/v1/download/windows/ga"
pause
