@echo off
cd /d %~dp0

REM Variables
set UPSTREAM_REPO=https://github.com/Unity-Technologies/Graphics
set SUBFOLDER=Packages/com.unity.render-pipelines.universal
set NEW_BRANCH=incoming_changes

REM Check if the 'upstream' remote already exists
git remote | findstr upstream
if %errorlevel%==1 (
    REM Add the original repository as a remote
    git remote add upstream %UPSTREAM_REPO%
)

REM Fetch only the master branch from the original repository
git fetch upstream master

REM Checkout a new branch for the incoming changes
git checkout -b %NEW_BRANCH%

REM Ensure we are in the correct directory for merging
cd /d %~dp0

REM Merge the contents of the subfolder from upstream master into the root directory
git checkout upstream/master -- %SUBFOLDER%/
git mv %SUBFOLDER%/* .

REM Inform the user to resolve conflicts manually if needed and commit the changes
echo Resolve conflicts manually if needed, then commit the changes
echo After resolving conflicts, run: git commit -m "Merged changes from upstream"

pause
