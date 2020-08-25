# plugins

## pathogen

pathogen works with vim pack system

## vim pack system

pack/*/start/$plugin

- auto loaded plugins

pack/*/opt/$plugin

- manually loaded plugins
- `:packadd $plugin`

### management

* Add plugin - `git submodule add $source pack/$dir/start/$plugin`
* Remove plugin - `git submodule deinit pack/$dir/start/$plugin && git rm pack/$dir/start/$plugin && rm -rf .git/modules/pack/$dir/start/$plugin`
* Update plugins - `git submodule update --remote --merge`
* Remember to commit
* Add docs - `vim -u NONE -c "helptags pack/$dir/start/$plugin/doc" -c q`
