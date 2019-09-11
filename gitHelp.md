# Git State of Mind


## Cloning

```$ git clone https://github.roche.com/PDCuration/scrubj.git```

## Status of Your Branch

```
$ git status
$ git branch --all
```

## Changing Branches

```
$ git checkout feature-adding_data
$ git checkout -b feature-adding_new_data   # creates and switches to new branch
Switched to a new branch 'feature-adding_new_data'
```

## Tracking Branches
```
$ git branch --set-upstream-to=origin/<branch> feature-adding_data
$ git branch feature-adding_data -u origin/dev
Branch 'feature-adding_data' set up to track remote branch 'dev' from 'origin'.
```

## Pushing Branches to Origin
```
$ git push origin feature-adding_data
```

## Sync Branch with Origin
```
$ git pull origin feature-adding_data
```

## Delete Branch
```
git branch -d branch_name
git branch -D branch_name
```

