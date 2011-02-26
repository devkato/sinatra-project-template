How to setup.

[pre-requirements]
ruby 1.9.2
bundler 1.0.10

1. run the command below.
bundle install --path vendor/bundle --binstubs

2. run thin
./bin/thin start -C config/thin.yml

done!

