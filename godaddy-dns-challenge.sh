#!/bin/bash

set -e

# GoDaddy API credentials
API_KEY=$GODADDY_API_KEY
API_SECRET=$GODADDY_API_SECRET

# Domain and subdomain
DOMAIN="jotpac.com"
SUBDOMAIN="_acme-challenge"

# ACME challenge details
ACME_CHALLENGE=$CERTBOT_VALIDATION

# Set the TXT record
curl -X PUT "https://api.godaddy.com/v1/domains/$DOMAIN/records/TXT/$SUBDOMAIN" \
  -H "Authorization: sso-key $API_KEY:$API_SECRET" \
  -H "Content-Type: application/json" \
  -d "[{\"data\": \"$ACME_CHALLENGE\", \"ttl\": 600}]"

# Wait for DNS propagation
sleep 30