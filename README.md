#docker-otrs-webservice

Simple [OTRS 5 Free](https://www.otrs.com/software/) docker container orchestration to facilitate integration testing the OTRS free SOAP Ticket interface.

##Build

Clone this repo, then:

    cd docker-otrs-webservice
    sudo docker-compose build

##Run

    docker-compose up

##Notes

This is not intended to be a fully functioning OTRS 5 Free installation, so dont try to use this to run/evaluate OTRS using Docker. If you want to do this, juanluisbaptiste has a pretty good [unofficial OTRS 5 Free image](https://hub.docker.com/r/juanluisbaptiste/otrs/) over on [DOcker Hub](https://hub.docker.com/) It merely provides enough of OTRS to allow integration testing the SOAP Service.

##Thanks

* Jean Luis Baptiste for the OTRS 5 docker image.
* Johannes  Nickel at Znuny for providing me with the Dockerfiles Znuny use for their OTRS integration testing.
* Michiel Beijen and Martin Gruner at OTRS for their help with configuring OTRS without using the web installer.
