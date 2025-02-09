# Config
git_output="/Users/MohammedRaqeeb/Desktop/wiki/output"
obsidian_folder="/Users/MohammedRaqeeb/Desktop/wiki/vault"
root_folder="/Users/MohammedRaqeeb/Desktop/wiki"

# Move to output folder and make sure it is up to date
cd $git_output
git pull 

# Remove all files except .git/ and README.md
echo "Will delete previous output:"
find . ! -path "./.git/*" ! -name ".git" ! -name README.md -delete


# Convert Obsidian to HTML
cd $root_folder
obsidianhtml -i ./config.yaml
# ^ the config file will output the html to $git_output

if [ $? -ne 0 ]; then
    echo "Python script failed. Exited."
    exit 1
else
    echo "Successfully created html code"
fi

# Push changes
cd $git_output
#mv html/* ./
rm -rf html/

git init 
git add . --all
git branch -M main
git commit -m "autopush"
launchctl stop /System/Library/LaunchAgents/org.openbsd.ssh-agent
launchctl start /System/Library/LaunchAgents/org.openbsd.ssh-agent
git remote add origin https://github.com/raq33b/raq33b.github.io.git
git push --set-upstream origin main -uf