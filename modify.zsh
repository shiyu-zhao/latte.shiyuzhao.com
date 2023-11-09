#!/bin/zsh

# HTML
FILE_PATH="LatteHomepage.html"
cp $FILE_PATH "${FILE_PATH}.bak"

# Use sed to perform the replacements
sed -i '' 's|<title>Landing page template - Webflow HTML website template</title>|<title>Latte the Border Collie</title>|g' $FILE_PATH
sed -i '' 's|href="https://latte-the-border-collie.webflow.io/|href="https://latte.shiyuzhao.com/|g' $FILE_PATH
# Remove the <a> tag with class "w-webflow-badge" even if it is on multiple lines
perl -i -0pe 's|<a class="w-webflow-badge".*?<\/a>||gs' $FILE_PATH
echo "Modified: $FILE_PATH"
echo "All applicable HTML files have been modified."


# JS
DIRECTORY="./LatteHomepage_files"
# Search for JavaScript files containing "shouldBrand = true;" and then replace it with "shouldBrand = false;"
grep -rl 'shouldBrand = true;' $DIRECTORY --include="*.js" | while read FILE; do
    sed -i '' 's/shouldBrand = true;/shouldBrand = false;/g' "$FILE"
    echo "Modified: $FILE"
done
echo "All applicable JavaScript files have been modified."

# TODO - need to change all img srcset files to be using my own srcset images.

echo "Modifications complete."

# Publish
rm -rf ./public/
mkdir ./public/
cp $FILE_PATH ./public/index.html
cp -r $DIRECTORY ./public/$DIRECTORY
cp latte_preview.jpg ./public/