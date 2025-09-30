Step-by-Step Guide to Deploy a GitLab Runner on Railway
This guide will walk you through deploying a personal GitLab Runner using the provided Dockerfile and entrypoint.sh script.

Step 1: Get Runner Details from GitLab
Before you can set up the runner, you need to get a registration token from your GitLab project, group, or instance.

Navigate to your GitLab project (or group/admin area).

Go to Settings > CI/CD.

Expand the Runners section.

Find the "Register a runner" section and copy the registration token. It will look something like glrt-xxxxxxxxxxxxxxxxxxxx.

Also, make a note of your GitLab instance URL (e.g., https://gitlab.com/).

Step 2: Set Up Your Project Files
In the root of your code repository, create the two files provided:

Dockerfile

entrypoint.sh

Commit these files to your repository.

Step 3: Deploy on Railway
Log in to your Railway dashboard.

Create a New Project and select Deploy from GitHub repo.

Choose the repository where you just added the Dockerfile and entrypoint.sh.

Railway will automatically detect the Dockerfile and start building your service.

Once the service is created, go to the Variables tab for that service.

Add the following required environment variables:

CI_SERVER_URL: The URL of your GitLab instance (e.g., https://gitlab.com/).

REGISTRATION_TOKEN: The token you copied from GitLab in Step 1.

(Optional) You can also add these variables to customize your runner:

RUNNER_DESCRIPTION: A description for your runner, e.g., "My Railway Runner".

RUNNER_TAG_LIST: A comma-separated list of tags, e.g., docker,self-hosted,production. This is important for directing specific jobs to this runner.

Railway will automatically re-deploy your service with these new variables. The entrypoint.sh script will run, register the runner with your GitLab instance, and then start polling for jobs.

Step 4: Verify the Runner is Active
Go back to the Settings > CI/CD > Runners page in GitLab. You should now see your new runner listed with a green circle, indicating it is online and ready to accept jobs.
