#!/bin/bash
#**********************************************************************
#***  MVS TK5 Startup Script for macOS (using Homebrew Hercules)   ***
#**********************************************************************

# Change to the TK5 directory
cd "$(dirname "$0")/mvs-tk5" || exit

# Set environment variables for TK5
export TK5CRLF="crlf"
export TK5CONS="intcons"

echo "=========================================="
echo "  Starting MVS TK5 with Hercules"
echo "=========================================="
echo ""
echo "Console port: 3270 (connect with tn3270 client)"
echo "HTTP port:    8038 (web console: http://localhost:8038)"
echo ""
echo "To connect to MVS:"
echo "  1. Use a tn3270 client (like x3270, c3270, or wc3270)"
echo "  2. Connect to: localhost:3270"
echo "  3. Default TSO users: HERC01, HERC02, HERC03, HERC04"
echo "  4. Password is the same as the username"
echo ""
echo "To shutdown MVS cleanly:"
echo "  1. At Hercules console, type: /s shutall"
echo "  2. Wait for shutdown message"
echo "  3. Type: quit"
echo ""
echo "=========================================="
echo ""

# Start Hercules with TK5 configuration
hercules -f conf/tk5.cnf -r scripts/ipl.rc
