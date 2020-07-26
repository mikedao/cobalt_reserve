# Design Doc
## Intent
Cobalt Reserve is application intended to help players and DMs track a bit more
about what happens in their campaign and and will be sort of a historical
record of a campaign. Designed with a West Marches style campaign in mind,
though this should be adapted to a standard campaign just as well.

### Campaign
Application can track multiple campaigns, and the app determines what campaign
is the active one by looking for the oldest one in the database that is active.
This allows an admin to set up a new campaign while the current one is still
ongoing.
### Users
There is an admin user whose functionality is not implemented yet and a standard
user. A user can have many characters. A user will be able to have full CRUD
over their characters, but they will only be able to do create characters for
their current campaign.
### Characters
A character belongs to a user and belongs to a campaign. A character will
eventually have many items. The intent here is that this app will eventually
track fun stats about users, such as how many times they have fallen
unconscious, how many times they have died and what monsters they have
killed and how many times.
### Items
Items should represent magical items. An item has a many to many relationship
with characters. An item will just have a description to start with at first,
image upload will likely happen later.
### Monsters
App will have an imported database of Monsters with their stats and potentially
images.
