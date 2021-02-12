# transition-agenda
Collaboration around a public engagement toolkit for Mayor Brandon Scott's early-term agenda. 

The purpose of this project is to create a public web page where any Baltimore City resident can easily track the accomplishments of Mayor Scott's first term. Data will be compiled through the transition committees. More broadly, this is a tool any city government can use and adapt to share their progress achieving its commitments to residents on a set timeframe. We invite any local government to reach out to us if they're interested in producing similar public tools.

### Structure & Design

This product uses R Shiny to create a web app that can easily be repurposed for future tracking pages. To create nested tables with expand/collapse buttons, we used Javascript to add additional formatting to the document. For simplicity, we separated the text and content loading into the preset.R document and put the top and bottom banner into the city-content.R document. 

If you're looking to replicate this design, we'd recommend reaching out to your IT department for the HTML code for the top and bottom banner instead of embedding the web app as an iframe. We think that's the better approach because the page has a dynamic page length and you'd otherwise need to make the iframe very long. 

For the survey function on the last page of the document, we used an embedded Google Form for ease of access to respondent information. Icons are from the font-awesome icon set. We also use colors from the Baltimore City style guide, so we'd recommend changing the colors in the preset.R file.

### Translation

We embedded translation functionality into the page by using Google Translate. See more information [here](https://www.w3schools.com/howto/howto_google_translate.asp).

### Publishing

We used shinyapps.io to host the web app. However, we think the Shiny Server open source option is a good approach for those with the ability to host and maintain their own Shiny Server. As part of the publishing approval process, we made an R Markdown document to produce a word document comms staff could use to review and edit text.

### Have Questions?

Feel free to reach out! We're always happy to help other local governments and are big fans of data and transparency. You can email Brendan at brendan.hellweg@baltimorecity.gov.
