Batch Link Models

This custom Dynamo script allows you to link multiple Revit models in a single action with just a few simple steps.

Steps:
Open the [CSV FILE CREATOR.bat] file to generate the list of desired models.

A CMD window will open, prompting you to enter the paths of the folders containing the .rvt files.
After completing this, a CSV file (similar to an Excel file) named [Links_paths.csv] will be generated in the same folder as the script. This file contains a list of the models to be linked.

Open Dynamo from the Manage tab within Revit.

Open the script file [Batch_Link_Models.dyn].

In the file path node, load the generated CSV file.

Run the script.

After the script finishes running, a log file will be generated in the same folder as the script. From this log file, you can determine:

Which links were successfully linked.
If a link was already linked previously.
If a link was previously linked but is in an Unloaded state.
If a link was previously linked, but there are no instances of the link found in the current model (meaning someone may have deleted the link instead or remove it within the Revit model).
