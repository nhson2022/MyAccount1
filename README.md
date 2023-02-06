# MyAccount1 - Setup Authentication

## Setup git access
```
https://github.com/nhson2022/MyAccount1.git

git remote add origin git@github.com:nhson2022/MyAccount1.git
git status
git add -A
git commit -m "Comment"
git push -u origin main
```
...
## Setup project
```
./bin/importmap pin jquery bootstrap
bundle add bootstrap
```

**Setup devise**

Goto page and follow instructions https://github.com/heartcombo/devise
```
bundle add devise
rails generate devise:install
rails g devise:views

rails generate devise User
rails db:migrate
```
