# AV Vehicle Maker Reskiner Pack
Configuration interface for reskiners

# IT'S A CONFIGURATION EXTENSION FOR AV VEHICLE MAKER, REMOVE IT FROM YOUR SERVER WHEN YOU'VE ADDED YOUR VEHICLES

## Install
- Download the main branch (you're already on the main branch by default)
- Extract the addon in your server/game's addons folder

## How to add a vehicle
- Spawn the vehicle you wan't to reskin
- Set the bodygroups on the vehicle (optional)
- Enter in the vehicle
- Type !addvehicle in the chat
- Enter the asked informations in the panel and Click on the confirm button
- Copy the given code and add it on your vehicle's list

## How to add a vehicle on your vehicle's list
### You downloaded the addon from github
- Go on av-vehicle-maker\lua\av-vehicle-maker
- Open sh_configuration.lua
- Add the given code below the commentary

### You downloaded the addon from the workshop
- Create a new folder in your addons folder (do not put caps or spaces in the addon's name)
- Create a lua in the folder you created
- Create an autorun folder in the lua folder
- Create a file named sh_avvehmaker-config.lua in the autorun folder (you'll put all your vehicle's code in this file)
- Put the given code in the file