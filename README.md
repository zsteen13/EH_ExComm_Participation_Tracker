# Engineering Honors Executive Committee Member Point Tracker
The Member Point Tracker is a website tool that allows for the management of members, their associations with committees, and points earned for attending events.

# Setup

## Preequisites
1. Create a Heroku account
   * This account will access your heroku dyno, from where the app will be served.
2. Create a gmail account
   * This account will be used to send users emails during the signup process, and should therefore have an address indicative of your organization.
   * Setup [2-step verification](https://support.google.com/accounts/answer/185839) for the google account.
   * Create an [app password](https://support.google.com/accounts/answer/185833?hl=en&ref_topic=7189145) for the google account.
3. Create a github account
   * You will need this to clone the repository
4. In order to host on heroku, you must install [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git/) and the [heroku-cli](https://devcenter.heroku.com/articles/heroku-cli#download-and-install).
5. In order to host locally, you must also install [Postgres](https://www.postgresql.org/download/macosx/), [Node.js](https://nodejs.org/en/download/package-manager/#windows), [yarn](https://classic.yarnpkg.com/en/docs/install/#mac-stable), and [bundler](https://bundler.io/).
   

## Host the Application
1. Clone this repository
2. You must overwrite the credentials file to contain your new google account's log in information.
   
   Start by deleting the old credentials file, then opening and closing the credentials file.
   ``` bash
   $ cd ./EH_ExCom_Member_Point_Tracker
   $ rm -f config/credentials.yml.enc
   $ "EDITOR=vim" rails credentials:edit
   ```

   Now, you should enter (press the letter 'i' to start typing in vim) your username and password like so:
   ```
   # aws:
   #   access_key_id: 123
   #   secret_access_key: 345

   # Used as the base secret for all MessageVerifiers in Rails, including the one protecting cookies.
   secret_key_base: 6e739e1e3b0ece790e6bb06c3710eefae49586096b5b88e1ae3b92fc93f62e53d44b59830e620cc35e17a4558dd9692dcc475591f2375ede82ddebb5c5a6443f
   
   gmail_user: <your new email>@gmail.com
   gmail_password: <your new email's app password>
   ```

   Note that your secret_key_base is automatically generated, and should not be the one shown here. You do not need to worry about it, but it does need to remain.

   Once you save this file (press esc, then SHIFT-ZZ or ':wq'-ENTER to save and exi the file in vim) this should create a new file in the config directory, called master.key. Store this value somewhere safe, but DO NOT commit it to the repository.

   In order to test locally, you must store this master key in an environment variable. You can do this on MacOS, Linux, and WindowsSL by adding `export RAILS_MASTER_KEY=<your master key value>` to your `~/.profile` file.

   

   Now that you are done using the master.key file you should delete it.

   

## Running Locally and Testing

To start testing, you must first store the master key from earlier in an environment variable. You can do this on MacOS, Linux, and WindowsSL by adding `export RAILS_MASTER_KEY=<your master key value>` to your `~/.profile` file.

You should run these commands in this order. 

1. $ `yarn`

    Yarn installs our javascript webpackers for rails. If this gives you an error, god help you. But try upgrading yarn with `curl --compressed -o- -L https://yarnpkg.com/install.sh | bash`

2. $ `bundle install`

    Bundle installs our ruby gems. These are the bulk of our dependencies

3. $ `rake reset:db`

    Drops and creates the test and development database, then applies the database schema to the development database only.

4. $ `rake reset:db RAILS_ENV=test`

    Drops, creates, and applies the database schema to the test database.

5. $ `brakeman`
    
    Brakeman will tell you if any changes have caused possible security issues.

6. $ `bundler-audit` 
   
    Bundler-audit checks dependencies with a security registry to make sure that none of our dependencies, nor their dependencies, contain vulnerabilities.

    If you get "command not found", then you must add your gem bin path to your path. To do this:     

    1. $ `gem environment`

    2. Look for "EXECUTABLE DIRECTORY", and copy the path

    3. Add that path to your PATH environment variable. 
     3.1. On MacOS, linux, and windows subsystem for linux, add `PATH=$PATH:/your/path/to/your/bin` to your `~/.profile` file.
     3.2. On windows, hit the windows key, type "environment" and look for the option to change your environment variables. Once in that menu, find the PATH variable, click edit (or something), and add the path fro before to the list.
7. $ `rspec`

##  Heroku Hosting
This application can easily be deployed on Heroku. On a local machine, install the Heroku CLI, and then do $ `heroku login`. Navigate to this apps root and run $ `heroku create` the $ `git push heroku master`. After it finishes, run $ `heroku run rails db:migrate`. The webapp should now be running at the link provided by the terminal. 

Visit this page for more guidance https://devcenter.heroku.com/articles/getting-started-with-rails5.

## Remarks
* The domain this app is hosted on must support https.
