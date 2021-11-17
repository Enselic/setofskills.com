jekyll build && aws s3 sync --acl public-read _site s3://beta.setofskills.com
