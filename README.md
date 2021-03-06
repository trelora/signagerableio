# Signagerableio

## TRELORA API
Gathers information from my.trelora.com/api (See [trelora_services.rb](https://github.com/trelora/signagerableio/blob/master/app/services/trelora_services.rb)).

## Deploys
`git push heroku master`

# OLD README
## Signagerableio

### TEAM
 - [Sal Espinosa](https://twitter.com/sespinos)
 - [Alex Navarrete](https://twitter.com/salvi6god)
 - [Ryan Workman](https://twitter.com/ProducerWorkman)

Signagerableio is a project assigned by [Trelora](http://www.trelora.com/) (a Real Estate Agency located in Denver) that allows an administrator to control content being displayed on televisions throughout their office. Content is pulled from an internal Trelora API and displayed based on 'roles' assigned by an administrator (currently 'sold' or 'coming soon').

## Features
- Dynamically generates slides to be displayed and fades between two divs in which the slides are rendered

- Admin is manually able to create, edit, delete and preview custom slides of four different formats (headline, title and subtext, subtext only, and custom background image) and select where in the rotation the slides will appear

- Admin is able to manually "refresh" their slides and roles whenever Trelora ends up updating their API.  Refreshing the slides updates the content from the API while leaving the custom slides unchanged

- Admin is able to select the amount of seconds they'd like in between the transition for the slides

-  Heroku scheduler that calls on a rake task that "refreshes" the types of roles and slides that will be displayed on the devices each night

## Demo
![Admin Dashboard](https://media.giphy.com/media/xT8qBbxkfCYDMryhi0/giphy.gif)
![Sold Properties](https://media.giphy.com/media/3o6gEgag4Txrf1mZdC/giphy.gif)
![Coming Soon Properties](https://media.giphy.com/media/xT8qBfsC1njLXXfcvS/giphy.gif)
