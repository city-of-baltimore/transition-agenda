# transition-agenda
Collaboration around a public engagement toolkit for Mayor Brandon Scott's early-term agenda. 

Link to 100 Day Tracker:
https://docs.google.com/spreadsheets/d/1lkTa3zDSJ-aO0c0XxfocQP0cGPRQr68YYYwYPPBp3qo/edit?usp=sharing

The purpose of this project is to create a public web page where any Baltimore City resident can easily track the accomplishments of Mayor Scott's first term. Data will be compiled through the transition committees. More broadly, this is a tool any city government can use and adapt to share their progress achieving its commitments to residents on a set timeframe. We invite any local government to reach out to us if they're interested in producing similar public tools.

### Structure

This product uses R Shiny to create a web app that can easily be repurposed for future tracking pages. To create nested tables with expand/collapse buttons, we used Javascript to add additional formatting to the document. For simplicity, we separated the text and content loading into the preset.R document and put the top and bottom banner into the city-content.R document.

For the survey function on the last page of the document, we used an embedded Google Form for ease of access to respondent information. Icons are from the font-awesome icon set.

### Translation

For page translation, we used the shiny.i18n package. First, we used Google Sheets to host and edit text, using the googletranslate function to provide Spanish, French, Korean, and Mandarin translations for each aciton. Next, we used the translate-files.R sheet to produce csv documents that work well with shiny.i18n. Finally, we used the shiny.i18n package to provide alternative text for each language selection.

### Publishing

We used shinyapps.io to host the web app. However, we think the Shiny Server open source option is a good approach for those with the ability to host and maintain their own Shiny Server. As part of the publishing approval process, we made an R Markdown document to produce a word document comms staff could use to review and edit text.
