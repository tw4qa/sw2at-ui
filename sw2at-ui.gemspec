# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: sw2at-ui 0.0.5 ruby lib

Gem::Specification.new do |s|
  s.name = "sw2at-ui"
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Vitaly Tarasenko"]
  s.date = "2015-06-23"
  s.description = " Control your tests, run them parallel. Check statuses of your revisions online. Share results to all team members. "
  s.email = "vetal.tarasenko@gmail.com"
  s.executables = ["rails"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "app/assets/images/swat/loading-green.gif",
    "app/assets/javascripts/swat/.bowerrc",
    "app/assets/javascripts/swat/app/app.coffee",
    "app/assets/javascripts/swat/app/controllers/revision.coffee",
    "app/assets/javascripts/swat/app/controllers/revisions.coffee",
    "app/assets/javascripts/swat/app/controllers/root.coffee",
    "app/assets/javascripts/swat/app/factories/response.coffee",
    "app/assets/javascripts/swat/app/factories/revision_model.coffee",
    "app/assets/javascripts/swat/app/services/revision.coffee",
    "app/assets/javascripts/swat/app/services/test_case.coffee",
    "app/assets/javascripts/swat/application.coffee",
    "app/assets/javascripts/swat/bower.json",
    "app/assets/javascripts/swat/bower_components.coffee",
    "app/assets/javascripts/swat/bower_components/angular-animate/angular-animate.js",
    "app/assets/javascripts/swat/bower_components/angular-animate/angular-animate.min.js",
    "app/assets/javascripts/swat/bower_components/angular-aria/angular-aria.js",
    "app/assets/javascripts/swat/bower_components/angular-aria/angular-aria.min.js",
    "app/assets/javascripts/swat/bower_components/angular-bootstrap/ui-bootstrap-csp.css",
    "app/assets/javascripts/swat/bower_components/angular-bootstrap/ui-bootstrap-tpls.js",
    "app/assets/javascripts/swat/bower_components/angular-bootstrap/ui-bootstrap-tpls.min.js",
    "app/assets/javascripts/swat/bower_components/angular-bootstrap/ui-bootstrap.js",
    "app/assets/javascripts/swat/bower_components/angular-bootstrap/ui-bootstrap.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/LICENSE.txt",
    "app/assets/javascripts/swat/bower_components/angular-material/angular-material.css",
    "app/assets/javascripts/swat/bower_components/angular-material/angular-material.js",
    "app/assets/javascripts/swat/bower_components/angular-material/angular-material.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/angular-material.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/backdrop/backdrop-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/backdrop/backdrop.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/backdrop/backdrop.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/bottomSheet/bottomSheet-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/bottomSheet/bottomSheet.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/bottomSheet/bottomSheet.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/button/button-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/button/button.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/button/button.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/card/card-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/card/card.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/card/card.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/checkbox/checkbox-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/checkbox/checkbox.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/checkbox/checkbox.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/content/content-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/content/content.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/content/content.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/core/core.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/core/core.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/core/default-theme.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/dialog/dialog-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/dialog/dialog.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/dialog/dialog.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/divider/divider-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/divider/divider.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/divider/divider.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/icon/icon.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/icon/icon.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/input/input-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/input/input.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/input/input.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/list/list.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/list/list.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/menu/menu.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/menu/menu.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/progressCircular/progressCircular-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/progressCircular/progressCircular.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/progressCircular/progressCircular.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/progressLinear/progressLinear-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/progressLinear/progressLinear.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/progressLinear/progressLinear.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/radioButton/radioButton-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/radioButton/radioButton.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/radioButton/radioButton.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/sidenav/sidenav-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/sidenav/sidenav.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/sidenav/sidenav.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/slider/slider-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/slider/slider.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/slider/slider.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/sticky/sticky.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/sticky/sticky.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/subheader/subheader-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/subheader/subheader.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/subheader/subheader.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/swipe/swipe.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/switch/switch-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/switch/switch.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/switch/switch.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/tabs/tabs-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/tabs/tabs.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/tabs/tabs.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/textField/textField-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/textField/textField.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/textField/textField.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/toast/toast-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/toast/toast.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/toast/toast.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/toolbar/toolbar-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/toolbar/toolbar.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/toolbar/toolbar.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/tooltip/tooltip-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/tooltip/tooltip.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/tooltip/tooltip.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/whiteframe/whiteframe.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/closure/whiteframe/whiteframe.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/css/angular-material-layout.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/backdrop/backdrop-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/backdrop/backdrop-default-theme.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/backdrop/backdrop.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/backdrop/backdrop.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/backdrop/backdrop.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/backdrop/backdrop.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/backdrop/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/bottomSheet/bottomSheet-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/bottomSheet/bottomSheet-default-theme.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/bottomSheet/bottomSheet.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/bottomSheet/bottomSheet.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/bottomSheet/bottomSheet.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/bottomSheet/bottomSheet.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/bottomSheet/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/button/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/button/button-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/button/button-default-theme.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/button/button.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/button/button.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/button/button.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/button/button.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/card/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/card/card-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/card/card-default-theme.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/card/card.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/card/card.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/card/card.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/card/card.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/checkbox/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/checkbox/checkbox-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/checkbox/checkbox-default-theme.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/checkbox/checkbox.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/checkbox/checkbox.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/checkbox/checkbox.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/checkbox/checkbox.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/content/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/content/content-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/content/content-default-theme.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/content/content.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/content/content.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/content/content.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/content/content.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/core/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/core/core.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/core/core.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/core/core.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/core/core.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/core/default-theme.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/dialog/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/dialog/dialog-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/dialog/dialog-default-theme.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/dialog/dialog.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/dialog/dialog.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/dialog/dialog.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/dialog/dialog.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/divider/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/divider/divider-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/divider/divider-default-theme.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/divider/divider.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/divider/divider.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/divider/divider.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/divider/divider.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/icon/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/icon/icon.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/icon/icon.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/icon/icon.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/icon/icon.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/input/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/input/input-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/input/input-default-theme.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/input/input.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/input/input.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/input/input.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/input/input.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/list/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/list/list.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/list/list.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/list/list.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/list/list.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/menu/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/menu/menu.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/menu/menu.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/menu/menu.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/menu/menu.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/progressCircular/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/progressCircular/progressCircular-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/progressCircular/progressCircular-default-theme.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/progressCircular/progressCircular.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/progressCircular/progressCircular.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/progressCircular/progressCircular.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/progressCircular/progressCircular.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/progressLinear/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/progressLinear/progressLinear-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/progressLinear/progressLinear-default-theme.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/progressLinear/progressLinear.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/progressLinear/progressLinear.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/progressLinear/progressLinear.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/progressLinear/progressLinear.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/radioButton/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/radioButton/radioButton-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/radioButton/radioButton-default-theme.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/radioButton/radioButton.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/radioButton/radioButton.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/radioButton/radioButton.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/radioButton/radioButton.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/sidenav/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/sidenav/sidenav-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/sidenav/sidenav-default-theme.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/sidenav/sidenav.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/sidenav/sidenav.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/sidenav/sidenav.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/sidenav/sidenav.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/slider/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/slider/slider-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/slider/slider-default-theme.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/slider/slider.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/slider/slider.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/slider/slider.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/slider/slider.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/sticky/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/sticky/sticky.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/sticky/sticky.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/sticky/sticky.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/sticky/sticky.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/subheader/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/subheader/subheader-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/subheader/subheader-default-theme.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/subheader/subheader.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/subheader/subheader.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/subheader/subheader.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/subheader/subheader.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/swipe/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/swipe/swipe.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/swipe/swipe.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/switch/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/switch/switch-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/switch/switch-default-theme.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/switch/switch.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/switch/switch.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/switch/switch.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/switch/switch.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/tabs/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/tabs/tabs-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/tabs/tabs-default-theme.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/tabs/tabs.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/tabs/tabs.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/tabs/tabs.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/tabs/tabs.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/textField/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/textField/textField-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/textField/textField-default-theme.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/textField/textField.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/textField/textField.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/textField/textField.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/textField/textField.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/toast/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/toast/toast-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/toast/toast-default-theme.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/toast/toast.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/toast/toast.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/toast/toast.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/toast/toast.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/toolbar/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/toolbar/toolbar-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/toolbar/toolbar-default-theme.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/toolbar/toolbar.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/toolbar/toolbar.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/toolbar/toolbar.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/toolbar/toolbar.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/tooltip/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/tooltip/tooltip-default-theme.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/tooltip/tooltip-default-theme.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/tooltip/tooltip.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/tooltip/tooltip.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/tooltip/tooltip.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/tooltip/tooltip.min.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/whiteframe/bower.json",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/whiteframe/whiteframe.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/whiteframe/whiteframe.js",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/whiteframe/whiteframe.min.css",
    "app/assets/javascripts/swat/bower_components/angular-material/modules/js/whiteframe/whiteframe.min.js",
    "app/assets/javascripts/swat/bower_components/angular-resource/angular-resource.js",
    "app/assets/javascripts/swat/bower_components/angular-resource/angular-resource.min.js",
    "app/assets/javascripts/swat/bower_components/angular-resource/index.js",
    "app/assets/javascripts/swat/bower_components/angular-route/angular-route.js",
    "app/assets/javascripts/swat/bower_components/angular-route/angular-route.min.js",
    "app/assets/javascripts/swat/bower_components/angular-route/index.js",
    "app/assets/javascripts/swat/bower_components/angular-ui-router/LICENSE.txt",
    "app/assets/javascripts/swat/bower_components/angular-ui-router/api/angular-ui-router.d.ts",
    "app/assets/javascripts/swat/bower_components/angular-ui-router/release/angular-ui-router.js",
    "app/assets/javascripts/swat/bower_components/angular-ui-router/release/angular-ui-router.min.js",
    "app/assets/javascripts/swat/bower_components/angular-ui-router/src/common.js",
    "app/assets/javascripts/swat/bower_components/angular-ui-router/src/resolve.js",
    "app/assets/javascripts/swat/bower_components/angular-ui-router/src/state.js",
    "app/assets/javascripts/swat/bower_components/angular-ui-router/src/stateDirectives.js",
    "app/assets/javascripts/swat/bower_components/angular-ui-router/src/stateFilters.js",
    "app/assets/javascripts/swat/bower_components/angular-ui-router/src/templateFactory.js",
    "app/assets/javascripts/swat/bower_components/angular-ui-router/src/urlMatcherFactory.js",
    "app/assets/javascripts/swat/bower_components/angular-ui-router/src/urlRouter.js",
    "app/assets/javascripts/swat/bower_components/angular-ui-router/src/view.js",
    "app/assets/javascripts/swat/bower_components/angular-ui-router/src/viewDirective.js",
    "app/assets/javascripts/swat/bower_components/angular-ui-router/src/viewScroll.js",
    "app/assets/javascripts/swat/bower_components/angular/angular-csp.css",
    "app/assets/javascripts/swat/bower_components/angular/angular.js",
    "app/assets/javascripts/swat/bower_components/angular/angular.min.js",
    "app/assets/javascripts/swat/bower_components/angular/index.js",
    "app/assets/javascripts/swat/bower_components/lodash/lodash.js",
    "app/assets/javascripts/swat/bower_components/lodash/lodash.min.js",
    "app/assets/javascripts/swat/bower_components/ng-clip/.editorconfig",
    "app/assets/javascripts/swat/bower_components/ng-clip/.gitignore",
    "app/assets/javascripts/swat/bower_components/ng-clip/Gruntfile.js",
    "app/assets/javascripts/swat/bower_components/ng-clip/dest/ng-clip.min.js",
    "app/assets/javascripts/swat/bower_components/ng-clip/example/bootstrap-tooltip.html",
    "app/assets/javascripts/swat/bower_components/ng-clip/example/index.html",
    "app/assets/javascripts/swat/bower_components/ng-clip/example/ng-repeat.html",
    "app/assets/javascripts/swat/bower_components/ng-clip/npm-debug.log",
    "app/assets/javascripts/swat/bower_components/ng-clip/src/ngClip.js",
    "app/assets/javascripts/swat/bower_components/zeroclipboard/dist/.jshintrc",
    "app/assets/javascripts/swat/bower_components/zeroclipboard/dist/ZeroClipboard.Core.js",
    "app/assets/javascripts/swat/bower_components/zeroclipboard/dist/ZeroClipboard.Core.min.js",
    "app/assets/javascripts/swat/bower_components/zeroclipboard/dist/ZeroClipboard.js",
    "app/assets/javascripts/swat/bower_components/zeroclipboard/dist/ZeroClipboard.min.js",
    "app/assets/javascripts/swat/bower_components/zeroclipboard/dist/ZeroClipboard.swf",
    "app/assets/stylesheets/swat/application.sass",
    "app/assets/stylesheets/swat/default-theme.css",
    "app/assets/stylesheets/swat/font-awesome.css",
    "app/assets/stylesheets/swat/fonts/FontAwesome.otf",
    "app/assets/stylesheets/swat/fonts/fontawesome-webfont.eot",
    "app/assets/stylesheets/swat/fonts/fontawesome-webfont.svg",
    "app/assets/stylesheets/swat/fonts/fontawesome-webfont.ttf",
    "app/assets/stylesheets/swat/fonts/fontawesome-webfont.woff",
    "app/assets/stylesheets/swat/fonts/fontawesome-webfont.woff2",
    "app/assets/stylesheets/swat/swat_theme.sass",
    "app/controllers/swat/api/revisions_controller.rb",
    "app/controllers/swat/api/test_cases_controller.rb",
    "app/controllers/swat/application_controller.rb",
    "app/controllers/swat/info/states_controller.rb",
    "app/controllers/swat/pages/base_pages_controller.rb",
    "app/controllers/swat/pages/revisions_controller.rb",
    "app/controllers/swat/revisions_controller.rb",
    "app/helpers/swat/application_helper.rb",
    "app/models/concerns/root_revision_ext.rb",
    "app/models/full_revision.rb",
    "app/models/revision.rb",
    "app/models/revision_status_calculator.rb",
    "app/models/test_case.rb",
    "app/views/layouts/swat/application.slim",
    "app/views/layouts/swat/page.slim",
    "app/views/swat/application/index.slim",
    "app/views/swat/pages/revisions/index.slim",
    "app/views/swat/pages/revisions/show.slim",
    "app/views/swat/shared/_footer.slim",
    "app/views/swat/shared/_header.slim",
    "bin/rails",
    "config/routes.rb",
    "fixtures/firebase_collection.rb",
    "lib/sw2at-ui.rb",
    "lib/swat/engine.rb",
    "lib/swat/ui/config.rb",
    "lib/swat/ui/generators/install_generator.rb",
    "lib/swat/ui/generators/templates/initializer.rb",
    "lib/swat/ui/rspec_commands.rb",
    "lib/swat/ui/rspec_setup.rb",
    "lib/swat/ui/stats_collector.rb",
    "lib/swat/ui/version.rb",
    "lib/tasks/swat_tasks.rake",
    "spec/lib/commands_spec.rb",
    "spec/models/calculator_spec.rb",
    "spec/models/full_revision_spec.rb",
    "spec/models/revision_spec.rb",
    "spec/models/testcase_spec.rb",
    "spec/spec_helper.rb",
    "sw2at-ui.gemspec",
    "test/helper.rb",
    "test/test_sw2at-ui.rb"
  ]
  s.homepage = "http://github.com/tw4qa/sw2at-ui"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "Gem displays RSpec tests with a beatufil UI inside of your Rails application"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.1"])
      s.add_runtime_dependency(%q<fire-model>, ["~> 0.0.15"])
      s.add_runtime_dependency(%q<slim-rails>, [">= 0"])
      s.add_runtime_dependency(%q<sass-rails>, [">= 0"])
      s.add_runtime_dependency(%q<coffee-rails>, [">= 0"])
      s.add_runtime_dependency(%q<bootstrap-sass>, [">= 0"])
      s.add_runtime_dependency(%q<tarvit-helpers>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<rspec>, ["~> 3.2"])
      s.add_development_dependency(%q<pry>, ["~> 0.10.1"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 3.1"])
      s.add_dependency(%q<fire-model>, ["~> 0.0.15"])
      s.add_dependency(%q<slim-rails>, [">= 0"])
      s.add_dependency(%q<sass-rails>, [">= 0"])
      s.add_dependency(%q<coffee-rails>, [">= 0"])
      s.add_dependency(%q<bootstrap-sass>, [">= 0"])
      s.add_dependency(%q<tarvit-helpers>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<rspec>, ["~> 3.2"])
      s.add_dependency(%q<pry>, ["~> 0.10.1"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_dependency(%q<simplecov>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.1"])
    s.add_dependency(%q<fire-model>, ["~> 0.0.15"])
    s.add_dependency(%q<slim-rails>, [">= 0"])
    s.add_dependency(%q<sass-rails>, [">= 0"])
    s.add_dependency(%q<coffee-rails>, [">= 0"])
    s.add_dependency(%q<bootstrap-sass>, [">= 0"])
    s.add_dependency(%q<tarvit-helpers>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<rspec>, ["~> 3.2"])
    s.add_dependency(%q<pry>, ["~> 0.10.1"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
    s.add_dependency(%q<simplecov>, [">= 0"])
  end
end

