## MailFilter

Filtering your mail to the correct folder

Inbox zero, yeah!

### Simple dsl
Looks like this:
    
    from => nagios@example.com, in INBOX, to INBOX.Nagios

### Save it in a JSON file

    "Nagios", "from => nagios@example.com, in INBOX, to INBOX.Nagios
