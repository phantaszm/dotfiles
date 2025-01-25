# plugins

## vim pack system

auto loaded plugins

`pack/$category/start/$plugin`

manually loaded plugins

`pack/$category/opt/$plugin`

- `:packadd $plugin`

### management

* Add plugin - `git submodule add $source pack/$category/start/$plugin`
* Remove plugin - `git submodule deinit pack/$category/start/$plugin && git rm pack/$category/start/$plugin && rm -rf .git/modules/pack/$category/start/$plugin`
* Update plugins - `git submodule update --remote --merge`
* Remember to commit
* Add docs - `vim -u NONE -c "helptags pack/$category/start/$plugin/doc" -c q`
