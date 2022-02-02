#!/bin/bash
# ---
cd /var/www
echo "# Cloning static content for mmCIF website"
if [ -e mmcif_website ]; then
    cd mmcif_website
    git pull
    cd ..
else
    git clone https://github.com/rcsb/mmcif_website.git
fi

echo "# Cloning file assets for mmCIF website"
if [ -e mmcif_website_file_assets ]; then
    cd mmcif_website_file_assets
    git pull
    cd ..
else
    git clone https://github.com/rcsb/mmcif_website_file_assets.git
fi

# ---
chown -R www-data:www-data /var/www/mmcif_website /var/www/mmcif_website_file_assets
# ---
#
echo "# Generating image content"
/usr/local/bin/site_generator_cli --images --web_gen_path /var/www/mmcif_website_generated --web_file_assets_path /var/www/mmcif_website_file_assets
#
echo "# Generating site content"
/usr/local/bin/site_generator_cli --html   --web_gen_path /var/www/mmcif_website_generated --web_file_assets_path /var/www/mmcif_website_file_assets
#
echo "# Update search indices"
/var/www/mmcif_website/mmcif_cgi/swish/MakeIndices.sh
#
chown -R www-data:www-data /var/www/mmcif_website_generated
#
