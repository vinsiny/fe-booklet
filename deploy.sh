# ## this script deploys the static website of course.rs to github pages

# ## build static website for book
# mdbook build

# ## init git repo
# cd book
# git init
# git config user.name "vinsiny"
# git config user.email "muffinxb@163.com"
# git add .
# git commit -m 'deploy'
# git branch -M gh-pages
# git remote add origin https://github.com/vinsiny/fe-booklet.git

# ## push to github pages
# git push -u -f origin gh-pages

# git worktree add ./gh-pages
mdbook build
# rm -rf ./book/* # this won't delete the .git directory
# cp -rp book/* ./book/
cd ./book
git init
git config user.name "vinsiny"
git config user.email "muffinxb@163.com"
git add -A
git commit -m 'deploy new book'
git branch -M gh-pages
git remote add origin https://github.com/vinsiny/fe-booklet.git
git push -u -f origin gh-pages
cd -