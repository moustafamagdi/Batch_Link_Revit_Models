@echo off
setlocal enabledelayedexpansion

:: Create the output CSV file without a header
set "output_file=Links_paths.csv"
copy /b NUL "%output_file%" > NUL
echo A new CSV file '%output_file%' has been created.

:: Start collecting folder paths from the user
:input_folders
echo.
echo =======================
echo Enter folder paths to search for .rvt files.
echo (Press Enter without input to stop.)
echo =======================
echo.
set /p "folder=Please enter a folder path: "

:: Check if the user pressed Enter without input, stop the script
if "%folder%"=="" (
    echo.
    echo No folder provided. Proceeding to remove duplicates if any...
    goto remove_duplicates
)

:: Check if the folder exists
if not exist "%folder%" (
    echo.
    echo [Error] Folder "%folder%" does not exist. Please try again.
    echo.
    goto input_folders
)

:: Notify user of the search process
echo Searching for .rvt files in "%folder%"...
:: Search for .rvt files in the folder and append them to the output CSV
for %%i in ("%folder%\*.rvt") do (
    >> "%output_file%" echo %%~fi
)

:: Inform user of the result
echo Found .rvt files in "%folder%" and added to the CSV.

:: After adding the folder, check for another input
goto ask_for_next

:ask_for_next
echo.
set /p "continue=Would you like to add another folder? (Y/N): "

if /i "%continue%"=="N" (
    echo.
    echo You have chosen to stop adding folders.
    goto remove_duplicates
)
if /i "%continue%"=="Y" (
    goto input_folders
)

:: If invalid input, ask again
echo Invalid input. Please enter Y or N.
goto ask_for_next

:remove_duplicates
echo.
echo Removing any duplicate entries from the CSV file...

:: Remove duplicates from the CSV file
set "temp_file=temp.csv"
copy /b NUL "%temp_file%" > NUL

:: Use a variable to track unique lines and remove duplicates
set "line="
for /f "delims=" %%i in ('sort "%output_file%"') do (
    if "!line!" neq "%%i" (
        >> "%temp_file%" set /p "=%%i" <nul
        >> "%temp_file%" echo.
        set "line=%%i"
    )
)

:: Replace the original CSV with the deduplicated version
move /y "%temp_file%" "%output_file%" > NUL

:end_input
echo.
echo ================================================
echo Done! The CSV file has been updated successfully.
echo The full paths of all .rvt files are listed in '%output_file%'.
echo No duplicates remain in the final output.
echo ================================================
pause
