# What i covered in my slides

## Airtable and R: a marketers heaven
twitter: [@amymcdougall96](https://twitter.com/amymcdougall96)

## Intro
I'm Amy, I work at Locke Data. This is my first ever talk and i am not an R expert (i am a beginner).

## Agenda
What is Airtable?
Features of Airtable
Available packages
Authentication, and API docs
Example

Conclusion
Questions

## What is Airtable?
Airtable is a cloud collaboration service. It is a spreadsheet-database hybrid that contains the features of a database but applied to a speadsheet. Users can create a database, set up column types, add records, link tables to one another, collaborate, sort records and publish views to external websites. The fields are similar to cells in a spreadsheet.

## Features of Airtable
### Bases
All of the data used to create a project is contained in a base.
Bases can be build in a few different way like:
- Using exisiting templates provided by Airtable
- Build them from scratch 
- Import from a spreadsheet (You have two options for importing data — uploading a CSV file or copy-and-pasting the data into a new, empty Base.)
- From an existing bases (Creat a copy of a exisiting base from the homepage by clicking the dropdown beside the Base name and selecting “Duplicate.” Choose to keep the existing records and comments or just duplicate the structure of the Base).
- You can also create forms. These are easily created from exisiting bases. You can create these form scratch also. Every form you create has a shareable link made to link to the form. This link you can sent to people to see the form. When they fill the form this automaticall fills the data in your base as a grid view (the default view).
A collection of bases is a called a team and you can add collaborators to your bases. You can choose which of your bases they see and what level permissions they get from the following 3: Creator, edit only, read only.

### Tables
A base is a collection of tables, it is similar to worksheets in a spreadsheet.
You can link exisiting tables of related records, create new linked tables, and multiple links between existing tables. This avoids the need to make one single large tables, allowing you to have multiple small ones where related information crosses lines through links.

### Views
Views show the result sets of data queuries and they can be saved for a future purposes. You can create any number of views, which are set, specified ways of looking at your information.
The types of views you have Avaliable are:
- Grid view (default) - closely resembles a spreadsheet as the records and fields are organized into rows and columns, respectively.
- Calendar view - lets you look at your records with dates in the context of a monthly calendar
- Gallery view - allows you to represent your records as large cards.
- Kanban view - visualise your workflow in a board of stacked cards. Click and drag to move cards between different stacks, or reorder them within a stack.
- Grouped records - show your records grouped together based on one or more fields of your choosing.
- Search views - use the search bar and click on dropdown arrow for the view switcher, you can enter a query in the 'Find a view'

### Fields
Each entry you put in a table is a field. 
There are 16 different field types on Airtable, these are:
- Single line text
- Long text
- File attatchement
- Check boxes
- Single select drop down
- Muliple select drop down
- Date & time
- Phone number
- Email ids
- URLs
- Numbers
- Currency
- Percentage 
- Auto number
- Formulae & barcode

You can hide fields (columns), add filters, and sort record (by column) to orgaise your data and only see what you want to see.

### Records
A record is the base equivalent of a row in a spreadsheet.
You can add, delete, and reorder records.
Forms auto fill the records in your table.

## Git Packages
There are two different packages avaliable. 

https://github.com/bergant/airtabler
https://github.com/jaeseungyum/AirtableR

Both of these packages some with instructions in their README.md which is really useful for beginnners.

I used [Bergants package](https://github.com/bergant/airtabler) and will explain/discuss it in the next slides about extracting data. I will also show my blog as an example which you can always come back to for use.

## Authentication 
After you have created and configurated the schema of a airtable base you can get your standard API key. 
You generate your api key on the [account](https://airtable.com/account) page. 
Your Airtable base will provide its own API to create, read, update, and destroy records. Extra [api docs](https://airtable.com/api).

## Example of extracting the data _(How to use and R interface with Airtable API)_
_This is based on a blog that i wrote when i used the information to extract a winner for our t-shirt draw. To see the full walk through either check out [BLOG.md](BLOG.md) or check it out on the [LockeData Blog](https://itsalocke.com/blog/how-to-use-an-r-interface-with-airtable-api/)_


SET UP
To install devtools all you need to do is run ```install.packages("devtools")```.

Now you need to install [Darko Bergant’s package](https://github.com/bergant/airtabler). ```devtools::install_github("bergant/airtabler")```

Now that you have ```devtools``` and bergant/airtabler installed you need load them into the session to be used ```library(airtabler)```

Next you need to generate the airtable API key from your [Airtable account page](https://airtable.com/account).

RETRIEVE THE DATA AS A DATA.FRAME
To retrieve the data as a data.frame you’ll need your Airtable API key.
```Sys.setenv("AIRTABLE_API_KEY"="<Your API key") #example key**************```

Then you need to add the base that you want to pull the data from.
```airtable <- airtabler::airtable("<base key>", "<Tab/sheet name>") #base key can be found in the API docs```

Now you need to select the data that you want to use - note i selected all.
```airtable <- airtable$`<Tab/sheet name>`$select_all()```

And that is it! You've pulled in and opened all of your data.

### Manage the data with R
If you type ```airtable$'<your tab/sheet>'```You can get a list of functions available for you to play with.
You can: list, retrieve, create, update, and delete records.

In my blog you'll see i used the DPLYR function ```Sample-n()``` to generate a random winner for our t-shirt draw.

### Conclusion 
Airtable is a great thing to use to store all of your different types of data. You do not have to be a super techincal person to be able to intergrate with R and extract the data. This is ideal for those who are techy but also for people like marketers who need to access data for social or want to do a prize draw. Airtable and R work really well together.


