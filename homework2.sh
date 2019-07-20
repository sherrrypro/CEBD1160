#!/bin/bash
cd ~/Desktop/git_test
git init .
git add .


# 1- Undo a non-staged change in one of the files
echo "#some changes" >> cleaner.py # modify
git checkout cleaner.py # undo

# 2- Undo a staged change in one of the files
echo "#some changes" >> cleaner.py #modify
git add cleaner.py # stage
git reset HEAD # undo (stage)
git checkout . # undo (modify)

# 3- Undo a committed change in one of the files
echo "#some changes" >> cleaner.py #modify
git add cleaner.py # stage
git commit -m "make changes staged" # commit
git reset --hard HEAD~1 # undo

# 4- Reset your master branch to an older commit (your changes will be lost, add a new fake commit if you don’t want to lose it!)
touch fakefile
git add fakefile
git commit -m "adding fake file"
git log --pretty=oneline
older_commit=$(git log --pretty=oneline | grep "Adding remaining files" | cut -d' ' -f1) git reset --hard ${older_commit} # undo

## Create a branch to split your development
# 1- Create a branch called new-data and add a commit to it with a new file called data2.csv.
git checkout -b new-data master
echo "# data2.csv content" > data2.csv
git add data2.csv
git commit -m "adding data2.csv"

# 2- Checkout your master and check the files that you see.
git checkout master
ls

# 3- Create another branch from master and check the files that you see. Add two commits to it in any files.
git checkout -b another-branch master
echo "#some changes" >> cleaner.py # modify
git add cleaner.py
git commit -m"first commit"
echo "#some changes" >> processor.py # modify git add processor.py
git commit -m"second commit"

# 4- Checkout your master again and checking the files at each step, merge both branches into it.
git checkout master
ls
git merge --no-edit new-data
ls
git merge --no-edit another-branch ls

# 5- Visualize with git log --graph --oneline --decorate --all what happened.
git log --graph --oneline --decorate --all
