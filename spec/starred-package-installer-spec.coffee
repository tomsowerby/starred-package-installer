{WorkspaceView} = require 'atom'
StarredPackageInstaller = require '../lib/starred-package-installer'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "StarredPackageInstaller", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('starred-package-installer')

  describe "when the starred-package-installer:toggle event is triggered", ->
          
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.starred-package-installer')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'starred-package-installer:run'


      runs ->
        expect(atom.workspaceView.find('.starred-package-installer')).toExist()
