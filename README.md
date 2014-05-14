Foodlobby
=========
The EcoVillage food-coop uses this to track our households, including their
balance, members, and all their transactions.

Hacking
=======

The easiest way to get started working on this project, is to run it within a
virtual machine. To do that, you first need to install
[VirtualBox](https://www.virtualbox.org/) and [Vagrant](https://vagrantup.com).

The virtual machine we're using uses the vagrant-vbguest plugin.

    localhost> vagrant plugin install vagrant-vbguest
    localhost> vagrant up

This will take a long time, as the virtual machine image downloads and
configures itself.

Once it's done, connect to the machine and install ruby and any required gems.
 
    localhost> vagrant ssh
    vagrant> cd /vagrant
    vagrant> rbenv install
    vagrant> bundle install

Set up the database

    vagrant> bundle exec rake db:setup

At this point the app should be ready to go. You can double check by running
the test suite

    vagrant> bundle exec rake

Start the server and happy hacking!

    vagrant> bundle exec rails server

    localhost> firefox http://localhost:4000

Database
--------
It can be helpful to have a snapshot of the production data to develop against.
To *replace* your local database with a copy of production run this:

    vagrant> script/db_pull

*Note* you will need to be given the appropriate permissions on heroku in order
for this to work.



