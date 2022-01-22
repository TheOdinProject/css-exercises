# CSS Exercises Contributing Guide

Thank you for expressing interest in contributing to our CSS exercises! Please be sure to read this guide thoroughly before contributing, as it will lessen the chances of any issues arising during the process.

**Please do not open a pull request (PR) with your solutions to any exercises in this repo**. Your PR will be immediately closed without being merged. The exercises are for you to do and keep on your own local machine or your personal GitHub.

## How to Contribute

### Being Assigned an Issue

If you would like to work on an existing issue in the repo:

1) Find an issue that is not currently assigned to anyone
    * A couple of good places to start are ["help wanted" issues](https://github.com/TheOdinProject/css-exercises/labels/Help%20Wanted) or ["good first issue" issues](https://github.com/TheOdinProject/css-exercises/labels/good%20first%20issue)

2) Ask to be assigned the issue by a maintainer
    * **If you are not a maintainer, do not give others permission to work on an issue**

3) **Wait to be assigned the issue before starting any work**

4) After being assigned, address each item listed in the acceptance criteria
    * If there are no acceptance criteria stated in the issue, ask the maintainer that assigned you the issue if any exist

If you would like to propose a small change (fixing a typo, updating a link, etc.) that is not part of an existing issue, you are welcome to make the change and submit a PR without an official issue.

### Creating an Issue

If you would like to propose a more significant change:

1. Go through the open issues and make sure an issue doesn't already exist
    * If the issue already exists, but there are details you feel are missing, leave a comment on the already opened issue

2. If the issue doesn't already exist, create a new one and **read the issue template in its entirety and fill out all applicable sections**

### Setting Up Your Local Clone

Before you begin working on anything, be sure you follow these steps in order to set up a clone on your local machine:

1. Fork this repo to your own GitHub account. If you don't know how to do so, follow the GitHub documentation on how to [fork a repo](https://docs.github.com/en/get-started/quickstart/fork-a-repo)

2. Clone this repo to your local machine with one of the following commands, replacing the `<your username>` text with your actual GitHub username:
    ```bash
    # If you have SSH set up with Git
    git clone git@github.com:<your username>/css-exercises.git
    # Otherwise for HTTPS
    git clone https://github.com/<your username>/css-exercises.git
    ```

3. `cd` into the directory of your local clone, then set the upstream remote so you can keep your local clone synced with TOP's original repo:
    ```bash
    # If you have SSH set up with Git
    git remote add upstream git@github.com:TheOdinProject/css-exercises.git
    # Otherwise for HTTPS
    git remote add upstream https://github.com/TheOdinProject/css-exercises.git
    ```

### Working on an Issue

Once you have the repo forked and cloned, and the upstream remote has been set, you can begin working on your issue:

1. Create a new branch, replacing the `<your branch name>` with an actual branch name, e.g. "flex_exercises":
    ```bash
    git checkout -b <your branch name>
    ```

2. Add commits as you work on your issue, replacing the `<your commit message>` text with your actual commit message:
   ```bash
   git commit -m "<your commit message>"
   ```

3. Sync your work with the upstream remote every so often. Follow the [ongoing workflow](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-programming/lessons/using-git-in-the-real-world#ongoing-workflow) section in our Using Git in the Real World lesson.

4. Push your branch to your forked repo, replacing the `<your branch name>` with the branch you've been working on locally:
    ```bash
    $ git push origin <your branch name>
    ```
  
### Opening a Pull Request

1. After pushing your changes, go to your forked repo on GitHub and click the "Compare & pull request" button
   * If you don't see this button, you can click the branch dropdown menu and then select the branch you just pushed from your local clone:
   
      ![GitHub branch dropdown menu](https://user-images.githubusercontent.com/70952936/150646139-bc080c64-db57-4776-8db1-6525b7b47be2.jpg)
   
   * Once you have switched to the correct branch on GitHub, click the "Contribute" dropdown and then click the "Open pull request" button

2. **Read the PR template in its entirety and fill out all applicable sections** before submitting your PR

3. At this point a maintainer will either leave general comments, request changes, or approve and merge your PR
   * It is important to respond to any comments or requested changes in a timely manner, otherwise your PR may be closed without being merged due to inactivity
   * After pushing any requested changes to the branch you opened the PR with, be sure to re-request a review from the maintainer that requested those changes at the top of the right sidebar:

      ![Reviewers section of GitHub's sidebar](https://user-images.githubusercontent.com/70952936/150647064-4fdd59d1-82a4-4f18-894d-0e43a5ee0ffb.jpg)


## Need Further Help?
Please let us know if you require any help doing any of the steps in this guide in our Discord's [contribution-suggestions channel](https://discordapp.com/channels/505093832157691914/540903304046182425).
