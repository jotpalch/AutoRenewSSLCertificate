# Automated SSL Certificate Renewal with GitHub Actions and GoDaddy

This repository contains scripts and workflows to automatically renew SSL certificates for domains hosted on GoDaddy using Let's Encrypt and Certbot. The process is automated using GitHub Actions and a self-hosted runner.

## Overview

The system uses the following components:
- GitHub Actions for workflow automation
- Certbot for certificate issuance and renewal
- GoDaddy API for DNS challenge verification
- Docker to run Certbot
- A self-hosted GitHub Actions runner

## Setup Instructions

1. **GoDaddy API Credentials**
   - Obtain your GoDaddy API key and secret from the [GoDaddy Developer Portal](https://developer.godaddy.com/).
   - In your GitHub repository, go to Settings > Secrets and variables > Actions.
   - Add two new repository secrets:
     - `GODADDY_API_KEY`: Your GoDaddy API key
     - `GODADDY_API_SECRET`: Your GoDaddy API secret

2. **Self-Hosted Runner**
   - Go to your repository settings on GitHub.
   - Navigate to Actions > Runners.
   - Click "New self-hosted runner" and follow the instructions to set up the runner on your server.
   - Ensure Docker is installed on the machine running the self-hosted runner.

3. **Repository Files**
   Ensure the following files are present in your repository:
   - `.github/workflows/renew-ssl.yml`: The GitHub Actions workflow file
   - `godaddy-dns-challenge.sh`: Script to update DNS records via GoDaddy API

4. **Customization**
   - In `renew-ssl.yml`, update the domain name if different from `*.jotpac.com`.
   - In `godaddy-dns-challenge.sh`, update the `DOMAIN` variable if different from `jotpac.com`.

## How It Works

1. The GitHub Actions workflow runs every 3 months or can be triggered manually.
2. It uses the self-hosted runner to execute the renewal process.
3. The workflow runs Certbot in a Docker container.
4. During the ACME challenge, it uses the `godaddy-dns-challenge.sh` script to set the required DNS TXT record.
5. Once the certificate is renewed, it's stored in `/etc/letsencrypt` on the host machine.

## Manual Triggering

To manually trigger the renewal process:
1. Go to the "Actions" tab in your GitHub repository.
2. Select the "Renew SSL Certificate" workflow.
3. Click "Run workflow" and then "Run workflow" again to confirm.

## Troubleshooting

- Ensure the self-hosted runner has the necessary permissions to run Docker commands.
- Verify that the runner has access to `/etc/letsencrypt` directory.
- Check the GitHub Actions logs for any error messages if the renewal fails.

## Security Considerations

- The GoDaddy API credentials are stored as GitHub secrets and are not exposed in logs.
- Ensure your self-hosted runner is secure, as it has access to sensitive information.

## Contributing

Feel free to submit issues or pull requests if you have suggestions for improvements or encounter any problems.
