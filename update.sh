read -p "Enter name of repo to update: " repo_name
if [ -z $repo_name ]
then
    echo "Empty repo name"
else
    cd ~/$repo_name 
    git checkout master
    git pull
    read -p "Enter name of a NEW BRANCH where you put changes: " branch_name
    git checkout -b $branch_name
    git status
    rsync -arv ~/main-repo/ ~/sub-repo/ --exclude="db" --exclude="gcp"
    read -p "Do you wanna commit, push and create PR of changes?(y/n)" commit
    if [ $commit = "y" ]
    then
        git add .
        git status 
        read -p "Enter message commit: " message_commit
        git commit -m "$message_commit"
        git push --set-upstream origin $branch_name
        git request-pull 
    fi
fi