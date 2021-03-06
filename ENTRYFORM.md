# Hackathon Submission Entry form

> __Important__  
> 
> Copy and paste the content of this file into README.md or face automatic __disqualification__  
> All headlines and subheadlines shall be retained if not noted otherwise.  
> Fill in text in each section as instructed and then delete the existing text, including this blockquote.

You can find a very good reference to Github flavoured markdown reference in [this cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet). If you want something a bit more WYSIWYG for editing then could use [StackEdit](https://stackedit.io/app) which provides a more user friendly interface for generating the Markdown code. Those of you who are [VS Code fans](https://code.visualstudio.com/docs/languages/markdown#_markdown-preview) can edit/preview directly in that interface too.

## Team name
⟹ We are Groot

## Category
⟹ Best use of SPE to help Content authors and Marketers

## Description
⟹ Write a clear description of your hackathon entry.  

  - Module Purpose
  - It helps content author
    - All content authors are not well versed with the Powershell scripting and hence face issues while writing scripts
      to add, delete or update assets in bulk. Their last resort is to use sitecore UI which for bulk files takes a lot of time.
      This tools generate dynamic queries based on certain given inputs and helps in generating dynamic Powershell scripts in 
      just a few clicks.

_You can alternately paste a [link here](#docs) to a document within this repo containing the description._

## Video link
⟹ Provide a video highlighing your Hackathon module submission and provide a link to the video. You can use any video hosting, file share or even upload the video to this repository. _Just remember to update the link below_

⟹ [Replace this Video link](#video-link)



## Pre-requisites and Dependencies

## Installation instructions

1. Open any sitecore 10.1 Evnironment
2. Install attached sitecore package
3. Login to Sitecore
4. Access the utility by opening the below a) or b)
4.a the Launch Pad => Find SPE Dynamic Query under Content Edior Group
4.b {​​​​SitecoreInstanceName}​​​​/sitecore/admin/EasySPE.aspx
5. Sitecore Package Contents:
> Boot Stap css & Js
> SPE Dynamic Query Standalone aspx page
> Master : Test sitecore templates ( Products, Blogs, News)
> Core : Sitecore Launch Configurations

### Configuration
⟹ If there are any custom configuration that has to be set manually then remember to add all details here.

_Remove this subsection if your entry does not require any configuration that is not fully covered in the installation instructions already_

## Usage instructions
⟹ This utility has 4 functionalities which can be used follwoing the below steps:
     1- Create : This helps in generating the powershell script to Create items in bulk.
               Steps=>
                    a-Select "Sitecore root path"
                    b-Select "Template"
                    c-Enter - no of items to be created
                    d-Click "Build SPE Query"
                    e-Copy the generated powershell script from the bottom text area and execute in sitecore PowerShell ISE 

     2- Delete : This helps in generating the powershell script to delete items with a particular template.
               Steps=>
                    a-Select "Sitecore root path"
                    b-Select "Template"
                    c-Click "Build SPE Query"
                    d-Copy the generated powershell script from the bottom text area and execute  in sitecore PowerShell ISE
     3- Update : This helps in generating the powershell script to update field value with a particular template and field name.
               Steps=>
                    a-Select "Sitecore root path"
                    b-Select "Template"
                    c-Enter "Field Name" and "Field Value"
                    d-Click "Build SPE Query"
                    e-Copy the generated powershell script from the bottom text area and execute in sitecore PowerShell ISE 
     4- Search : This helps in generating the powershell script search and generate a report of items with a particular template.
               Steps=>
                    a-Select "Sitecore root path"
                    b-Select "Template"
                    c-Click "Build SPE Query"
                    d-Copy the generated powershell script from the bottom text area and execute in sitecore PowerShell ISE    

 To open Sitecore PowerShell ISE follow the bewlow steps :
                        1) Open Sitecore Launch Icon
                        2) Navigate to Desktop
                        3) Start Menu -> Development Tools -> PowerShell ISE
                        4) Paste the copied script and click Execute Icon

![Hackathon Logo](docs/images/hackathon.png?raw=true "Hackathon Logo")
![Hackathon Logo](docs/Utility_screenshots/Create-5.png?raw=true "Create-5")
![Hackathon Logo](docs/Utility_screenshots/Create-6.png?raw=true "Create-6")
![Hackathon Logo](docs/Utility_screenshots/Delete-1.png?raw=true "Delete-1")
![Hackathon Logo](docs/Utility_screenshots/Delete-2.png?raw=true "Delete-2")
![Hackathon Logo](docs/Utility_screenshots/Search-1.png?raw=true "Search-1")
![Hackathon Logo](docs/Utility_screenshots/Search-2.png?raw=true "Search-2")
![Hackathon Logo](docs/Utility_screenshots/Search-3.png?raw=true "Search-3")
![Hackathon Logo](docs/Utility_screenshots/Update-1.png?raw=true "Update-1")

You can embed images of different formats too:

![Deal With It](docs/images/deal-with-it.gif?raw=true "Deal With It")

