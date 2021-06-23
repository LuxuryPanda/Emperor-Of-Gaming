use DB_BORYSLAVR;

drop table if exists Utente_Blog;
drop table if exists Post_Blog;

CREATE TABLE Utente_Blog (
	UserID int not null auto_increment primary key,
    Username varchar(128) not null,
    UserPassword varchar(128) not null,
    Email varchar(255) not null,
    Nome varchar(64) default null,
    Cognome varchar(64) default null,
    Codice2FA int default null,
    Admin boolean default false
);

SELECT * FROM DB_BORYSLAVR.Utente_Blog;

CREATE TABLE Post_Blog (
	PostID int not null auto_increment primary key, 
    Autore varchar(128) not null references Utente_Blog(Nome),
    Titolo varchar(128) not null,
    DataPubb varchar(50) not null,
    DescrizioneCard text not null,
    Descrizione text not null,
    Immagine text not null
);

SELECT * FROM Post_Blog;