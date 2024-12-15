#!/bin/bash

HUGO_PROJECT_PATH="/var/www/blog.exampe.com"
HUGO_IMAGE="klakegg/hugo:ext"
PUBLIC_DIR="$HUGO_PROJECT_PATH/public"
SERVER_DIR="/var/www/blog.example.com/public"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Functions
function create_post() {
    echo -e "${GREEN}Creating a new post...${NC}"
    read -p "Enter the title of your post: " title
    slug=$(echo "$title" | tr '[:upper:]' '[:lower:]' | tr -cs '[:alnum:]' '-')
    post_path="posts/${slug}.md"

    docker run --rm -v $HUGO_PROJECT_PATH:/src $HUGO_IMAGE new $post_path
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Post created successfully at: content/$post_path${NC}"
        echo -e "${YELLOW}Opening post for editing...${NC}"
        vim "$HUGO_PROJECT_PATH/content/$post_path"
    else
        echo -e "${RED}Failed to create post.${NC}"
        exit 1
    fi
}

function build_site() {
    echo -e "${GREEN}Building the site...${NC}"
    docker run --rm -v $HUGO_PROJECT_PATH:/src $HUGO_IMAGE --minify
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Site built successfully in $PUBLIC_DIR${NC}"
    else
        echo -e "${RED}Failed to build the site.${NC}"
        exit 1
    fi
}

function deploy_site() {
    echo -e "${GREEN}Deploying the site...${NC}"
    rsync -avz $PUBLIC_DIR/ $SERVER_DIR/
    sudo chown -R www-data:www-data $SERVER_DIR
    sudo chmod -R 755 $SERVER_DIR
    sudo systemctl reload nginx
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Site deployed successfully!${NC}"
    else
        echo -e "${RED}Failed to deploy the site.${NC}"
        exit 1
    fi
}

# Main Menu
echo -e "${GREEN}Hugo Blog Management Script${NC}"
echo "1. Create a new blog post"
echo "2. Build the site"
echo "3. Deploy the site"
echo "4. Create, Build, and Deploy"
echo "5. Exit"
read -p "Choose an option [1-5]: " option

case $option in
    1)
        create_post
        ;;
    2)
        build_site
        ;;
    3)
        deploy_site
        ;;
    4)
        create_post
        build_site
        deploy_site
        ;;
    5)
        echo -e "${YELLOW}Exiting.${NC}"
        exit 0
        ;;
    *)
        echo -e "${RED}Invalid option.${NC}"
        exit 1
        ;;
esac