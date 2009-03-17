Esvien
======
Esvien is a simple Ruby interface to Subversion.

    >> head = Esvien::Repo.new("http://svn.collab.net/repos/svn/trunk/").head
    => #<Esvien::Commit id=36632, repo=#<Esvien::Repo uri="http://svn.collab.net/repos/svn/trunk/", uuid="612f8ebc-c883-4be0-9ee0-a4e9ef946e3a">>
    >> head.author
    => "gstein"
    >> head.date
    => Tue Mar 17 17:37:56 UTC 2009
