![Build Status](https://codeship.com/projects/452415e0-e651-0133-fab8-3ed6a847b01d/status?branch=master)
![Code Climate](https://codeclimate.com/github/annaguidi/breaktoy.png)
![Coverage Status](https://coveralls.io/repos/annaguidi/breaktoy/badge.png)

###CityScout

####Description
CityScout is an app I made so that my friends and I can share recommendations with each other. In the app, you can create a group, which contains a blank Google Map instance. You can then invite your friends to join this Group, as well as reject or accept invitations to other groups yourself.
You and your friends can then customize the map by adding Markers onto the Google Map, by clicking on a random point, a Place or by using the Google Search bar. You can add a title and description to the marker, and drag, edit and delete it at any time.
There is a sidebar to the left that shows all markers that have been added in chronological order so that the users of that map stay up to date.

I focused heavily on JavaScript and AJAX. It's still a work in progress and I have many features I want to refine and add. The invite feature is coded in Ruby but I plan on eventually substituting my code with the devise_invitable gem.

#####Features
User Accounts
Profiles with image uploads
CRUD Groups
Geocoder initializes Google Map based on address of Group
Invite other users to join Groups
Accept or Reject Invitations to Groups
CRUD Markers for Groups
Every group has specific Google Map instance with its markers
Add, Delete, Edit and Drag Markers (all handled via AJAX)
Add Marker by clicking on Place, location or using Search Bar
Sidebar that contains titles of all Markers added to group (zooms in on click)


#####Tech Stack
Geocoder
Ruby on Rails
Google Maps API
Google Places Library
AJAX
JavaScript
jQuery
Foundations
Carrierwave w/ Amazon S3
Devise
RSpec and Capybara
