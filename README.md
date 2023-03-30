# README

# Overview

This system aims to mitigate the problems the Civil Service and Government Development Bureau (CGB) is encountering with keeping track of employee’s attendance across the 50 different organizations that they are responsible for. 

Hessa Boday, Fatima Al-Safar, Mashael Al-Emadi, and Noor Al-Tamimi worked together on developing a system that attempts to solve the scattered attendance problem by using mainly Ruby on Rails, with some CSS and HTML as well. 

The attendance system uses the Model-View-Controller (MVC) architectural pattern. 
The model is the base, which is responsible for the entities, relationships between entities, business logic and functionality, and communicating with the database. 
The view is responsible for the user interface, the aesthetic of it, and presenting data to the users. 
Lastly, the controller is responsible for the mediating between user requests (process logic), which mainly focuses on coordinating and communicating between the model and the view. 

The versions of Ruby and Rails are as follows:

Ruby: 3.1.2

Rails: 7.0.4.2

# Installing Supporting Softwares:

In order to have access to our Github repository and be able to get the code through Github you will need to have a Github account.

To create a Github account:
1. Go to https://github.com, and then select sign up
2. Enter your email address, password, and username
3. Verify your account by solving the puzzle that will appear on the screen
4. After verifying your account, click on “Create account”
5. Enter the launch code that will be sent to your email address, and press “Enter”
6. Answer the questions that will appear based on how you will be using the account
7. Select whether you want the “Free account” or “Team account”

Once these steps are complete, your Github account will be set to use!

To create a shared Github repository:
1. Go to your personal Github account page
2. Go to “Repositories” from the options bar on top
3. Click on “New”
4. Click on “Import a repository”
5. Enter our team repository URL “https://github.com/hboday/AttendanceCGB”
6. Enter a repository name
7. Choose whether you want to set the repository to public or private
8. Click “Begin import”
9. On the repository main page, click on “Settings” from the top bar options
10. From the “Access” section o the side bar, click on “Collaborators”
11. Confirm access using your Github account password
12. Click on “Add people”
13. Search for the collaborator using their username, full name, or email address
14. Select the collaborator, and click “Add to this repository”

Once these steps are completed, an invitation will be sent to the collaborator’s email to join the repository.

To have access to the code files, run the system, and make changes, you need to download VSCode which is a code editing program.

To install VSCode:
1. Go to https://code.visualstudio.com, and click on the download button
2. Open the downloaded package
3. Drag the app to the applications folder
4. Open VSCode from the application folder by double clicking the app icon

To set up the environment and have access to the code:
1. Install docker desktop from https://www.docker.com/products/docker-desktop/ 
2. Start running the containers in docker
3. Open VSCode
4. Click on the extensions icon on the sidebar 
5. Type dev container, and install the dev container extension 
6. Open the command palette by pressing “shift command p” 
7. In the command palette, search dev containers
8. Select dev container with description “clone repository in container volume”
9. Paste the URL of the Github repository to be cloned

If asked for these:
* Choose ruby devcontainers
* Select 3-bullseye (default)
* In the select features choose Node.js
* Select Keep defaults

Continue as follows:
In the terminal, run the command “bundle install”
Then, run the command “rails db:migrate”
Then, run the command “rails db:seed” 
Then run, “yarn add sass” 
Then run, “yarn add esbuild” 
Then run, “bin/dev” to run the server

To manually open a locally stored file:
1. Open VSCode
2. Click on “File” from the top options bar 
3. Choose “Open Folder”, and select the code file from where it is stored
4. To run the system, type the command “bin/dev”

# Extra Useful Links:

GitHub Documentations: https://docs.github.com/en

VSCode Documentations: https://code.visualstudio.com/docs
