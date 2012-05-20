This is a Drupal Theme for the Software Systems Student Society.

It uses Twitter's Bootstrap to help out with the design.

The styles in this theme are written in LESS, and SASS/SCSS. The LESS part came with Bootstrap. The SASS/SCSS ones were added for additional styling.

## Developing

Be sure you have the following packages installed:

* Node.js
* Ruby
* Gem package manager

Then, you can download the theme via the `git clone` command, like so:

    $ git clone git@github.com:sosy-student-soc/ssss-drupal-theme.git

`cd` to the downloaded repo, and hit the following command:

    $ make configure-all

And it should install all the dependencies.

To actually start editing this project for the sake of developing it, call the following command:

    $ cake watch

And every code you write will be watched for changes, and compiled automatically for you.

However, just calling `cake watch` and then grabbing the output isn't a good idea.

Fortunately, there is a convenient little function in the make file that will take the outputed code, compress it, and place in a `dist` folder for you. And here is that magical command:

    $ make distribute

Take that `dist` folder and share it with your friends.

Of course, just like any other project, you would also want to delete all built files, and start all over. There is a make file function built for that as well.

    $ make clean

