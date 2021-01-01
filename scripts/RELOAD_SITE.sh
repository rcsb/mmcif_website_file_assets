#!/bin/bash
# ---
cd /var/www
echo "# Cloning static content for mmCIF website"
git clone https://github.com/rcsb/mmcif_website.git
echo "# Cloning file assets for mmCIF website"
git clone https://github.com/rcsb/mmcif_website_file_assets.git
# ---
# echo "<h1>mmcif</h1>" > /var/www/mmcif_website/mmcif/index.html
# echo "<h1>pdbml</h1>" > /var/www/mmcif_website/pdbml/index.html
chown -R www-data:www-data /var/www/mmcif_website /var/www/mmcif_website_file_assets
# ---
echo "# Generating site content"
/usr/local/bin/site_generator_cli --html   --web_gen_path /var/www/mmcif_website_generated --web_file_assets_path /var/www/mmcif_website_file_assets
#
echo "# Generating image content"
/usr/local/bin/site_generator_cli --images --web_gen_path /var/www/mmcif_website_generated --web_file_assets_path /var/www/mmcif_website_file_assets
#
chown -R www-data:www-data /var/www/mmcif_website_generated
#