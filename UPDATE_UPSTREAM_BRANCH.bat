@echo off
cd /d %~dp0

REM Variables
set UPSTREAM_REPO=https://github.com/Unity-Technologies/Graphics
set FORK_REPO=https://github.com/Propel-VR/Custom-URP
set SUBFOLDER=Packages/com.unity.render-pipelines.universal
set UPSTREAM_BRANCH=upstream_master

REM Clone your fork locally
git clone %FORK_REPO% .
cd %~dp0

REM Add the original repository as a remote
git remote add upstream %UPSTREAM_REPO%

REM Fetch only the master branch from the original repository
git fetch upstream master

REM Checkout the specific subfolder from the original repository
git checkout -b %UPSTREAM_BRANCH% upstream/master -- %SUBFOLDER%

REM Merge the changes into your local fork
git merge %UPSTREAM_BRANCH%

REM Delete all branches except for master
for /f "tokens=*" %%i in ('git branch ^| findstr /v "master"') do git branch -D %%i

REM Resolve conflicts manually if needed, then commit the changes
git commit -m "Merged changes from upstream"

REM Push the changes to your GitHub repository
git push origin master
