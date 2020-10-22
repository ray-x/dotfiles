update all plugin  call dein#update() or call dein#install() 

dein#update()
direct-install      [dein#direct_install] install a plugin directly
              source              [dein#source] :source plugins
              rollback            [dein#rollback] rollback plugins
              update              [dein#update] update a plugin
              check-clean         [dein#check_clean] check unused plugins directories
              clear-state         [dein#clear_state] clear the dein state file
              updates-log         [dein#get_updates_log] show the dein update log
              search              [original] seach vim plugins from GitHub
              recache-runtimepath [dein#recache_runtimepath] re-make runtimepath cache and execute :helptags
              each                [dein#each] execute shell command for each plugins
              check-lazy-plugins  [dein#check_lazy_plugins] check nonsense lazy plugins
              reinstall           [dein#reinstall] reinstall a plugin
              log                 [dein#get_log] show the dein log
              check-install       [dein#check_install] check plugins installation
              install             [dein#install] install a plugin
              check-update        [dein#check_update] check plugins update
              clean               [original] clean plugins directories
              list                [original] print a list of configured bundles


              call dein#add('rhysd/git-messenger.vim', {
            \   'lazy' : 1,
            \   'on_cmd' : 'GitMessenger',
            \   'on_map' : '<Plug>(git-messenger',
            \ })

            call minpac#add('rhysd/git-messenger.vim')

 call dein#recache_runtimepath()

 :echo dein#is_sourced('ale') 

echo dein#is_sourced('nvim-treesitter')
call dein#install() ubstakk a package after update