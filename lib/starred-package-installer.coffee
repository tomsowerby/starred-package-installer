StarredPackageInstallerView = require './starred-package-installer-view'

module.exports =
  starredPackageInstallerView: null

  activate: (state) ->
    @starredPackageInstallerView = new StarredPackageInstallerView(state.starredPackageInstallerViewState)

  deactivate: ->
    @starredPackageInstallerView.destroy()

  serialize: ->
    starredPackageInstallerViewState: @starredPackageInstallerView.serialize()
