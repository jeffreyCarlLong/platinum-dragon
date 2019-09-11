# Git State of Mind


## Cloning
```
$ git clone https://github.roche.com/PDCuration/scrubj.git
```

## Status of Branch
```
$ git status
$ git branch --all
```

## Changing Branches
```
$ git checkout feature-adding_data
$ git checkout -b feature-adding_new_data   # Creates new branch and switches to that branch
Switched to a new branch 'feature-adding_new_data'
```

## Tracking Branches
```
$ git branch --set-upstream-to=origin/feature-adding_new_data
$ git branch feature-adding_new_data -u origin/dev
Branch 'test1' set up to track remote branch 'dev' from 'origin'.
```

## Pushing Branches
```
$ git push origin test1
```

## Sync Branch with Origin
```
$ git pull origin feature-adding_new_data
```

## Delete branch
```
git branch -d branch_name
git branch -D branch_name   # --force
```
