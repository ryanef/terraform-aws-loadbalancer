#!/bin/bash

sudo apt update


sudo apt install -y nginx


echo "<html>
<head>
    <title>Welcome to My Website</title>
</head>
<body>
    <h1>Hello, this is a basic Nginx setup!</h1>
    <p>This page is served by Nginx.</p>
</body>
</html>" | sudo tee /var/www/html/index.html


sudo systemctl restart nginx

