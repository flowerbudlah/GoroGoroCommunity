<h3>📝 Portfolio Overview</h3>
GoroGoro Community(고로고로, ゴロゴロ) is a full-stack web application developed as a personal project to demonstrate my skills in both front-end and back-end development.
<h3>🏠 URL: https://gorogorocommunity-production.up.railway.app/</h3>
<h3>🕒 Development time</h3>
July 21, 2022 ~ late March 2023 (around 8 months). <br>
After that, the project underwent maintenance and feature enhancements through 2025, and web hosting deployment was completed in late April 2025.<br>
<h3>🔧 Tech Stack</h3>
1. Front-End: JSP, HTML, CSS, Bootstrap, jQuery<br>
2. Back-End: Spring MVC Java, JSP<br>
3. Database: MySQL Workbench 8.0 CE<br>
4. Deployment: Docker, Railway<br>
5. Tools: Eclipse IDE for Enterprise Java and Web Developers - 2021-03, Maven, GitHub, Git<br>
<h3>💡 Key Features</h3>
1. Admin and user login system<br>
2. Image upload via local and server environments<br>
3. Bulletin board with post and reply (threaded comment) features<br>
4. Responsive design using Bootstrap carousel and cards<br>
5. When logged in as an administrator, the admin can create, modify, and delete categories on any topic, <br>as well as the boards within those categories.<br>
6. Regular users can report other users who post inappropriate content or leave malicious comments.<br>
7. Administrators have the authority to suspend users who violate the rules, preventing them from logging in for a certain period.<br>
<br>
This project was designed to simulate a small-scale community platform. Through this application, I aimed to strengthen my understanding of MVC architecture, session management, and deployment using Docker containers on cloud platforms.<br><br>
<h3>🛠️Upcoming Feature</h3>
Currently, when a request is made after the session has expired (i.e., the user is logged out), the server fails to handle it properly and returns an HTTP 500 Internal Server Error. This issue will be addressed by improving the system so that, in the future, users will be automatically redirected to the login page instead of seeing an error page when their session has expired.
