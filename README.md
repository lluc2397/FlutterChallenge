# trialing
The Trialing challenge. The overall UI is awful it should be improved. I do not have UX expirience, but it seems to me that the app is easy to use. Very few options so the user should't get lost.
Some data is hardcoded, in the "real app" the data would be fetched from an API so the values can be filled easly from the data processed in the backend and sent in json (Ex: num of stackeholders, money raised, etc...)
 
## Dashboard
The dashboard where the ONG can see the projects, stackeholders and their relative information.

## Widgets
At the begginig the button was with the dashboard, as I wanted to create more widgets (cards) I decided to separate it from the main dashboard as the cards could be reused for other purposes.


## Forms
The part where the ONG can add a new project or stackeholder to the DB

Projects and Stackholders could be in seperated folders to make easier the management of the forms and views for the possibles differents actions. In a backend like django, each model (project and stackeholder) could have other related models that could be in the same app so it would be better to separate these logics. (Ex: Views for creating, updating, retreiving and deleting each one).

For the moment as we just need to create them, the two forms are together.

## Data
Dummy parameters to be able to work locally

The sqflite is for working locally with the database
The http library allows us to interact with the urls.

### Notes
- stateless: no dynamic data
- build: return widget, called when we need te rebuild the ui (ex: data changes)
- scaffold: visual layout
- builder: funct map list of data to list of widgets
- stateful: dynamic data
- sate: data that changes
- const: elements can't be changed
- final == const (js)

#### DB schema
##### - Project:
    - name : charfield
    - web : urlfield
    - descrp : textfield
    - img : imageField 
    - budget : decimalField 
    - closing date : dateTimeField
    - is open : Booleanfield (should be implemented in the backend. If current date > closing date, is_open == False)

##### - Stackeholder
    - fullname : charfield 
    - email : emailField 
    - web : urlfield 
    - projecs founded : M2M (related to projects)
    - amount : decimalField 