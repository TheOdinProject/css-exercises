# CSS Exercises Contributing Guide

Thank you for expressing interest in contributing to our CSS exercises! Please be sure to read this guide thoroughly before contributing, as it will lessen the chances of any issues arising during the process.

Please do not contribute your solutions to any exercises in this repo. Your PR will be immediately closed without being merged. The exercises are for you to do and keep on your own local machine or your personal repo.

## How to Contribute

### Being Assigned an Issue

If you would like to work on an existing issue in the repo:

1) Find an issue that is not currently assigned to anyone
    * A couple of good places to start are ["help wanted" issues](https://github.com/TheOdinProject/css-exercises/labels/Help%20Wanted) or ["good first issue" issues](https://github.com/TheOdinProject/css-exercises/labels/good%20first%20issue)
2) Ask to be assigned the issue by a maintainer
    * **If you are not a maintainer, do not give others permission to work on an issue**
3) **Wait to be assigned the issue before working on anything**
4) After being assigned, address each item listed in the acceptance criteria
    * If there are no acceptance criteria stated in the issue, ask the maintainer that assigned you the issue if any exist

If you would like to propose a small change (fixing a typo, updating a link, etc.) that is not part of an existing issue, you are welcome to make the change and submit a pull request (PR) without an official issue.

### Creating an Issue

If you would like to propose a more significant change:

1. Go through the open issues and make sure an issue doesn't already exist
    * If the issue already exists, but there are details you've come across missing, leave a comment on the already opened issue
2. If the issue doesn't already exist, create a new one and **read and fill out the issue template in its entirety**

### Working on an Issue

Before you begin to work on an issue, be sure to follow these steps:

1. Fork and then clone this repo to your local machine, replacing the `<your username>` text with your actual GitHub username:
    ```bash
    # If you have ssh set up with Git
    git clone git@github.com:<your username>/css-exercises.git
    # Otherwise for HTTPS
    git clone https://github.com/<your username>/css-exercises.git
    ```

2. From the directory of your local clone, set the upstream remote so you can keep your copy of the app synced with the original:
    ```bash
    # If you have ssh set up with Git
    git remote add upstream git@github.com:TheOdinProject/css-exercises.git
    # Otherwise for HTTPS
    git remote add upstream https://github.com/TheOdinProject/css-exercises.git
    ```

3. Create a new branch:
    ```bash
    $ git checkout -b my-branch
    ```

4. Add commits as you work on the issue at hand with `git commit`

5. Sync your work with the remote upstream between commits. Follow the [ongoing workflow](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-programming/lessons/using-git-in-the-real-world#ongoing-workflow) section in our Using Git in the Real World lesson.

6. Push your branch to your forked repo:
    ```bash
    $ git push origin my-branch
    ```
  
### Opening a Pull Request

1) Go to your fork on Github after you have pushed up your branch and look for a button that asks you to open a pull request
2) **Read the PR template in its entirety and fill out all applicable sections**

## Need Further Help?
Please let us know if you require any help doing any of the steps in this guide in our Discord's [contribution-suggestions channel](https://discordapp.com/channels/505093832157691914/540903304046182425).
