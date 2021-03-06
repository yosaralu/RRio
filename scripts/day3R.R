# install git from internet https://git-scm.com/download/win
# go to Tools --> Global  options --> Git/SVN
# look for the app Git Bash and config git this way:
# git config --global user.name "Sara Colmenares"
# git config --global user.email "quehubosara@gmail.com"
# then type nano (here it does not work) Instead of it, type notepad
# my windows oes not have nano, a program which reads certain kind of text
# https://jennybc.github.io/2014-05-12-ubc/ubc-r/session03_git.html

# now verify you are in the same project go to Tools 
# and select Project Options, then Git/SVN then Git then Yes and Yes 
# (last one yes restart the R session)
# After this it apper an icon git in tool bar and a table Git 
# inside the folder of the project an archive called .gitignore is created


# The Table Git apperas with ? in status so I have to tell Git the files I want to include
# It means to create a repository
# So I go to config in Git tab and call Shell, and type git status
# the red list that appears in shell after type git status shows where the arquives are
# then type: git add . 
# then type: git commit -m "" 
# -m means a message is comming and "" is where the message is
# so type: git commit -m "my first message" 
# when I save data, in whatever the files, Git table will show it, 
# no more quotation marks will appear, now appear an M in status instead of the ?
# in shell type: git status 
# Everytime I do changes I have to make a comment to save a new file back up
# Type git log to see the history
# SHA is the number that appear in commit, every commit in the world has a unique SHA
# to go out tap Q
# git diff and the first numbers and letters in and then the name of the file, and
# then you see the whole changes made in that moment 
# example: git diff 1c8a1929 scripts/day3R.R

# In R: Save first
# Then I go to Commit and make a comment to decide what is going to be saved in the backup
# If I do not commit, the changes I do will never be saved in the back up
# Select the file in stages and save the commit
# Then I can go to History to see all the versions


## Using GitHub
# open shell 
# copy and paste the url in github once created the project there: 
# git remote add origin https://github.com/yosaralu/RRio.git
# type: git remote -v to see where is the project
# type then: git push -u origin master 
# then it will ask for user name and password in github


# In github it is possible to create the project and then here I click on 
# File > New Project > Git > Browse the directory > ok


 
#