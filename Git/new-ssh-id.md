https://stackoverflow.com/questions/11656134/github-deploy-keys-how-do-i-authorize-more-than-one-repository-for-a-single-mac?rq=1
https://snipe.net/2013/04/11/multiple-github-deploy-keys-single-server/

1) Enter this command(You'll do this for however many keys you need):

    ssh-keygen -t rsa -C "your_email@example.com"

2) When prompted with the the statement below type in a unique name (i.e., 
   foo1_rsa). The file will be created in your current directory and you 
   may need to move it to .ssh if you want to be tidy:

    Enter file in which to save the key (/Users/you/.ssh/id_rsa): [Press enter]

3) Update your SSH config file:

    gedit ~/.ssh/config

Which may be empty:

    Host cheech github.com
    Hostname github.com
    IdentityFile ~/.ssh/foo1_rsa

    Host chong github.com
    Hostname github.com
    IdentityFile ~/.ssh/foo2_rsa

---------------------------------
----- Example ~/.ssh/config -----
---------------------------------

Host jondeuce-github github.com
Hostname github.com
IdentityFile ~/.ssh/jondeuce_github_id

Host jondeuce-gitlab gitlab.com
Hostname gitlab.com
IdentityFile ~/.ssh/jondeuce_gitlab_id