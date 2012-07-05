[![Build Status](https://secure.travis-ci.org/dcadenas/gmail_sender.png?branch=master)](http://travis-ci.org/dcadenas/gmail_sender)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/dcadenas/gmail_sender)
[![endorse](http://api.coderwall.com/dcadenas/endorsecount.png)](http://coderwall.com/dcadenas)

gmail_sender
============

A simple gem to send email through gmail

```ruby
require 'gmail_sender'

g = GmailSender.new("gmail_account_user_name", "gmail_account_password")
# you can attach any number of files, but there are limits for total attachments size
g.attach('/path/to/document.hz')
g.send(:to => "someone@domain.com",
       :subject => "The subject",
       :content => "The mail body")
```

Notice that the `:to` key accepts an email array so you can send the message to many receivers.
You can specify the content type which is `text/plain` by default.

```ruby
g.send(:to => "someone@domain.com",
       :subject => "The subject",
       :content => "<img src='http://upload.wikimedia.org/wikipedia/en/0/0d/Simpsons_FamilyPicture.png'/>",
       :content_type => 'text/html')
```

To use your google apps domain instead of gmail.com include the complete sender email instead of just the user name:

```ruby
g = GmailSender.new("gmail_account_user_name@yourdomain.com", "gmail_account_password")
```

Command line usage
------------------

You can also use gmail_sender from the command line. First you need to create `~/.gmail` with this content (YAML):

```yaml
receiver_email: default_receiver@gmail.com
sender_user: gmail_account_user_name
sender_password: gmail_account_password
```

Is advisable to use a different sender account than your main email address so that it's not so bad if someone reads your configuration file and gets your password.

### Examples

To send your directory list to the default receiver:

```bash
ls | gmail
```

You can specify some parameters like in this example which doesn't use pipes:

```bash
gmail -t hansel@gmail.com gretel@hotmail.com -s "the subject" -c "the content"
```

You can send attachments by using the -a option (this example assumes that you have a receiver_email set in the `~/.gmail` file so the `-t` is not needed):

```bash
gmail -c "the attachments" -a ./VERSION ./gmail_sender.gemspec
```

To send html content use the ct option

```bash
gmail -c "<img src='http://host/image.png'/>" -ct text/html
```

Installation
------------

```bash
gem install gmail_sender
```

Requirements
------------

tlsmail if running Ruby 1.8.6

Major contributors
------------------

* Daniel Cadenas - Maintainer
* Felipe Coury
* iwakura
* saks
* elcuervo
