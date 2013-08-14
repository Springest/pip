# Pip - An Alfred Workflow for Pipeline Deals

Pip is a Pipeline Deals workflow for Alfred 2. You can manage the
Notes/Activities and Tasks with it for Companies, People and Deals:

## Get Started

Find your API key in [Account Settings > API] and use it to configure
Pip, right from Alfred:

`pipconfig <paste your api key>`

Now you can start using Pip. Check out the commands and what they do.

## Commands

You can create Notes or Activities and Tasks. Both of these are not much
use if you do not link them to either a Company, Person or Deal of
course, so you will have to provide them. But that is easy with Pip! It
has built-in search for Companies, People and Deals to make it easy to
match their names. Check it out.

### Notes or Activities

To create a Note for a Company use this:

`pip company note Apple This company could be a major opportunity for
us.`

Or the shorter version:

`pip cn Apple This company could be a major opportunity for us.`

In this example, the company name is easy enough to type in full, but
consider you want to add a task for a company called Rackspace UK. You
can use only part of the name and Pip will match it for you!

`pip cn Rack This could be a great place to do our hosting!`

See? Pip will search for companies that match Rack and ask you which one
you want to add the note to. This works the same for Deals:

`pip deal note mediapartner Check our API docs before following this up`

Or the shorter version:

`pip dn mediapartner Check our API docs before following this up`

And likewise for People:

`pip personal note Steve He likes cognac`

And in short:

`pip pn Steve He likes cognac`

Pip will find all people called Steve and you can choose the one that
you need.

## Tasks

Tasks belong to the same entities: Companies, Deals or People and the
can have a due date if you want, it is optional. Let's create some
tasks!

`pip company task Springest Check out their website.`

Will create a task without a due date on the [Springest] company. There
is a short version for this as well, for your convenience:

`pip ct Springest Check out their website`

The same works for Deals:

`pip deal task mediapartner Send API docs`

Or short:

`pip dt mediapartner Send API docs`

And for People:

`pip personal task Jane Call about contracts`

and, again, short:

`pip pt Jane Call about contracts`

### Due dates for tasks

You can add a fuzzy due date at the end of all of the task commands:

`pip pt Jane Call about contracts @tomorrow`

All time options:

- `@today` - Due today
- `@tomorrow` - Due tommorrow
- `@week` - Due next week
- `@mon` - Due next monday
- `@tue` - Due next tuesday
- `@wed` - Due next wednesday
- `@thu` - Due next thursday
- `@fri` - Due next friday

And for the workaholics:

- `@sat` - Due next saturday
- `@sun` - Due next sunday

That is all. Enjoy!
