# Emperor of Gaming - Blog
This first project, realized to be published on the school's Apache Tomcat server, is based on the idea of having a dynamic blog where you can read the latest news about videogames.


## Realizzazione
### Tools Used
Below are the tools I used to build the project:

- Adobe Dreamworks, used mainly to create in real-time the UI;
- Jetbrains IntelliJ IDEA Ultimate, used to build the core of the project so all the features written in Java;
- GitHub, used to organize, keep track of changes, and have a backup of the project


### Struttura del progetto
The project is structured as follows:

- Distribution, which contains the "compiled" or more compact version of the website;
- Source code, where there is the complete code of the landing page, like the full css;
- Landing-Glassfish, which is the complete version of the website made using Servlets, JSPs, etc..

Both folders have the following structure:
- assets, contains all files that are not web pages
    - css, contains the various css files used
    - images, here are all the photos used on the website
    - js, contains the various javascripts but in this case only the darkmode system
    - third-party, contains all third-party JavaScript and CSS libraries

- pages, contains all html pages
    - blog, here are all the pages related to the blog
        - posts, in this folder there are all blog posts


The Landing-Glassfish folder have the following structure:
- backup, contains a backup of the blog posts that then have been moved on the database;
- src, contains the source code;
	- main
		- java, contains all the Java files (mostly Servlets);
		- webapp, has all the HTML, CSS, JS and images used in the projct;



### Librerie di terze parti
The following are the css and javascript libraries used on the website:

- Animated.css (https://animate.style/), for animations
- Bootstrap (https://getbootstrap.com/), for responsive and some add-ons
- Font Awesome (https://fontawesome.com/), for icons
- Isotope (https://isotope.metafizzy.co/), for some layouts and grids
- JQuery (https://jquery.com/), for some JavaScript features
- Owl Carousel (https://owlcarousel2.github.io/OwlCarousel2/), for the slider in the homepage