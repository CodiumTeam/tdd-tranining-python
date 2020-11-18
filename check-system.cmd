@echo off

CALL :validateDocker
CALL :validateKata fizz-buzz "docker run --rm -v %CD%:/opt/project -w /opt/project codiumteam/tdd-training-python make test"
CALL :validateKata roman-numerals "docker run --rm -v %CD%:/opt/project -w /opt/project codiumteam/tdd-training-python make test"
CALL :validateKata password-validator "docker run --rm -v %CD%:/opt/project -w /opt/project codiumteam/tdd-training-python make test"
CALL :validateKata user-registration "docker run --rm -v %CD%:/opt/project -w /opt/project codiumteam/tdd-training-python make test"
CALL :validateKata coffee-machine "docker run --rm -v %CD%:/opt/project -w /opt/project codiumteam/tdd-training-python make test"

goto :eof

:validateKata
    echo Validating %1...
    pushd %1
    CALL %~2
    popd
goto :eof

:validateDocker
    echo Validating docker running...
    docker ps >NUL: 2>NUL:
    IF ERRORLEVEL 1 (
      echo Error
      echo Are you sure that you have docker running?
      goto :eof
    ) else (
      echo "Ok"
    )

    echo Creating docker image...
    docker build . -t codiumteam/tdd-training-python >NUL: 2>NUL:
    IF ERRORLEVEL 1 (
      echo Error
      echo Do you have internet connection?
      goto :eof
    ) else (
      echo Ok
    )

    echo Validating docker mount permissions...
    docker run --rm -v "%CD%":/opt -w /opt codiumteam/tdd-training-python ls >NUL: 2>NUL:
    IF ERRORLEVEL 1 (
      echo Error
      echo Are you sure that you have permissions to mount your volumes?
      goto :eof
    ) else (
      echo Ok
    )
goto :eof

